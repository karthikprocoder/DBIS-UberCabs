#!/usr/bin/python   

import psycopg2
import inquirer
import random
import datetime;
import credentials as creds

# Why loan_payment has field Paypal as only option?
# DETAIL:  Key (driv_id, rev_id)=(5, 5) already exists.
# Added check to car_loan
# added status constraint, unpaid amount

def pick_option(options, msg, attr="action"):
    questions = [
    inquirer.List(attr,
                  message = msg,
                  choices=options,
                  )
    ]
    answers = inquirer.prompt(questions)
    return answers[attr]

try:
    conn = psycopg2.connect(**creds.db_params)
except psycopg2.Error as e:
    print(f"Database connection error: {e}")
    exit(-1)

mycursor = conn.cursor()

# Check if driver exists in the database
driv_email = input("Please give your email: ").strip()
mycursor.execute(f"SELECT driv_id from driver where email = '{driv_email}';")
row = mycursor.fetchone()
if row == None:
    while True:
        id = random.randint(1, 1000000)
        mycursor.execute(f'SELECT * FROM Guarantor where guarantor_id = {id}')
        rid = mycursor.fetchone()
        if rid == None:
            break;
    driv_id = id
    driv_fname = input("Driver's First Name: ").strip()
    driv_lname = input("Driver's Last Name: ").strip()
    phone_number = input("Give Phone number: ").strip()
    try:
        dob_year = int(input("Birth Year: ").strip())
        dob_month = int(input("Birth Month: ").strip())
        dob_day = int(input("Birth Day: ").strip())
        if datetime.date.today().year - dob_year < 18:
            print("Minor")
            exit(1)
        dob = datetime.date(dob_year, dob_month, dob_day)
        driv_lic_num = input("Driving License Number: ").strip()
        commission_rate = input("Commision rate: ")

        mycursor.execute(f"SELECT loc_id from location;")

        locations = [i[0] for i in mycursor.fetchall()]
        loc_id = pick_option(locations, "Choose your Location:")
    except:
        print("Wrong Input")
        exit(1)
    date_of_join = datetime.date.today()
    try:
        mycursor.execute(f"INSERT INTO Driver (driv_id, driv_fname, driv_lname, email, dob, date_of_join, driv_lic_num, commission_rate, loc_id) VALUES\
                         ({driv_id}, '{driv_fname}', '{driv_lname}', '{driv_email}', '{dob}', '{date_of_join}', '{driv_lic_num}',\
                            {commission_rate}, {loc_id});")
        mycursor.execute(f"INSERT INTO Driver_phone (phone, driv_id) VALUES \
                         ('{phone_number}', {driv_id});")
    except psycopg2.Error as e:
        conn.rollback()
        print(e)
        exit(1)
else:
    driv_id = row[0]

# Check if driver has an active loan from Uber
mycursor.execute(f"SELECT status from car_loan where driv_id={driv_id} and status <> 'Completely paid';")
temp = mycursor.fetchall()
if len(temp) != 0:
        print("There is an unpaid loan!")
        exit(0)

mycursor.execute(f"SELECT rev_fname,rev_lname,rev_id from reviewer;")
temp = mycursor.fetchall()
reviewers = [f"{i[-1]} : " + " ".join(i[:-1]) for i in temp]
rev_ids = [i[-1] for i in temp]
rev_name = pick_option(reviewers, "Choose your reviewer")
rev_index = reviewers.index(rev_name)
rev_id = rev_ids[rev_index]
try:
    mycursor.execute(f"INSERT INTO verify (pay_timestamp, driv_id, rev_id) VALUES ('{datetime.datetime.now()}', {driv_id}, {rev_id});")
except psycopg2.Error as e:
    print(f"Error occured while ading verification date \n{e}")
    conn.rollback()
    exit(1)

print("Verification Done!\n")

print("Give verification details:\n")

mycursor.execute(f"SELECT vehicle_type from Vehicle_generics;")
types = [i[0] for i in mycursor.fetchall()]

reg_num = input("Registration Number: ").strip()
chassis_num = input("Chassis number: ").strip()
puc_num = input("PUC Num: ").strip()
number_plate = input("Number Plate: ").strip()
model = input("Model: ").strip()
company = input("Company: ").strip()
type = pick_option(types, "Pick Type:")
ownership = "Loaned"

mycursor.execute(f"SELECT * from vehicle where chassis_num='{chassis_num}';")
temp = mycursor.fetchall()
if len(temp) != 0:
    print("Vehicle already exists!")
    exit(1)
try:
    mycursor.execute(f"INSERT INTO vehicle (registration_num, chassis_num, puc_num, number_plate, model, company, type, ownership, driv_id) VALUES ('{reg_num}',\
                    '{chassis_num}', '{puc_num}', '{number_plate}', '{model}', '{company}', '{type}', '{ownership}', {driv_id});")
except psycopg2.Error as e:
    print(f"Got Error as {e}")
    conn.rollback()
    exit(1)

print("\nGive details of your Guarantor:\n")

gur_mail = input("Enter Guarantor email id: ").strip()
mycursor.execute(f"SELECT guarantor_id FROM Guarantor where guarantor_email = '{gur_mail}';")
temp = mycursor.fetchone()
if temp:
    gur_id = temp[0]
else:
    while True:
        id = random.randint(1, 1000000)
        mycursor.execute(f'SELECT * FROM Guarantor where guarantor_id = {id}')
        rid = mycursor.fetchone()
        if rid == None:
            break;
    gur_id = id
    guarantor_fname = input("Guarantor First Name: ").strip()
    guarantor_lname = input("Guarantor Last Name: ").strip()
    phone_number = input("Give Guarantor phone number: ").strip()

    mycursor.execute(f"SELECT loc_id from location;")
    locations = [i[0] for i in mycursor.fetchall()]
    loc_id = pick_option(locations, "Choose your Location:")
    try:
        mycursor.execute(f"INSERT INTO Guarantor (guarantor_id, guarantor_fname, guarantor_lname, guarantor_email, loc_id) VALUES \
                        ({gur_id}, '{guarantor_fname}', '{guarantor_lname}', '{gur_mail}', {loc_id});")
    except psycopg2.Error as e:
        conn.rollback()
        print(e)
        exit(1)

    try:
        mycursor.execute(f"INSERT INTO Guarantor_guarantor_phone (guarantor_phone, guarantor_id) VALUES \
                ('{phone_number}', {gur_id});")
    except psycopg2.Error as e:
        conn.rollback()
        print(e)
        exit(1)

print("\nGive details of the Loan:\n")

amount = input("Give loan amount: ")
interest_rate = input("Give interest rate: ")
tenure = input("Give tenure: ")
emi_amount = input("Give emi_amount: ")
status = "Zero installments"

while True:
        id = random.randint(1, 1000000)
        mycursor.execute(f'SELECT * FROM car_loan where loan_id = {id}')
        rid = mycursor.fetchone()
        if rid == None:
            break;

loan_id = id

try:
    mycursor.execute(f"INSERT INTO Car_loan (amount, unpaid_amount, interest_rate, tenure, emi_amount, status, loan_id, driv_id, guarantor_id, chassis_num) VALUES\
                     ({amount}, {amount}, {interest_rate}, {tenure}, {emi_amount}, '{status}', {loan_id}, {driv_id}, {gur_id}, '{chassis_num}');")
except psycopg2.Error as e:
    conn.rollback()
    print(e)
    exit(1)

conn.commit()
mycursor.close()
conn.close()

print("DONE!")