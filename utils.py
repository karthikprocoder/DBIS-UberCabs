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

def promp_ride_details(available_vehicles):
    pickUp = input("Pick up address: ")
    drop = input("\nDrop address: ")

    prompt = "\nAvailable Vehicles.."
    for i in range(len(available_vehicles)):
        prompt += f"\n{i + 1}. {available_vehicles[i]}"
    prompt += "\n\nEnter a number: "
    type = int(input(prompt))

    pay_mode = int(input("\nMode of payment..\n1. Online\n2. Cash\n\n Enter a number: "))

    return (pickUp, drop, type, pay_mode)

def invalid_credentials_message():
    print("Invalid credentials, please try again..\n")

def service_denied():
    print("Service denied for misconduct")

def get_random_int():
    return random.randint(1, 1000000)



avalaible_vehicles = [
    "Auto-Rick",
    "Mini"
    "Sedan",
    "Van",
    "SUV",
    "Premium"
]