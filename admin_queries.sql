-- Queries:
-- Revenue: amount - commission:
SELECT SUM(amount - (amount * commission_rate)) AS Total_Revenue 
FROM (Driver NATURAL JOIN Ride) JOIN Charges USING (ride_id, cust_id)
WHERE Charges.status = 'Completed';

-- Driver Performance Metrics:

-- Customer: satisfaction from rating of drivers OR
-- Avg rating of drivers:
SELECT driv_id AS Driver_ID, AVG(driv_rating) AS Driver_Average_Rating
FROM Ride
WHERE status = 'reached destination'
GROUP BY Driver_ID
ORDER BY Driver_Average_Rating DESC;

-- Average Waiting Time for a driver:
SELECT driv_id AS Driver_ID, CONCAT_WS(' ', driv_fname, driv_lname) AS Driver_name, 
AVG(date_part('minutes', pickup_time - reserv_time)) AS Booking_Pickup_delay
FROM Ride NATURAL JOIN Driver 
GROUP BY driv_id, Driver_name
ORDER BY Booking_Pickup_delay DESC;

-- Payment status of customer:
-- Display the payment status of all Customers:
SELECT Customer.cust_id AS Customer_ID, CONCAT_WS(' ', cust_fname, cust_lname) AS Customer_name, 
ride_id, amount, reserv_time AS Booking_time, pickup_loc_id, drop_loc_id, Charges.status AS Payment_status 
FROM (Customer NATURAL JOIN Charges) JOIN Ride USING (ride_id);

-- Display number of pending payments for all customers:
SELECT cust_id, COUNT(*) AS Number_of_Pending_Payments
FROM Charges
WHERE status = 'Pending'
GROUP BY cust_id;

-- Commission rates of drivers:
SELECT driv_id AS Driver_ID, CONCAT_WS(' ', driv_fname, driv_lname) AS Driver_name, 
commission_rate 
FROM Driver
ORDER BY commission_rate DESC;

-- Popular Ride Type:
SELECT type AS Vehicle_Type, COUNT(*) AS Number_of_Rides
FROM Ride NATURAL JOIN Vehicle
GROUP BY type
ORDER BY COUNT(*) DESC;

-- Total Rides per Day:
SELECT cast(reserv_time as date), COUNT(*) AS Num_of_rides
FROM Ride
GROUP BY cast(reserv_time as date);

-- Popular Pickup Locations:
SELECT pickup_loc_id, COUNT(*) AS pickup_count
FROM Ride
GROUP BY pickup_loc_id
ORDER BY pickup_count DESC;

-- Popular Drop Locations:
SELECT drop_loc_id, COUNT(*) AS drop_count
FROM Ride
GROUP BY drop_loc_id
ORDER BY drop_count DESC;

-- Driver Earnings:
SELECT driv_id, SUM(commission_rate * amount) AS Earnings
FROM (Driver NATURAL JOIN Ride) JOIN Charges USING (ride_id, cust_id)
GROUP BY driv_id
ORDER BY Earnings DESC;

-- Revenue by City / Pickup Location:
SELECT pickup_loc_id, SUM(amount - (commission_rate * amount)) AS Revenue
FROM (Charges NATURAL JOIN Driver) JOIN Ride USING (ride_id, driv_id, cust_id)
GROUP BY pickup_loc_id
ORDER BY Revenue DESC;

-- Difference between reserv_time and pickup_time:
-- *** Try typecasting if it doen't work. 
-- eg. select timestamp '2001-09-29 03:00' - timestamp '2001-09-27 12:00';
-- SELECT date_part('minutes', INTERVAL '1 day 15:10:00');

-- Payment Method Distribution:
SELECT mode_of_payment, COUNT(Ride.ride_id) AS Num_Rides
FROM Ride, Charges 
WHERE Ride.ride_id = Charges.ride_id AND 
Ride.cust_id = Charges.cust_id
GROUP BY mode_of_payment
ORDER BY Num_Rides DESC;

-- We didn't use NATURAL JOIN here because we specifically wanted to match ride_id and cust_id only.

-- Loan details of each driver and balance amount sorted in descending order
SELECT lp.driv_id, lp.loan_id, chassis_num, lp.amount, balance_amt, emi_amount, lp.status
FROM Car_loan AS cl, Loan_payment AS lp
WHERE cl.amount = lp.amount AND
cl.loan_id = lp.loan_id AND
cl.driv_id = lp.driv_id
ORDER BY balance_amt DESC;

-- 1 Transaction execution