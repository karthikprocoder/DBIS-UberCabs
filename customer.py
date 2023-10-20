#!/usr/bin/python

import credentials as creds
import psycopg2
import utils
from queries import cust_ride

# Connection to UberCabs database
try:
    conn = psycopg2.connect(**creds.db_params)
    cur = conn.cursor()
    print("Welcome")
except psycopg2.Error as e:
    print(f"Database connection error: {e}")


# Customer details
cust_email = input("Enter your Email ID: ")

# check if the customer is in database
row = cust_ride.get_customer(cust_email, cur)

# if the avg. rating is < 1 then deny service for misconduct
if row != None and cust_ride.get_avg_cust_rating(int(row[0])) < 1: 
    utils.service_denied()
    exit()

# if a new customer take in all the required details
while row == None:
    details = utils.prompt_customer_details(cust_email)
    try:
        cust_ride.add_customer(details)
        row = details
    except e:
        cur.rollback()
        utils.invalid_credentials_message()


# pickup point
    

# drop point


# type of vehicle, show available car types

## car pooling feature

# mode of payment

# ask customer to pay the total price

## total price = charge_per_km * distance + tax


""" assign a driver and the car to the customer """
""" use the database and find the drivers who are free """

print("Assigning driver...")


# review the ride 


conn.close()

    


