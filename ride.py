#!/usr/bin/python

import credentials as creds
import psycopg2
import utils
import time

# Connection to UberCabs database
try:
    conn = psycopg2.connect(**creds.db_params)
    cur = conn.cursor()
    print("Welcome")
except psycopg2.Error as e:
    print(f"Database connection error: {e}")


n = int(input("Enter number of passengers.."))
cust_ids = []
car_pool = 'No' if n == 1 else 'Yes'

################## CUSTOMER INFO ###############################

try:
    for i in range(n):
        cust_email = input(f"Enter Email ID for customer {i+1}: ").strip()
        cur.execute(f"SELECT cust_id, cust_fname, cust_lname, email FROM customer WHERE email = '{cust_email}'")
        row = cur.fetchone()
        if row:
            cust_ids.append(row[0])
        else:
            fname, lname, phone = utils.prompt_customer_details()
            id = utils.getId('customer', 'cust_id', cur)
            cust_ids.append(id)
            cur.execute(f"INSERT INTO customer (cust_id, cust_fname, cust_lname, email) VALUES ({id},'{fname}', '{lname}', '{cust_email}')")
            cur.execute(f"INSERT INTO customer_phone VALUES ('{phone}', {id})")
            conn.commit()

except psycopg2.Error as e:
    conn.rollback()
    print(e)
    utils.invalid_credentials_message()



#################### CHOOSE VEHICLE #############################
vehicle = 'Sedan'
cust_pickups = []
cust_drops = []
pay_mode = 'Online'

try:
    cur.execute(f"SELECT vehicle_type FROM vehicle_generics WHERE capacity >= {n} AND vehicle_type IN (select distinct type from vehicle natural join driver where driv_id not in ( select distinct driv_id from ride where status <> 'reached destination'))")
    rows = cur.fetchall()

    if rows == None:
        print("Sorry no service available at the moment.\nTry again after some time")
        exit()

    available_vehicles = [r[0] for r in rows]
    vehicle = utils.prompt_vehicle_details(available_vehicles)

    for i in range(n):
        if i:
            pickup, drop = utils.promp_ride_details()
        else:
            pickup, drop, pay_mode = utils.promp_ride_details(True)
        cust_pickups.append(pickup)
        cust_drops.append(drop)

except psycopg2.Error as e:
    print(e)
    conn.rollback()
    print("error: choose vehicle")


#################### ONLINE / CASH PAYMENT #########################
############ the first customer will pay for the ride ##############

# id, pickup-lat, pickup-long
pickup_locations = [[0] * 3] * n
drop_locations = [[0] * 3] * n
dist = 0
driv_id = -1
driv_fname = '###'
vehicle_num_plate = 0
driv_phone = []
pay_status = 'Pending'
tot_amt = 0

