import random


def uber_logo_message():
    pass

def welcome_customer_message(cust_name):
    print(f"We are delighted to see you again {cust_name}!!")

def prompt_customer_details(email):
    fname = input("Enter your first name")
    lname = input("Enter your last name")
    # need to validate cust_id
    return (get_random_int(), fname, lname, email)

def invalid_credentials_message():
    print("Invalid credentials, please try again..\n")

def service_denied():
    print("Service denied for misconduct")

def get_random_int():
    return random.randint(1, 1000000)