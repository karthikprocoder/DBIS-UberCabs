import psycopg2
from tabulate import tabulate
import inquirer

# Connection to UberCabs database
try:
    conn = psycopg2.connect(database='uberCabs',
                            host="localhost",
                            user="postgres",
                            password="adipgadmin@1101",
                            port=5432)
    cur = conn.cursor()
    print("Welcome")
except psycopg2.Error as e:
    print(f"Database connection error: {e}")

def pick_option(options, msg, attr):
    questions = [
    inquirer.List(
            attr,
            message = msg,
            choices = options,
        )
    ]
    answers = inquirer.prompt(questions)
    return answers[attr]

def get_revenue():
    print("Total Revenue:")
    cur.execute("""SELECT * FROM Total_revenue""")
    r = cur.fetchall()
    print('Rs.', float(r[0][0]), '\n')

def get_avg_driv_rating():
    print("Average rating of drivers:")
    cur.execute("""SELECT Ride.driv_id AS Driver_ID, CONCAT_WS(' ', driv_fname, driv_lname) AS Driver_name, AVG(driv_rating) AS Driver_Average_Rating
                FROM Ride NATURAl JOIN Driver
                WHERE status = 'reached destination'
                GROUP BY Driver_ID, Driver_name
                ORDER BY Driver_Average_Rating DESC""")
    columns=['Driver ID', 'Driver name', 'Average Rating']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Driver ID', 'Average Rating'])
    # print(df, '\n')

def get_avg_wait_time():
    print("Average Waiting Time for a driver:")
    cur.execute("""SELECT driv_id AS Driver_ID, CONCAT_WS(' ', driv_fname, driv_lname) AS Driver_name, 
                AVG(date_part('minutes', pickup_time - reserv_time)) AS Booking_Pickup_delay
                FROM Ride NATURAL JOIN Driver 
                GROUP BY driv_id, Driver_name
                ORDER BY Booking_Pickup_delay DESC""")
    columns=['Driver ID', 'Driver Name', 'Average Waiting Time(in mins)']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Driver ID', 'Driver Name', 'Average Waiting Time(in mins)'])
    # print(df, '\n')

def get_cust_pay_status():
    print("Payment status of customer:")
    cur.execute("""SELECT * FROM Cust_payment_status""")
    columns=['Customer ID', 'Customer Name', 'Ride ID', 'Amount(in Rs)', 'Booking Time', 'Pickup Location', 'Drop Location', 'Payment Status']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Customer ID', 'Customer Name', 'Ride ID', 'Amount(in Rs)', 'Booking Time', 'Pickup Location', 'Drop Location', 'Payment Status'])
    # print(df.to_string(), '\n')

def get_pending_payments():
    print("Number of pending payments for customers:")
    cur.execute("""SELECT Charges.cust_id, CONCAT_WS(' ', cust_fname, cust_lname) AS Customer_name, COUNT(*) AS Number_of_Pending_Payments
                FROM Charges NATURAL JOIN Customer
                WHERE status = 'Pending'
                GROUP BY cust_id, Customer_name""")
    columns=['Customer ID', 'Customer name', 'Number of pending payments']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Customer ID', 'Number of pending payments'])
    # print(df, '\n')

def get_driv_comm_rate():
    print("Commission rates of drivers:")
    cur.execute("""SELECT driv_id AS Driver_ID, CONCAT_WS(' ', driv_fname, driv_lname) AS Driver_name, 
                commission_rate 
                FROM Driver
                ORDER BY commission_rate DESC""")
    columns=['Driver ID', 'Driver Name', 'Commission Rate(factor)']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Driver ID', 'Driver Name', 'Commission Rate(factor)'])
    # print(df, '\n')

def get_popular_rides():
    print("Popular Rides:")
    cur.execute("""SELECT type AS Vehicle_Type, COUNT(*) AS Number_of_Rides
                FROM Ride NATURAL JOIN Vehicle
                GROUP BY type
                ORDER BY COUNT(*) DESC""")
    columns=['Vehicle Type', 'Number of Rides']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Vehicle Type', 'Number of Rides'])
    # print(df, '\n')

def get_rides_per_day():
    print("Total Rides per Day:")
    cur.execute("""SELECT * FROM Total_rides_per_day""")
    columns=['Date', 'Number of Rides']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Date', 'Number of Rides'])
    # print(df, '\n')

def get_pop_pickup_loc():
    print("Popular Pickup Locations:")
    cur.execute("""SELECT Ride.pickup_loc_id, street, COUNT(*) AS pickup_count
                FROM Ride, Location
                WHERE Ride.pickup_loc_id = Location.loc_id
                GROUP BY pickup_loc_id, street
                ORDER BY pickup_count DESC""")
    columns=['Pickup Location ID', 'Pickup Location', 'Number of Rides from this location']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Pickup Location', 'Number of Rides from this location'])
    # print(df, '\n')

def get_pop_drop_loc():
    print("Popular Drop Locations:")
    cur.execute("""SELECT drop_loc_id, street, COUNT(*) AS drop_count
                FROM Ride, Location
                WHERE Ride.drop_loc_id = Location.loc_id
                GROUP BY drop_loc_id, street
                ORDER BY drop_count DESC""")
    columns=['Drop Location ID', 'Drop Location', 'Number of Rides ending at this location']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Drop Location', 'Number of Rides ending at this location'])
    # print(df, '\n')