try:
    for i in range(n):
        cur.execute(f"SELECT loc_id, latitude, longitude FROM location where street = '{cust_pickups[i]}'")
        row = cur.fetchone()
        if row == None:
            pickup_locations[i][1], pickup_locations[i][2] = utils.get_coordinates()
        else:
            pickup_locations[i][0], pickup_locations[i][1], pickup_locations[i][2] = int(row[0]), float(row[1]), float(row[2])

        cur.execute(f"SELECT loc_id, latitude, longitude FROM location where street = '{cust_drops[i]}'")
        row = cur.fetchone()
        if row == None:
            drop_locations[i][1], drop_locations[i][2] = utils.get_coordinates()
        else:
            drop_locations[i][0], drop_locations[i][1], drop_locations[i][2] = int(row[0]), float(row[1]), float(row[2])
        

        dist = max(0, utils.get_dist(pickup_locations[i][1:], drop_locations[i][1:]))
        
    cur.execute(f"SELECT extra_per FROM vehicle_generics where vehicle_type = '{vehicle}'")
    row = cur.fetchone()
    ext_per = float(row[0])
    tot_amt = utils.get_price(dist)
    tot_amt += ext_per * tot_amt
    print(f"Total amount Rs.{tot_amt}")
    
    if pay_mode == 'Online':
        x = int(input("Enter 1 to make payment: "))
        if x != 1:
            print("No ride booked")
            exit()
        pay_status = 'Completed'        
        print("Processing payment........")
        time.sleep(2)

    cur.execute(f"select driv_id, driv_fname from vehicle natural join driver where type = '{vehicle}' and driv_id not in ( select distinct driv_id from ride where status <> 'reached destination' ) LIMIT 1")
    driver = cur.fetchone()
    if driver == None:
        print(f"Sorry, {vehicle} is not available now..")
        exit()
    
    driv_id , driv_fname = driver
    # ride id
    r_id = utils.getId('ride', 'ride_id', cur)

    # location ids
    for i in range(n):

        cur.execute(f"SELECT latitude, longitude, loc_id FROM location where street = '{cust_pickups[i]}'")
        row = cur.fetchone()
        if row == None:
            pickup_locations[i][0] = utils.getId('location', 'loc_id', cur)
            cur.execute(f"INSERT INTO location (loc_id, latitude, longitude, street) VALUES ({pickup_locations[i][0]}, {pickup_locations[i][1]}, {pickup_locations[i][2]}, '{cust_pickups[i]}')")

        cur.execute(f"SELECT latitude, longitude, loc_id FROM location where street = '{cust_drops[i]}'")
        row = cur.fetchone()
        if row == None:
            drop_locations[i][0] = utils.getId('location', 'loc_id', cur)
            cur.execute(f"INSERT INTO location (loc_id, latitude, longitude, street) VALUES ({drop_locations[i][0]}, {drop_locations[i][1]}, {drop_locations[i][2]}, '{cust_drops[i]}')")

        cur.execute(f"INSERT INTO ride (reserv_time, car_pool, ride_id, status, driv_id, pickup_loc_id, drop_loc_id, cust_id) VALUES (current_timestamp,'{car_pool}', {r_id} ,'on the way', {driv_id}, {pickup_locations[i][0]}, {drop_locations[i][0]}, {cust_ids[i]})")
        
    cur.execute(f"INSERT INTO charges (amount, status, mode_of_payment, ride_id, cust_id) VALUES ({tot_amt}, '{pay_status}', '{pay_mode}', {r_id}, {cust_ids[0]})")
    cur.execute(f"SELECT number_plate from vehicle where driv_id = {driv_id}")
    row = cur.fetchone()
    vehicle_num_plate = row[0]
    cur.execute(f"SELECT phone FROM Driver_phone WHERE driv_id = {driv_id} LIMIT 2")
    rows = cur.fetchall()
    driv_phone = [row[0] for row in rows]
    conn.commit()
    if pay_mode == 'Online':
        print("Payment is successfull")
except psycopg2.Error as e:
    conn.rollback()
    print(e)
    print("online-cash error")
    exit()


print(f"Ride booked!!\nRide Details:")
print(f''' 
Driver: {driv_fname}
Contact: {driv_phone}
Vehicle: {vehicle}
Number Plate: {vehicle_num_plate}
''')


############################ RIDE PICKUP ##############################
try:
    for i in range(n):
        # can add customer name here
        print(f"Cab yet to pickup customer {i + 1}...")
        x = int(input("Press 1 when cab arrives..\n"))
        if i == 0 and pay_status == 'Pending':
            x = int(input(f"Press 1 to pay Rs.{tot_amt}: "))
            if x != 1:
                exit()
            cur.execute(f"UPDATE charges SET status = 'Completed' where ride_id = {r_id} and cust_id = {cust_ids[i]}")
        cur.execute(f"UPDATE ride SET pickup_time = current_timestamp, status = 'ongoing' where ride_id = {r_id} and cust_id = {cust_ids[i]}")
    conn.commit()
except psycopg2.Error as e:
    conn.rollback()
    print(e)
    print("ride-pickup-error")
    exit()

############################ RIDE COMPLETE / FEEDBACK ##############################
try:
    print("Ongoing ride.........")
    for i in range(n):
        x = int(input("Press 1 when cab reaches destination..\n"))
        cur.execute(f"UPDATE ride SET drop_time = current_timestamp, status = 'reached destination' where ride_id = {r_id} and cust_id = {cust_ids[i]}")
        x = int(input("Press 1 if you want to give us some feedback: "))
        if x == 1:
            rev_msg = input("feedback: ")
            driv_rating = int(input("Rate the driver on the scale of 0-5: "))
            cur.execute(f"UPDATE ride SET review = '{rev_msg}', driv_rating = {driv_rating} where ride_id = {r_id} and cust_id = {cust_ids[i]} ")
    conn.commit()
except psycopg2.Error as e:
    print(e)
    conn.rollback()
    print("ride-complete-error")

print("Thank you, have a great day !!")

conn.close()