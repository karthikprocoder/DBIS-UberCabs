#!/usr/bin/python

import psycopg2
import credentials as creds
import utils
import datetime
import os
from tabulate import tabulate 

# Connection to UberCabs database
conn = 0
cur = 0

cust_details = {}


def make_conn():
    try:
        conn = psycopg2.connect(**creds.db_params)
        cur = conn.cursor()
        print("Welcome")
    except psycopg2.Error as e:
        print(f"Database connection error: {e}")
        exit(-1)
    return cur, conn

def find_driver_details_with_email(email):
    sql = "SELECT cust_id FROM customer WHERE email = (%s);"
    data = [email, ]
    cur.execute(sql, data)
    res = cur.fetchone()
    return res

def add_customer(cust_email):
    print("You need to register yourself first")
    try:    
        fname, lname, phone, dob = utils.prompt_customer_details()
        dob = datetime.date(*list(map(int, dob.split('-')))) 
        id = utils.getId('customer', 'cust_id', cur)
        cur.execute(f"INSERT INTO customer (cust_id, cust_fname, cust_lname, email, dob) VALUES ({id},'{fname}', '{lname}', '{cust_email}', '{dob}')")
        cur.execute(f"INSERT INTO customer_phone VALUES ('{phone}', {id})")
        conn.commit()
        cust_details["id"] = id;
        print("Registered !!")
    except psycopg2.Error as e:
        conn.rollback()
        utils.invalid_credentials_message()
        exit()
    except ValueError as e:
        conn.rollback()
        utils.invalid_credentials_message()
        exit()
    

def get_ride_history(cust_id):
    try:
        cur.execute(f"SELECT pickup_time, drop_time, car_pool, driv_rating, reserv_time, status FROM ride WHERE cust_id = {cust_id} ORDER BY drop_time DESC LIMIT 10")
        columns = [col[0] for col in cur.description]
        rides = cur.fetchall()
        print(tabulate(rides, headers=columns, tablefmt= 'rounded_outline'))
    except psycopg2.Error as e:
        conn.rollback()
        print("Sorry, something went wrong.")

def add_phone_number(cust_id):
    try:
        phone = input('Enter phone number to add: ')
        cur.execute(f"INSERT INTO customer_phone (phone, cust_id) VALUES ('{phone}', {cust_id})")
        conn.commit()
        print("phone number added successfully !!")
    except psycopg2.Error as e:
        conn.rollback()
        print("Sorry, something went wrong.")    
        print(e);

if __name__ == '__main__':
    cur, conn = make_conn()

    cust_details["email"] = input("Enter your EmailID: ").strip()
    reg = find_driver_details_with_email(cust_details["email"])
    if reg == None:
        add_customer(cust_details["email"])
    else:
        cust_details["id"] = int(reg[0])
        print("Logged in successfully !!")
    
    while True:
        print()
        msg = "Pick an option to check details"
        options = ["book a ride", "view ride history", "add phone number", "exit"]
        data = utils.pick_option(options, msg, "action")
        if data == "book a ride":
            os.system('./ride.py')
        elif data == "view ride history":
            get_ride_history(cust_details["id"])
        elif data == "add phone number":
            add_phone_number(cust_details["id"])
        else:
            break;


    