def get_driv_earn():
    print("Driver Earnings:")
    cur.execute("""SELECT driv_id, SUM(commission_rate * amount) AS Earnings
                FROM (Driver NATURAL JOIN Ride) JOIN Charges USING (ride_id, cust_id)
                GROUP BY driv_id
                ORDER BY Earnings DESC""")
    columns=['Driver ID', 'Earnings(in Rs)']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Driver ID', 'Earnings(in Rs)'])
    # print(df, '\n')

def get_rev_by_loc():
    print("Revenue by City / Pickup Location:")
    cur.execute("""SELECT * FROM Revenue_by_location""")
    columns=['Pickup Location', 'Revenue from this location(in Rs)']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Pickup Location', 'Revenue from this location(in Rs)'])
    # print(df, '\n')

def get_payment_method():
    print("Payment Method Distribution:")
    cur.execute("""SELECT mode_of_payment, COUNT(Ride.ride_id) AS Num_Rides
                FROM Ride, Charges 
                WHERE Ride.ride_id = Charges.ride_id AND 
                Ride.cust_id = Charges.cust_id
                GROUP BY mode_of_payment
                ORDER BY Num_Rides DESC""")
    columns=['Mode of payment', 'Number of Rides']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Mode of payment', 'Number of Rides'])
    # print(df, '\n')

def get_driv_loan_details():
    print("Loan details of Drivers:")
    cur.execute("""SELECT lp.driv_id, lp.loan_id, chassis_num, lp.amount, balance_amt, emi_amount, lp.status
                FROM Car_loan AS cl, Loan_payment AS lp
                WHERE cl.amount = lp.amount AND
                cl.loan_id = lp.loan_id AND
                cl.driv_id = lp.driv_id
                ORDER BY balance_amt DESC""")
    columns=['Driver ID', 'Loan ID', 'Vehicle Chassis Number', 'Loan Amount(in Rs)', 'Balance Amount(in Rs)', 'EMI Amount(in Rs)', 'Loan Payment Status']
    print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')
    # r = cur.fetchall()
    # df = pd.DataFrame(r, columns=['Driver ID', 'Loan ID', 'Vehicle Chassis Number', 'Loan Amount(in Rs)', 'Balance Amount(in Rs)', 'EMI Amount(in Rs)',
    #                               'Loan Payment Status'])
    # print(df.to_string(), '\n')

# def get_result(option, query, columns):
#     print(option + ':')
#     cur.execute(query)
#     print(tabulate(cur.fetchall(), headers = columns, tablefmt = 'rounded_grid'), '\n')

def stats():
    while(1):
        msg = "Pick an option to check details"
        options = ["Total Revenue", "Average rating of drivers", "Average Waiting Time for a driver", "Payment status of customer", 
                "Number of pending payments for customers", "Commission rates of drivers", "Popular Rides", "Total Rides per Day", 
                "Popular Pickup Locations", "Popular Drop Locations", "Driver Earnings", "Revenue by City / Pickup Location", 
                "Payment Method Distribution", "Loan details of Drivers", 'Exit']
        data = pick_option(options, msg, "action")
        if (data == options[0]):
            get_revenue()
        elif (data == options[1]):
            get_avg_driv_rating()
        elif (data == options[2]):
            get_avg_wait_time()
        elif (data == options[3]):
            get_cust_pay_status()
        elif (data == options[4]):
            get_pending_payments()
        elif (data == options[5]):
            get_driv_comm_rate()
        elif (data == options[6]):
            get_popular_rides()
        elif (data == options[7]):
            get_rides_per_day()
        elif (data == options[8]):
            get_pop_pickup_loc()
        elif (data == options[9]):
            get_pop_drop_loc()
        elif (data == options[10]):
            get_driv_earn()
        elif (data == options[11]):
            get_rev_by_loc()
        elif (data == options[12]):
            get_payment_method()
        elif (data == options[13]):
            get_driv_loan_details()
        elif (data == options[14]):
            exit(0)
        print('____________________________________________________________________________________________________________________________________________________')
    

if __name__ == '__main__': 

    print('\nAdding commission to drivers\n')
    try:
        cur.execute("""WITH no_car_pool(ride_id, cust_id, driv_id, amount) AS
                    (SELECT Ride.ride_id, Ride.cust_id, Ride.driv_id, Charges.amount
                    FROM Ride, Charges
                    WHERE Ride.ride_id = Charges.ride_id AND
                    Ride.cust_id = Charges.cust_id AND
                    car_pool = 'No' AND Charges.status = 'Completed')
                    INSERT INTO Commission
                    (SELECT DATE_TRUNC('seconds', CURRENT_TIMESTAMP), amount * commission_rate, driv_id, ride_id, cust_id
                    FROM no_car_pool NATURAL JOIN Driver
                    WHERE ride_id NOT IN (SELECT ride_id FROM Commission))""")
        conn.commit()
        print("\nSuccessfully transferred commission to drivers!\n")
    except psycopg2.Error as e:
        print(f'Database error: {e}')
        conn.rollback()
        print("ROLLBACK")
    
    msg = "Wish to see stats?"
    options = ['Yes', 'No']
    data = pick_option(options, msg, "action")
    if(data == options[0]):
        stats()
    
    