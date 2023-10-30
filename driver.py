#!/usr/bin/python


import datetime
from numpy import average
import credentials as creds
import psycopg2
import inquirer
from tabulate import tabulate 
# Connection to UberCabs database
conn = 0
cur = 0

def make_conn():
    try:
        conn = psycopg2.connect(**creds.db_params)
        cur = conn.cursor()
        print("Welcome")
    except psycopg2.Error as e:
        print(f"Database connection error: {e}")
        exit(-1)
    return cur, conn

def pick_option(options, msg, attr):
    questions = [
    inquirer.List(attr,
                  message = msg,
                  choices=options,
                  )
    ]
    answers = inquirer.prompt(questions)
    return answers[attr]

def check_driver(driv_id):
    sql = f'SELECT * FROM driver WHERE driv_id = {driv_id}'
    cur.execute(sql)
    if (cur.fetchall()==[]):
        print ("given driver id does not exist")
        return 0
    return 1
def check_location(loc_id):
    sql = f'SELECT * FROM location WHERE loc_id = {loc_id}'
    cur.execute(sql)
    if (cur.fetchall()==[]):
        print ("given location id does not exist : ")
        return 0
    return 1

def find_driver_details_with_email(email):
    sql = "SELECT * FROM Driver WHERE email = (%s);"
    data = [email, ]
    cur.execute(sql, data)
    res = cur.fetchall()
    if (len(res)==0):
        return -1
    else:
        return res
     
def fill_driver_data(driver_data, driver_details):
    cur.execute('SELECT * FROM driver LIMIT 0')
    cur.fetchall()
    columns = [desc[0] for desc in cur.description]    
    new_driver_details = dict(zip(columns, driver_data[0]))
    driver_details.update(new_driver_details)
    
def add_location(): 
    print("\n Add Location Details.............")
    cur.execute('SELECT * FROM location LIMIT 0')
    cur.fetchall()
    columns = [desc[0] for desc in cur.description]
    location_details = {}
    for attr in columns:
        data = input(f"Enter the value for {attr} : ").strip()
        if (attr in ['latitude', 'longitude']):
            data = float(data)  
        elif (attr in ['loc_id']):
            cur.execute("SELECT max(loc_id) FROM location")
            data = cur.fetchall()[0][0] + 1
            print("alloted location id :",data)  
        location_details[attr] = data
    sql = f"INSERT INTO location VALUES (%s ,%s, %s, %s, %s, %s, %s, %s, %s)"
    data = list(location_details.values())
    try:  
        cur.execute(sql, data)
        conn.commit()
    except psycopg2.Error as e:
        print(e)
        exit(-2)
    return location_details['loc_id']

def add_vehicle(driv_id):
    print("\n Add Vehicle Details.............")
    cur.execute('SELECT * FROM Vehicle LIMIT 0')
    cur.fetchall()
    columns = [desc[0] for desc in cur.description]
    vehicle_details = {}
    data = 0
    for attr in columns:
        msg = f"Enter the value for {attr} : "
        # if (attr in ['capacity']):
        #     data = input(msg).strip()
        #     data = int(data)
        if (attr in ['driv_id']):
            data = driv_id  
        elif (attr == 'type'):
            data = pick_option(['Auto-Rick', 'Mini', 'Sedan', 'Van', 'SUV', 'Premium'], msg, attr)
        elif (attr == 'ownership'):
            data = pick_option(['Personal', 'Rented', 'Loaned'], msg, attr)
        else:
            data = input(msg).strip()
        vehicle_details[attr] = data
    sql = f"INSERT INTO vehicle VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
    data = list(vehicle_details.values())
    try:  
        cur.execute(sql, data)
    except psycopg2.Error as e:
        print(e)
        exit(-2)
    # cur.execute(f"Select * from vehicle where driv_id = {vehicle_details['driv_id']}")
    # print(cur.fetchall())

def add_phone(driv_id):
    print("\n Add Phone Details.............")
    cur.execute('SELECT * FROM driver_phone LIMIT 0')
    cur.fetchall()
    columns = [desc[0] for desc in cur.description]
    phone_details = {}
    data = 0
    for attr in columns:
        if (attr in ['driv_id']):
            data = driv_id
        else:  
            data = input(f"Enter the value for {attr} : ").strip()
        phone_details[attr] = data
    sql = f"INSERT INTO driver_phone VALUES (%s, %s)"
    data = list(phone_details.values())
    try:  
        cur.execute(sql, data)
        conn.commit()
    except psycopg2.Error as e:
        print(e)
        exit(-2)

