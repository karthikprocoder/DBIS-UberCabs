-- Insert data into the Location table
INSERT INTO Location (latitude, longitude, name, city, street, country, landmark, state)
VALUES
    (40.7128, -74.0060, 'Central Park', 'New York City', '123 Main St', 'USA', 'Central Park Entrance', 'NY'),
    (34.0522, -118.2437, 'Santa Monica Pier', 'Los Angeles', '456 Ocean Ave', 'USA', 'Pier Entrance', 'CA');

-- Insert data into the Reviewer table
INSERT INTO Reviewer (rev_fname, rev_lname, dob, email, date_of_join, rev_id, latitude, longitude)
VALUES
    ('John', 'Doe', '1990-01-15', 'john.doe@email.com', '2022-03-10', 1, 40.7128, -74.0060),
    ('Jane', 'Smith', '1985-05-20', 'jane.smith@email.com', '2021-08-05', 2, 34.0522, -118.2437);

-- Insert data into the Guarantor table
INSERT INTO Guarantor (guarantor_fname, guarantor_lname, guarantor_email, guarantor_id, latitude, longitude)
VALUES
    ('Michael', 'Johnson', 'michael.johnson@email.com', 1, 40.7128, -74.0060),
    ('Emily', 'Brown', 'emily.brown@email.com', 2, 34.0522, -118.2437);

-- Insert data into the Reviewer_phone table
INSERT INTO Reviewer_phone (phone, rev_id)
VALUES
    ('123-456-7890', 1),
    ('987-654-3210', 2);

-- Insert data into the Customer table
INSERT INTO Customer (cust_fname, cust_lname, email, dob, cust_id, latitude, longitude)
VALUES
    ('Alice', 'Johnson', 'alice.johnson@email.com', '1995-02-25', 1, 40.7128, -74.0060),
    ('Robert', 'Wilson', 'robert.wilson@email.com', '1998-07-10', 2, 34.0522, -118.2437);

-- Insert data into the Driver table
INSERT INTO Driver (driv_fname, driv_lname, email, dob, date_of_join, driv_lic_num, driv_id, commission_rate, latitude, longitude)
VALUES
    ('Mark', 'Anderson', 'mark.anderson@email.com', '1987-09-30', '2022-01-20', 'DL123456', 1, 0.12, 40.7128, -74.0060),
    ('Sarah', 'Davis', 'sarah.davis@email.com', '1989-11-12', '2021-12-05', 'DL987654', 2, 0.15, 34.0522, -118.2437);

-- Insert data into the Vehicle table
INSERT INTO Vehicle (registration_num, chassis_num, Capacity, puc_num, number_plate, model, company, variant, type, ownership, driv_id)
VALUES
    ('NY-1234', 'CH123456', 4, 'PUC123', 'NY-ABC-123', 'Sedan', 'Toyota', 'Camry', 'Sedan', 'Personal', 1),
    ('CA-5678', 'CH789012', 6, 'PUC456', 'CA-XYZ-789', 'SUV', 'Ford', 'Explorer', 'SUV', 'Rented', 2);

-- Insert data into the Ride table
INSERT INTO Ride (distance, pickup_time, drop_time, car_pool, cust_rating, driv_rating, reserv_time, ride_id, review, charge_per_km, status, driv_id, latitude, longitude, pickuplatitude, pickuplongitude, cust_id)
VALUES
    (10.5, '2022-03-10 09:00:00', '2022-03-10 10:00:00', 'No', 5, 4, '2022-03-09 10:00:00', 1, 'Great ride!', 12.5, 'on the way', 1, 40.7128, -74.0060, 40.7129, -74.0061, 1),
    (15.3, '2021-08-05 14:30:00', '2021-08-05 15:30:00', 'Yes', 4, 5, '2021-08-04 14:00:00', 2, 'Smooth ride', 10.7, 'reached destination', 2, 34.0522, -118.2437, 34.0523, -118.2438, 2);

-- Insert data into the Tracking table
INSERT INTO Tracking (time, latitude, longitude, ride_id, cust_id)
VALUES
    ('2022-03-10 09:10:00', 40.7128, -74.0060, 1, 1),
    ('2021-08-05 14:40:00', 34.0522, -118.2437, 2, 2);

-- Insert data into the Verify table
INSERT INTO Verify (pay_timestamp, tax_rate, payment, driv_id, rev_id)
VALUES
    ('2022-03-10 10:00:00', 0.1, 150.50, 1, 1),
    ('2021-08-05 15:30:00', 0.08, 120.75, 2, 2);

-- Insert data into the Car_loan table
INSERT INTO Car_loan (amount, interest_rate, tenure, emi_amount, status, loan_id, driv_id, guarantor_id, chassis_num)
VALUES
    (25000.00, 0.05, 36, 750.00, 'Partially paid', 1, 1, 1, 'CH123456'),
    (30000.00, 0.04, 48, 800.00, 'Zero installments', 2, 2, 2, 'CH789012');

-- Insert data into the Loan_payment table
INSERT INTO Loan_payment (timestamp, amount, mode, status, gateway, tax_rate, balance_amt, driv_id, loan_id)
VALUES
    ('2022-03-10 10:30:00', 750.00, 'Online', 'Partially paid', 'PayPal', 0.1, 500.00, 1, 1),
    ('2021-08-05 16:00:00', 800.00, 'Cheque', 'Zero installments', NULL, 0.08, 0.00, 2, 2);

-- Insert data into the Charges table
INSERT INTO Charges (tax, timestamp, late_fees, purpose_of_pay, mode_of_payment, ride_id, cust_id)
VALUES
    (5.00, '2022-03-10 10:45:00', 0.00, 'Parking fee', 'Online', 1, 1),
    (3.50, '2021-08-05 16:30:00', 1.00, 'Toll charges', 'Cash', 2, 2);

-- Insert data into the Commission table
INSERT INTO Commission (purpose_of_pay, timestamp, bonus, tax, driv_id, ride_id, cust_id)
VALUES
    ('Performance bonus', '2022-03-10 10:30:00', 25.00, 7.50, 1, 1, 1),
    ('Monthly commission', '2021-08-05 16:00:00', 30.00, 10.00, 2, 2, 2);

-- Insert data into the Stops table
INSERT INTO Stops (latitude, longitude, ride_id, cust_id)
VALUES
    (40.7129, -74.0061, 1, 1),
    (34.0523, -118.2438, 2, 2);

-- Insert data into the Customer_phone table
INSERT INTO Customer_phone (phone, cust_id)
VALUES
    ('123-456-7890', 1),
    ('987-654-3210', 2);

-- Insert data into the Driver_phone table
INSERT INTO Driver_phone (phone, driv_id)
VALUES
    ('111-222-3333', 1),
    ('444-555-6666', 2);
