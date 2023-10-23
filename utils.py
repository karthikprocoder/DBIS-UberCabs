import random
import math

def uber_logo_message():
    pass

def welcome_customer_message(cust_name):
    print(f"We are delighted to see you again {cust_name}!!")

def prompt_customer_details():
    fname = input("Enter your first name: ")
    lname = input("Enter your last name: ")
    phone = input("Enter your phone no.: ")
    return (fname, lname, phone)

def promp_ride_details(available_vehicles):
    pickUp = input("Pick up address: ")
    drop = input("\nDrop address: ")

    prompt = "\nAvailable Vehicles.."
    for i in range(len(available_vehicles)):
        prompt += f"\n{i + 1}. {available_vehicles[i]}"
    prompt += "\n\nEnter a number: "
    type = int(input(prompt))

    pay_mode = int(input("\nMode of payment..\n1. Online\n2. Cash\n\nEnter a number: "))
    pay_mode = 'Online' if pay_mode == 1 else 'Cash'
    return (pickUp, drop, available_vehicles[type - 1], pay_mode)

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

pr_map = {"Auto-Rick" : 3, "Mini" : 3.2, "Sedan" : 3.5, "Van" : 3.5, "SUV" : 4.0, "Premium" : 5.0}
def get_price(dist, type):
    return 10 + math.sqrt(dist) * pr_map[type] // 1
# avalaible_vehicles = [
#     "Auto-Rick",
#     "Mini"
#     "Sedan",
#     "Van",
#     "SUV",
#     "Premium"
# ]