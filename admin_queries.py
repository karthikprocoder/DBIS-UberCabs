def adminData(cur, pd):
    print("Total Revenue:")
    cur.execute("""SELECT SUM(amount - (amount * commission_rate)) AS Total_Revenue
                FROM (Driver NATURAL JOIN Ride) JOIN Charges USING (ride_id, cust_id)
                WHERE Charges.status = 'Completed'""")
    r = cur.fetchall()
    print('Rs.', float(r[0][0]), '\n')

    print("Average rating of drivers:")
    cur.execute("""SELECT driv_id AS Driver_ID, AVG(driv_rating) AS Driver_Average_Rating
                FROM Ride WHERE status = 'reached destination'
                GROUP BY Driver_ID
                ORDER BY Driver_Average_Rating DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Driver ID', 'Average Rating'])
    print(df, '\n')

    print("Average Waiting Time for a driver:")
    cur.execute("""SELECT driv_id AS Driver_ID, CONCAT_WS(' ', driv_fname, driv_lname) AS Driver_name, 
                AVG(date_part('minutes', pickup_time - reserv_time)) AS Booking_Pickup_delay
                FROM Ride NATURAL JOIN Driver 
                GROUP BY driv_id, Driver_name
                ORDER BY Booking_Pickup_delay DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Driver ID', 'Driver Name', 'Average Waiting Time(in mins)'])
    print(df, '\n')

    print("Payment status of customer:")
    cur.execute("""SELECT Customer.cust_id AS Customer_ID, CONCAT_WS(' ', cust_fname, cust_lname) AS Customer_name, 
ride_id, amount, reserv_time AS Booking_time, pickup_loc_id, drop_loc_id, Charges.status AS Payment_status 
FROM (Customer NATURAL JOIN Charges) JOIN Ride USING (ride_id)""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Customer ID', 'Customer Name', 'Ride ID', 'Amount(in Rs)', 'Booking Time', 'Pickup Location', 'Drop Location', 'Payment Status'])
    print(df.to_string(), '\n')

    print("Number of pending payments for customers:")
    cur.execute("""SELECT cust_id, COUNT(*) AS Number_of_Pending_Payments
                FROM Charges
                WHERE status = 'Pending'
                GROUP BY cust_id""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Customer ID', 'Number of pending payments'])
    print(df, '\n')

    print("Commission rates of drivers:")
    cur.execute("""SELECT driv_id AS Driver_ID, CONCAT_WS(' ', driv_fname, driv_lname) AS Driver_name, 
                commission_rate 
                FROM Driver
                ORDER BY commission_rate DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Driver ID', 'Driver Name', 'Commission Rate(factor)'])
    print(df, '\n')

    print("Popular Rides:")
    cur.execute("""SELECT type AS Vehicle_Type, COUNT(*) AS Number_of_Rides
                FROM Ride NATURAL JOIN Vehicle
                GROUP BY type
                ORDER BY COUNT(*) DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Vehicle Type', 'Number of Rides'])
    print(df, '\n')

    print("Total Rides per Day:")
    cur.execute("""SELECT cast(reserv_time as date), COUNT(*) AS Num_of_rides
                FROM Ride
                GROUP BY cast(reserv_time as date)""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Date', 'Number of Rides'])
    print(df, '\n')

    print("Popular Pickup Locations:")
    cur.execute("""SELECT pickup_loc_id, COUNT(*) AS pickup_count
                FROM Ride
                GROUP BY pickup_loc_id
                ORDER BY pickup_count DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Pickup Location', 'Number of Rides from this location'])
    print(df, '\n')

    print("Popular Drop Locations:")
    cur.execute("""SELECT drop_loc_id, COUNT(*) AS drop_count
                FROM Ride
                GROUP BY drop_loc_id
                ORDER BY drop_count DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Drop Location', 'Number of Rides ending at this location'])
    print(df, '\n')

    print("Driver Earnings:")
    cur.execute("""SELECT driv_id, SUM(commission_rate * amount) AS Earnings
                FROM (Driver NATURAL JOIN Ride) JOIN Charges USING (ride_id, cust_id)
                GROUP BY driv_id
                ORDER BY Earnings DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Driver ID', 'Earnings(in Rs)'])
    print(df, '\n')

    print("Revenue by City / Pickup Location:")
    cur.execute("""SELECT pickup_loc_id, SUM(amount - (commission_rate * amount)) AS Revenue
                FROM (Charges NATURAL JOIN Driver) JOIN Ride USING (ride_id, driv_id, cust_id)
                GROUP BY pickup_loc_id
                ORDER BY Revenue DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Pickup Location', 'Revenue from this location(in Rs)'])
    print(df, '\n')

    print("Payment Method Distribution:")
    cur.execute("""SELECT mode_of_payment, COUNT(Ride.ride_id) AS Num_Rides
                FROM Ride, Charges 
                WHERE Ride.ride_id = Charges.ride_id AND 
                Ride.cust_id = Charges.cust_id
                GROUP BY mode_of_payment
                ORDER BY Num_Rides DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Mode of payment', 'Number of Rides'])
    print(df, '\n')

    print("Loan details of Drivers:")
    cur.execute("""SELECT lp.driv_id, lp.loan_id, chassis_num, lp.amount, balance_amt, emi_amount, lp.status
                FROM Car_loan AS cl, Loan_payment AS lp
                WHERE cl.amount = lp.amount AND
                cl.loan_id = lp.loan_id AND
                cl.driv_id = lp.driv_id
                ORDER BY balance_amt DESC""")
    r = cur.fetchall()
    df = pd.DataFrame(r, columns=['Driver ID', 'Loan ID', 'Vehicle Chassis Number', 'Loan Amount(in Rs)', 'Balance Amount(in Rs)', 'EMI Amount(in Rs)',
                                  'Loan Payment Status'])
    print(df.to_string(), '\n')