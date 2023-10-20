import psycopg2
import utils

# TODO: validation in 
#        - add_customer


def get_customer(cust_email, cur):
    cur.execute(f"SELECT cust_id, cust_fname, cust_lname, email FROM Customer WHERE email = '{cust_email}'")
    row = cur.fetchone()
    return row

def add_customer(details, cur):
    id, fname, lname, email = details
    cur.execute(f"INSERT INTO Customer (cust_id, cust_fname, cust_lname, email) VALUES ({id},'{fname}', '{lname}', '{email}')") 
    
def get_avg_cust_rating(cust_id, cur):
    cur.execute(f"SELECT avg(cust_rating) FROM Ride WHERE cust_id = {cust_id}")
    return int(cur.fetchone()[0])