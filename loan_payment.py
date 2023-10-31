import psycopg2
import inquirer
import datetime

# removed tax rate, removed status from loan_payment, removed balance amount
# corrected primary key

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
    conn = psycopg2.connect(database='ubercabs',
        host="localhost",
        user="newuser",
        password="123456",
        port=5432)
except psycopg2.Error as e:
    print(f"Database connection error: {e}")
    exit(-1)

mycursor = conn.cursor()

driv_email = input("Please give your email: ").strip()

mycursor.execute(f"SELECT driv_id from driver where email = '{driv_email}';")
row = mycursor.fetchone()
if row == None:
    print("Account does not exists")
    exit(0)
driv_id = row[0]

mycursor.execute(f"SELECT loan_id, amount, emi_amount, status, unpaid_amount from car_loan where driv_id = {driv_id} and status <> 'Completely paid';")
row = mycursor.fetchone()

if not row:
    print("No outstanding Loan!")
    conn.rollback()
    exit(0)

loan_id = row[0]
loan_amount = row[1]
emi_amount = row[2]
status = row[3]
unpaid_amount = float(row[4])

try:
    payment_amount = float(input("Give payment amount: "))
except:
    print("Invalid Amount")
    conn.rollback()
    exit(1)

mode = pick_option(['Online', 'Cheque', 'Cash'], "Pick Payment Mode")
if mode == "Online":
    gateway = "PayPal"
elif mode == "Cheque":
    gateway = "Bank Transfer"
else:
    gateway = "Cash Payment"

if payment_amount < 0:
    print("Zero payment!")
    conn.rollback()
    exit(0)

new_unpaid_amount = unpaid_amount - payment_amount

if new_unpaid_amount <= 0:
    status = "Completely paid"
else:
    status = "Partially paid"

try:
    mycursor.execute(f"INSERT INTO Loan_payment (timestamp, amount, mode, gateway, driv_id, loan_id) VALUES \
                    ('{datetime.datetime.now()}', {payment_amount}, '{mode}', '{gateway}', {driv_id}, {loan_id})")
    
    mycursor.execute(f"UPDATE Car_loan \
                     SET status = '{status}', unpaid_amount = {new_unpaid_amount} \
                    WHERE loan_id = {loan_id}")
except psycopg2.Error as e:
    conn.rollback()
    print(e)
    exit(1)

conn.commit()
mycursor.close()
conn.close()

print("DONE!")