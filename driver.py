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


# verify driver
driv_id = int(input("Enter your ID: "))

# check if customer's mode of payment
    
# start the ride after payment completed

# update the ride status

# update the drivers commission / pay

# rate the customer



conn.close()

    


