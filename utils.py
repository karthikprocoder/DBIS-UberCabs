import random
import math
import psycopg2

def getId(table, attr, cur):
    while True:
        id = get_random_id()
        cur.execute(f'SELECT * FROM {table} where {attr} = {id}')
        rid = cur.fetchone()
        if rid == None:
            return id;


def uber_logo_message():
    pass

def welcome_customer_message(cust_name):
    print(f"We are delighted to see you again {cust_name}!!")

def prompt_customer_details():
    fname = input("Enter your first name: ")
    lname = input("Enter your last name: ")
    phone = input("Enter your phone no.: ")
    return (fname, lname, phone)

def prompt_vehicle_details(available_vehicles):
    prompt = "\nAvailable Vehicles.."
    for i in range(len(available_vehicles)):
        prompt += f"\n{i + 1}. {available_vehicles[i]}"
    prompt += "\n\nEnter option no.  "
    type = int(input(prompt))
    return available_vehicles[type - 1]

def promp_ride_details(ask_pay = False):
    pickUp = input("Pick up address: ")
    drop = input("\nDrop address: ")
    if ask_pay:
        pay_mode = int(input("\nMode of payment..\n1. Online\n2. Cash\n\n Enter a number: "))
        pay_mode = 'Online' if pay_mode == 1 else 'Cash'
        return (pickUp, drop, pay_mode)
    return (pickUp, drop)

def invalid_credentials_message():
    print("Invalid credentials, please try again..\n")

def service_denied():
    print("Service denied for misconduct")

def get_random_id():
    return random.randint(1, 1000000)

def get_coordinates():
    lat = random.uniform(-90, 90)
    long  = random.uniform(-180, 180)
    return [lat, long]

def get_dist(p1, p2):
    return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])

def get_price(dist):
    return 10 + math.sqrt(dist) // 1
