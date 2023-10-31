-- Queries:
-- Revenue: amount - commission:
-- View: Has to JOIN 3 tables to compute Revenue
SELECT SUM(amount - (amount * commission_rate)) AS Total_Revenue 
FROM (Driver NATURAL JOIN Ride) JOIN Charges USING (ride_id, cust_id)
WHERE Charges.status = 'Completed';

-- Driver Performance Metrics:

-- Customer: satisfaction from rating of drivers OR
-- Avg rating of drivers:
-- Not a View: We have to look into one table only
SELECT driv_id AS Driver_ID, AVG(driv_rating) AS Driver_Average_Rating
FROM Ride
WHERE status = 'reached destination'
GROUP BY Driver_ID
ORDER BY Driver_Average_Rating DESC;

-- Average Waiting Time for a driver:
-- Not a view: Has to JOIN two relations only
SELECT driv_id AS Driver_ID, CONCAT_WS(' ', driv_fname, driv_lname) AS Driver_name, 
AVG(date_part('minutes', pickup_time - reserv_time)) AS Booking_Pickup_delay
FROM Ride NATURAL JOIN Driver 
GROUP BY driv_id, Driver_name
ORDER BY Booking_Pickup_delay DESC;

-- Payment status of customer:
-- Display the payment status of all Customers:
-- View: Has to JOIN 3 relations
SELECT Customer.cust_id AS Customer_ID, CONCAT_WS(' ', cust_fname, cust_lname) AS Customer_name, 
ride_id, amount, reserv_time AS Booking_time, pickup_loc_id, drop_loc_id, Charges.status AS Payment_status 
FROM (Customer NATURAL JOIN Charges) JOIN Ride USING (ride_id);

-- Display number of pending payments for all customers:
-- Not a View: Used only one relation
SELECT cust_id, COUNT(*) AS Number_of_Pending_Payments
FROM Charges
WHERE status = 'Pending'
GROUP BY cust_id;

-- Commission rates of drivers:
-- Not a View: Go through a relatively small relation like Driver
SELECT driv_id AS Driver_ID, CONCAT_WS(' ', driv_fname, driv_lname) AS Driver_name, 
commission_rate 
FROM Driver
ORDER BY commission_rate DESC;

-- Popular Ride Type:
-- Not a View: Though this involves Ride relation(which is big) but such a stat will be seen occasionally
SELECT type AS Vehicle_Type, COUNT(*) AS Number_of_Rides
FROM Ride NATURAL JOIN Vehicle
GROUP BY type
ORDER BY COUNT(*) DESC;

-- Total Rides per Day:
-- View: Computing from scratch is quite expensive
SELECT cast(reserv_time as date), COUNT(*) AS Num_of_rides
FROM Ride
GROUP BY cast(reserv_time as date);

-- Popular Pickup Locations:
-- Not a View: Though this involves Ride relation(which is big) but such a stat will be seen occasionally
SELECT Ride.pickup_loc_id, street, COUNT(*) AS pickup_count
FROM Ride, Location
WHERE Ride.pickup_loc_id = Location.loc_id
GROUP BY pickup_loc_id, street
ORDER BY pickup_count DESC;

-- Popular Drop Locations:
-- Not a View: Though this involves Ride relation(which is big) but such a stat will be seen occasionally
SELECT drop_loc_id, street, COUNT(*) AS drop_count
FROM Ride, Location
WHERE Ride.drop_loc_id = Location.loc_id
GROUP BY drop_loc_id, street
ORDER BY drop_count DESC;

-- Driver Earnings:
-- View: Computationally expensive and this needs to be tracked on regular basis
SELECT driv_id, SUM(commission_rate * amount) AS Earnings
FROM (Driver NATURAL JOIN Ride) JOIN Charges USING (ride_id, cust_id)
GROUP BY driv_id
ORDER BY Earnings DESC;

-- *** ^ Can be calculated from Commission Table easily
-- Anyway we have to maintain the Commission table

-- Revenue by City / Pickup Location:
-- View: Computationally expensive to get it from scratch
SELECT pickup_loc_id, SUM(amount - (commission_rate * amount)) AS Revenue
FROM (Charges NATURAL JOIN Driver) JOIN Ride USING (ride_id, driv_id, cust_id)
GROUP BY pickup_loc_id
ORDER BY Revenue DESC;

-- Difference between reserv_time and pickup_time:
-- *** Try typecasting if it doen't work. 
-- eg. select timestamp '2001-09-29 03:00' - timestamp '2001-09-27 12:00';
-- SELECT date_part('minutes', INTERVAL '1 day 15:10:00');

-- Payment Method Distribution:
-- Not a View: Such a stat would be occasionally checked
SELECT mode_of_payment, COUNT(Ride.ride_id) AS Num_Rides
FROM Ride, Charges 
WHERE Ride.ride_id = Charges.ride_id AND 
Ride.cust_id = Charges.cust_id
GROUP BY mode_of_payment
ORDER BY Num_Rides DESC;

-- We didn't use NATURAL JOIN here because we specifically wanted to match ride_id and cust_id only.

-- Loan details of each driver and balance amount sorted in descending order
-- Not a View: Can be calculated when required
SELECT lp.driv_id, lp.loan_id, chassis_num, lp.amount, balance_amt, emi_amount, lp.status
FROM Car_loan AS cl, Loan_payment AS lp
WHERE cl.amount = lp.amount AND
cl.loan_id = lp.loan_id AND
cl.driv_id = lp.driv_id
ORDER BY balance_amt DESC;

-- 1 Transaction execution
-- Create a view out of query if computing all the data from scratch is very expensive as it might have to more than 2 relations.

-- All the natural joins used till now:
-- Charges, Driver, Ride
-- Customer, Charges, Ride
-- Ride, Driver

-- Advantage of keeping them as views is that we can use them directly to write queries which involve joins of the same tables.