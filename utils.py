import random
import math
import inquirer
from tabulate import tabulate 
import bcrypt
import getpass

def hash_password(password):
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')

def verify_password(entered_password, stored_password_hash):
    return bcrypt.checkpw(entered_password.encode('utf-8'), stored_password_hash.encode('utf-8'))


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
    fname = input("Enter your first name: ").strip()
    lname = input("Enter your last name: ").strip()
    phone = input("Enter your phone no.: ").strip()
    dob = input("Enter your Date of Birth: ")
    passwd = getpass.getpass("Set your password: ")
    return (fname, lname, phone, dob, hash_password(passwd))

def prompt_vehicle_details(available_vehicles):
    prompt = "\nAvailable Vehicles.."
    for i in range(len(available_vehicles)):
        prompt += f"\n{i + 1}. {available_vehicles[i]}"
    prompt += "\n\nEnter option no.  "
    type = int(input(prompt))
    return available_vehicles[type - 1]

def promp_ride_details():
    pickUp = input("Pick up address: ").strip()
    drop = input("Drop address: ").strip()
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
    return 200 + math.sqrt(dist) // 1

####################################### UI ##############################################

def pick_option(options, msg, attr):
    questions = [
    inquirer.List(attr,
                  message = msg,
                  choices=options,
                  )
    ]
    answers = inquirer.prompt(questions)
    return answers[attr]


# print(hash_password("123456"))