def add_driver(driver_details_):
    print("\n Add Driver Details.............")
    cur.execute('SELECT * FROM driver LIMIT 0')
    cur.fetchall()
    columns = [desc[0] for desc in cur.description]
    driver_details = {}
    for attr in columns:
        data = input(f"Enter the value for {attr} : ").strip()
        if (attr in ['loc_id']):
            data = int(data)
            if (check_location(data)==0):
                if (input("Add a new location (y/n) : ").strip()=='y'):
                    data = add_location()
                else: 
                    return
        elif (attr in ['dob', 'date_of_join']): 
            data = datetime.date(*list(map(int, data.split())))
        elif (attr in ['commission_rate']):
            data = 0.1
            print("alloted commission rate :", data) 
        elif (attr in ['driv_id']):
            cur.execute("SELECT max(driv_id) FROM driver")
            data = cur.fetchall()[0][0] + 1
            print("alloted driver id :",data)
        driver_details[attr] = data
    # print(driver_details)
    sql = f"INSERT INTO driver VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
    data = list(driver_details.values())
    try:  
        cur.execute(sql, data)
    except psycopg2.Error as e:
        print(e)
        exit(-2)
    # cur.execute(f"Select * from driver where driv_id = {driver_details['driv_id']}")
    # print(tabulate(cur.fetchall(), headers=[desc[0] for desc in cur.description], tablefmt='rounded_grid'))
    driver_details_.update(driver_details)

def get_earning(driv_id, num = -1):
    if (check_driver(driv_id)==0):
        return
    sql = f"""
            SELECT reserv_time, earning, 
            CASE WHEN earning IS NULL THEN 'Pending'
            ELSE 'Completed'
            END AS status
            FROM ride NATURAL LEFT OUTER JOIN commission WHERE ride.driv_id = {driv_id}
            ORDER BY reserv_time
    """
    if (num!=-1):
        sql += f" LIMIT {num}"
    try:
        cur.execute(sql)
        conn.commit()
    except psycopg2.errors as e:
        print(e)
        exit(0)
    columns = [desc[0] for desc in cur.description]
    commissions = cur.fetchall()
    heading = "\nEarning Details " 
    if (num!=-1):
        heading = heading + f"(previous {num})" 
    else:
        heading = heading + '(all)'
    print(heading)
    if (len(commissions)==0):
        print ("no records of earning available, check pending payments")
    else:
        print(tabulate(commissions, headers=columns, tablefmt= 'rounded_outline'))
    total_earning = [earn for _, earn, s in commissions if earn!=None]
    if (len(total_earning)!=0 and num == -1):
        print("Total Earning : ", sum(total_earning))
        print("Numbers of payments : ", len(total_earning))
        print("Average Earning : ", average(total_earning))


def get_ride_history(driv_id, latest = False):
    if (check_driver(driv_id)==0):
        return
    
    sql = f'SELECT pickup_time, drop_time, car_pool, driv_rating, reserv_time, status FROM ride WHERE driv_id = {driv_id} ORDER BY drop_time DESC'
    if (latest):
        sql = f'SELECT pickup_time, drop_time, car_pool, driv_rating, reserv_time, status FROM ride WHERE driv_id = {driv_id} ORDER BY drop_time DESC LIMIT 1'
        
    try:
        cur.execute(sql)
    except psycopg2.errors as e:
        print(e)
        exit(0)
    columns = [desc[0] for desc in cur.description]
    rides = cur.fetchall()
    if (latest):
        print("\nCurrent Ride Details :")
    else:
        print("\nRide Details :")
    if (len(rides)==0):
        print ("no records of rides available")
    else:
        print(tabulate(rides, headers=columns, tablefmt= 'rounded_outline'))

def get_path_for_current(driv_id):
    sql = f"SELECT pickup_time, drop_time, reserv_time, pickup_loc_id, drop_loc_id FROM ride WHERE driv_id = {driv_id} AND status <> 'reached destination' LIMIT 1"    
    try:
        cur.execute(sql)
    except psycopg2.errors as e:
        print(e)
        exit(0)
    columns = [desc[0] for desc in cur.description]
    current_ride = cur.fetchall()
    print("Details for current ride and path")
    if (len(current_ride)==0):
        print("There are no ongoing rides")
        return [-1, -1, -1]
    else:
        print(tabulate(current_ride, headers=columns, tablefmt= 'rounded_outline'))
        sql1 = f"SELECT * FROM location WHERE loc_id = {current_ride[0][-2]}"    
        sql2 = f"SELECT * FROM location WHERE loc_id = {current_ride[0][-1]}"    
        loc1 = ['pickup']
        loc2 = ['drop']
        try:
            cur.execute(sql1)
            loc1.extend(cur.fetchall()[0])
            cur.execute(sql2)
            loc2.extend(cur.fetchall()[0])
        except psycopg2.errors as e:
            print(e)
            exit(0) 
        columns = ['type']
        columns.extend([desc[0] for desc in cur.description])
        rows = [loc1, loc2]
        print(tabulate(rows, headers=columns, tablefmt= 'rounded_outline'))
        
        sql = f"SELECT ride_id, cust_id, status FROM ride WHERE driv_id = {driv_id} AND status <> 'reached destination' "    
        try:
            cur.execute(sql)
        except psycopg2.errors as e:
            print(e)
            exit(0)
        return cur.fetchone()
    
        
