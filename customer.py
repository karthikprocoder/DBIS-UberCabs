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


# Customer details ethan.wilson@email.com
cust_email = input("Enter your Email ID: ").strip()

# check if the customer is in database
row = cust_ride.get_customer(cust_email, cur)
# print(row[0])

# if the avg. rating is < 1 then deny service for misconduct
if row and cust_ride.get_avg_cust_rating(int(row[0]), cur) <= 1: 
    utils.service_denied()
    exit()

# if a new customer take in all the required details
while row == None:
    details = utils.prompt_customer_details(cust_email)
    print(details)
    try:
        cust_ride.add_customer(details, cur)
        conn.commit()
        row = details
    except psycopg2.Error as e:
        print(e)
        conn.rollback()
        utils.invalid_credentials_message()


pickup, drop, vehicle, pay_mode = utils.promp_ride_details(utils.avalaible_vehicles)

## car pooling feature


# ask customer to pay the total price

## total price = charge_per_km * distance + tax


""" assign a driver and the car to the customer """
""" use the database and find the drivers who are free """

print("Assigning driver...")


# review the ride 


conn.close()

    


