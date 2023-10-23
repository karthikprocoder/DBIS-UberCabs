#!/usr/bin/python

import credentials as creds
import psycopg2
import utils

# Connection to UberCabs database
try:
    conn = psycopg2.connect(**creds.db_params)
    cur = conn.cursor()
    print("Welcome")
except psycopg2.Error as e:
    print(f"Database connection error: {e}")


# Customer details ethan.wilson@email.com
cust_email = input("Enter your Email ID: ").strip()
try:
    cur.execute(f"SELECT cust_id, cust_fname, cust_lname, email FROM customer WHERE email = '{cust_email}'")
    row = cur.fetchone()
except psycopg2.Error as e:
    conn.rollback()


# if a new customer take in all the required details
if row == None:
    fname, lname, phone = utils.prompt_customer_details()
    try:
        while True:
            id = utils.get_random_id()
            cur.execute(f'SELECT * FROM customer where cust_id = {id}')
            rid = cur.fetchone()
            if rid == None:
                break;

        cur.execute(f"INSERT INTO customer (cust_id, cust_fname, cust_lname, email) VALUES ({id},'{fname}', '{lname}', '{cust_email}')")
        cur.execute(f"INSERT INTO customer_phone VALUES ('{phone}', {id})")
        conn.commit()
    except psycopg2.Error as e:
        conn.rollback()
        print(e)
        utils.invalid_credentials_message()
        exit()

else:
    id = row[0]

# get available vehicles
try:
    cur.execute(f"select distinct type from vehicle natural join driver where driv_id not in ( select distinct driv_id from ride where status <> 'reached destination' )")
    available_vehicles_rows = cur.fetchall()
    i = 1
    avail_veh = []
    for v_row in available_vehicles_rows:
        avail_veh.append(v_row[0])
    if avail_veh:
        pickup, drop, vehicle, pay_mode = utils.promp_ride_details(avail_veh)
    else:
        print("Sorry no service available at the moment.\nTry again after some time")
        exit()
except psycopg2.Error as e:
    conn.rollback()
    print('error')

### car pooling feature
'''
one customer will enter data for all the customers
customers may have different locations

'''

# print("Car pool with friends ?")
# car_pool = input("(Yes/No): ")

# if car_pool == 'Yes':
#     # get vehicle capacity
#     cur.execute("")