def get_info(driver_details):
    print('\nDriver Details')
    cur.execute(f"Select * from driver where driv_id = {driver_details['driv_id']}")
    print(tabulate(cur.fetchall(), headers=[desc[0] for desc in cur.description], tablefmt='rounded_grid'))
   
    print('\nVehicle Details')
    cur.execute(f"Select * from Vehicle where driv_id = {driver_details['driv_id']}")
    print(tabulate(cur.fetchall(), headers=[desc[0] for desc in cur.description], tablefmt='rounded_grid'))
    
    print('\nLocation Details')
    cur.execute(f"Select * from location where loc_id = {driver_details['loc_id']}")
    print(tabulate(cur.fetchall(), headers=[desc[0] for desc in cur.description], tablefmt='rounded_grid'))
    
    print('\nPhone Details')
    cur.execute(f"Select * from driver_phone where driv_id = {driver_details['driv_id']}")
    print(tabulate(cur.fetchall(), headers=[desc[0] for desc in cur.description], tablefmt='rounded_grid'))
    
def interactive(driver_details):
    options = ['get customer','pick customer','add tracking','exit']
    cust_id = 0
    ride_id = 0
    status = -1
    while (True):
        data = pick_option(options, 'Select an option', '')
        if (data == options[0]):
            ride_id, cust_id, status = get_path_for_current(driver_details['driv_id'])
        elif (data == options[1]):
            if (status == 'on the way'):
                while(True):
                    if (input('pick customer (y/N) :')=='y'):
                        sql = f"UPDATE ride SET pickup_time = current_timestamp, status = 'ongoing' where ride_id = {ride_id} and cust_id = {cust_id}"
                        try:
                            cur.execute(sql)
                            conn.commit()
                        except psycopg2.Error as e:
                            print(e)
                            exit(-1)
                        status = 'ongoing'
                        break
            elif (status == 'ongoing'):
                print('customer already picked')
            else:
                print("No customers to pick")
        elif (data == options[2]):
            if (status == 'ongoing'):
                print("add tracking")
            else:
                print('pick the customer first')
        elif (data == options[3]):
            return
                
                        
            
        
   
if __name__ == '__main__': 
    """
    driver dashborad
    """
    cur, conn = make_conn()
    driver_details = {}

    driver_details["email"] = input("Enter driver's email : ").strip()
    is_new = False
    driver_data = find_driver_details_with_email(driver_details["email"])
    if (driver_data==-1):
        if (input("Add a new driver (y/n) : ").strip()=='y'):
            is_new = True
        else:
            exit(0)
    else:
        fill_driver_data(driver_data, driver_details)
    if (is_new):
        # add_location()
        add_driver(driver_details)
        add_vehicle(driver_details['driv_id'])
        if (input("Add a phone number (y/n) : ").strip()=='y'):
            add_phone(driver_details['driv_id'])
        pass
    # print(driver_details)
    
    while(1):
        msg = "Pick an options to check details"
        options = ['personal details','all earnings', 'last n earnings', 'ride_history', 'latest ride details ', 'path for current ride','interactive mode', 'exit']
        data = pick_option(options, msg, "action")
        if (data == options[0]):
            get_info(driver_details)
        elif (data == options[1]):
            get_earning(driver_details['driv_id'])
        elif (data == options[2]):
            n = int(input("enter value for n "))
            if (n<=0):
                n = -1
            get_earning(driver_details['driv_id'], n)
        elif (data == options[3]):
            get_ride_history(driver_details['driv_id'])
        elif (data == options[4]):
            get_ride_history(driver_details['driv_id'], True)
        elif (data == options[5]):      
            get_path_for_current(driver_details['driv_id'])
        elif (data == options[6]):
            interactive(driver_details)
        elif (data == options[7]):
            exit(0)
        print('____________________________________________________________________________________________________________________________________________________')
    