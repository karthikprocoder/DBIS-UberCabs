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


# verify admin
driv_id = int(input("Enter your admin ID: "))




conn.close()

    