# ask customer to pay the total price also check if driver is available
try:
    p1 = [0] * 2
    p2 = [0] * 2
    pickup_loc_id, drop_loc_id = -1, -1
    cur.execute(f"SELECT latitude, longitude, loc_id FROM location where street = '{pickup}'")
    r1 = cur.fetchone()
    cur.execute(f"SELECT latitude, longitude, loc_id FROM location where street = '{drop}'")
    r2 = cur.fetchone()
    if r1 == None:
        p1 = utils.get_coordinates()
    else:
        p1[0] = float(r1[0])
        p1[1] = float(r1[1])
        pickup_loc_id = r1[2]
    if r2 == None:
        p2 = utils.get_coordinates()
    else:
        p2[0] = float(r2[0])
        p2[1] = float(r2[1])
        drop_loc_id = r2[2] 
    dist = utils.get_dist(p1, p2)
    price = utils.get_price(dist, vehicle)
    print(f"Total amount: Rs. {price}")
    pay_status = 'Pending'
    if pay_mode == 'Online':
        x = int(input("Enter 1 to make payment: "))
        if x != 1:
            print("No ride booked")
            exit()
        pay_status = 'Completed'
    cur.execute(f"select driv_id, driv_fname from vehicle natural join driver where type = '{vehicle}' and driv_id not in ( select distinct driv_id from ride where status <> 'reached destination' ) LIMIT 1")
    driver = cur.fetchone()
    cur.execute(f"SELECT latitude, longitude, loc_id FROM location where street = '{pickup}'")
    r1 = cur.fetchone()
    cur.execute(f"SELECT latitude, longitude, loc_id FROM location where street = '{drop}'")
    r2 = cur.fetchone()
    if driver:
        while True:
            r_id = utils.get_random_id()
            cur.execute(f'SELECT * FROM ride where ride_id = {r_id}')
            rid = cur.fetchone()
            if rid == None:
                break;
        while r1 == None:
            pickup_loc_id = utils.get_random_id()
            cur.execute(f'SELECT * FROM location where loc_id = {pickup_loc_id}')
            lid = cur.fetchone()
            if lid == None:
                break;
        while r2 == None:
            drop_loc_id = utils.get_random_id()
            cur.execute(f'SELECT * FROM location where loc_id = {drop_loc_id}')
            lid = cur.fetchone()
            if lid == None:
                break;
        drive_name = driver[1]
        driv_id = driver[0]
        if r1 == None:
            cur.execute(f"INSERT INTO location (loc_id, latitude, longitude, street) VALUES ({pickup_loc_id}, {p1[0]}, {p1[1]}, '{pickup}')")
        if r2 == None:
            cur.execute(f"INSERT INTO location (loc_id, latitude, longitude, street) VALUES ({drop_loc_id}, {p2[0]}, {p2[1]}, '{drop}')")
        cur.execute(f"INSERT INTO ride (reserv_time, ride_id, status, driv_id, pickup_loc_id, drop_loc_id, cust_id) VALUES (current_timestamp, {r_id} ,'on the way', {driv_id}, {pickup_loc_id}, {drop_loc_id}, {id})")
        cur.execute(f"INSERT INTO charges (amount, status, mode_of_payment, ride_id, cust_id) VALUES ({price}, '{pay_status}', '{pay_mode}', {r_id}, {id})")
        cur.execute(f"SELECT number_plate from vehicle where driv_id = {driv_id}")
        num_row = cur.fetchone()
        cur.execute(f"SELECT phone FROM Driver_phone WHERE driv_id = {driv_id} LIMIT 2")
        phone_nums = cur.fetchall()
        driv_contact = [row[0] for row in phone_nums]
        number_plate = num_row[0]
        conn.commit()
    else:
        print(f"Sorry, {vehicle} is not available now..")
        exit()
except psycopg2.Error as e:
    print(e)
    conn.rollback()
    exit()




print(f"Ride booked!!\nRide Details:")
print(f''' 
Driver: {drive_name}
Contact: {driv_contact}
Vehicle: {vehicle}
Number Plate: {number_plate}
''')


x = 0
while x != 1:
    print("\nYour Cab is on the way..........")
    x = int(input("Press 1 when cab arrives..\n"))

if pay_mode == 'Cash':
    x = int(input(f"Press 1 to pay Rs.{price}: "))
    if x != 1:
        # ban customer
        pass

try:
    cur.execute(f"UPDATE ride SET pickup_time = current_timestamp, status = 'ongoing' where ride_id = {r_id} and cust_id = {id}")
    cur.execute(f"UPDATE charges SET status = 'Completed' where ride_id = {r_id} and cust_id = {id}")
    conn.commit()
except psycopg2.Error as e:
    print("Connection error..")
    exit()

'''
ride tracking feature
'''

# review the ride, default 5

x = 0
while x != 1:
    print("\nOngoing ride..........")
    x = int(input("Press 1 when cab reaches destination..\n"))


try:
    cur.execute(f"UPDATE ride SET drop_time = current_timestamp, status = 'reached destination' where ride_id = {r_id} and cust_id = {id}")
    conn.commit()
except psycopg2.Error as e:
    print(e)
    conn.rollback()

x = int(input("Press 1 if you want to give us some feedback: "))

if x == 1:
    rev_msg = input("feedback: ")
    driv_rating = int(input("Rate the driver on the scale of 0-5: "))
    try:
        cur.execute(f"UPDATE ride SET review = '{rev_msg}', driv_rating = {driv_rating} where ride_id = {r_id} and cust_id = {id} ")
        conn.commit()
    except psycopg2.Error as e:
        print("Sorry some error occured.")
        print(e)
conn.close()

    