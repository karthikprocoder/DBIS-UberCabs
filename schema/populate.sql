-- Insert data into the Location table
INSERT INTO Location (latitude, longitude, name, city, street, country, landmark, state)
VALUES
    (37.7749, -122.4194, 'Golden Gate Park', 'San Francisco', '987 Park Ave', 'USA', 'Main Entrance', 'CA'),
    (51.5074, -0.1278, 'Hyde Park', 'London', '123 Hyde St', 'UK', 'Hyde Park Corner', 'England'),
    (34.0522, -118.2437, 'Hollywood Boulevard', 'Los Angeles', '456 Hollywood St', 'USA', 'Walk of Fame', 'CA'),
    (40.7128, -74.0060, 'Central Park', 'New York', '789 Central Park West', 'USA', 'Strawberry Fields', 'NY'),
    (48.8566, 2.3522, 'Eiffel Tower', 'Paris', '123 Rue de la Paix', 'France', 'Champ de Mars', 'Île-de-France'),
    (52.5200, 13.4050, 'Brandenburg Gate', 'Berlin', 'Brandenburger Tor', 'Germany', 'Pariser Platz', 'Berlin'),
    (41.9028, 12.4964, 'Colosseum', 'Rome', 'Piazza del Colosseo', 'Italy', 'Flavian Amphitheatre', 'Lazio'),
    (35.6895, 139.6917, 'Tokyo Tower', 'Tokyo', '4 Chome-2-8 Shibakoen, Minato City', 'Japan', 'Shiba Park', 'Tokyo'),
    (22.5726, 88.3639, 'Victoria Memorial', 'Kolkata', '1, Queens Way', 'India', 'Victoria Memorial Hall', 'West Bengal'),
    (30.0444, 31.2357, 'Pyramids of Giza', 'Giza', 'Al Haram, Nazlet El-Semman', 'Egypt', 'Great Sphinx of Giza', 'Giza');

-- Insert data into the Reviewer table
INSERT INTO Reviewer (rev_fname, rev_lname, dob, email, date_of_join, rev_id, latitude, longitude)
VALUES
    ('John', 'Smith', '1990-05-15', 'john.smith@email.com', '2022-01-10', 1, 37.7749, -122.4194),
    ('Emily', 'Johnson', '1988-12-20', 'emily.johnson@email.com', '2021-07-05', 2, 51.5074, -0.1278),
    ('Michael', 'Brown', '1995-08-25', 'michael.brown@email.com', '2022-03-15', 3, 34.0522, -118.2437),
    ('Olivia', 'Davis', '1986-04-29', 'olivia.davis@email.com', '2021-11-20', 4, 40.7128, -74.0060),
    ('Sophia', 'Wilson', '1993-10-10', 'sophia.wilson@email.com', '2022-05-12', 5, 48.8566, 2.3522),
    ('Liam', 'Martinez', '1989-02-18', 'liam.martinez@email.com', '2022-06-30', 6, 52.5200, 13.4050),
    ('Ava', 'Thomas', '1992-07-22', 'ava.thomas@email.com', '2022-08-15', 7, 41.9028, 12.4964),
    ('Noah', 'Garcia', '1987-03-05', 'noah.garcia@email.com', '2022-03-10', 8, 35.6895, 139.6917),
    ('Mia', 'Roy', '1994-11-12', 'mia.roy@email.com', '2022-01-05', 9, 22.5726, 88.3639),
    ('Ethan', 'Khan', '1991-09-30', 'ethan.khan@email.com', '2021-12-22', 10, 30.0444, 31.2357);

-- Insert data into the Guarantor table
INSERT INTO Guarantor (guarantor_fname, guarantor_lname, guarantor_email, guarantor_id, latitude, longitude)
VALUES
    ('David', 'Williams', 'david.williams@email.com', 1, 37.7749, -122.4194),
    ('Sophia', 'Smith', 'sophia.smith@email.com', 2, 51.5074, -0.1278),
    ('Liam', 'Davis', 'liam.davis@email.com', 3, 34.0522, -118.2437),
    ('Ella', 'Miller', 'ella.miller@email.com', 4, 40.7128, -74.0060),
    ('Henry', 'Jones', 'henry.jones@email.com', 5, 48.8566, 2.3522),
    ('Luna', 'Anderson', 'luna.anderson@email.com', 6, 52.5200, 13.4050),
    ('Eli', 'Thomas', 'eli.thomas@email.com', 7, 41.9028, 12.4964),
    ('Aria', 'Garcia', 'aria.garcia@email.com', 8, 35.6895, 139.6917),
    ('Sebastian', 'Brown', 'sebastian.brown@email.com', 9, 22.5726, 88.3639),
    ('Lily', 'Wilson', 'lily.wilson@email.com', 10, 30.0444, 31.2357);

-- Insert data into the Reviewer_phone table
INSERT INTO Reviewer_phone (phone, rev_id)
VALUES
    ('111-111-1111', 1),
    ('222-222-2222', 2),
    ('333-333-3333', 3),
    ('444-444-4444', 4),
    ('555-555-5555', 5),
    ('666-666-6666', 6),
    ('777-777-7777', 7),
    ('888-888-8888', 8),
    ('999-999-9999', 9),
    ('000-000-0000', 10);

-- Insert data into the Customer table
INSERT INTO Customer (cust_fname, cust_lname, email, dob, cust_id, latitude, longitude)
VALUES
    ('Sophie', 'Anderson', 'sophie.anderson@email.com', '1994-08-05', 1, 37.7749, -122.4194),
    ('Ethan', 'Wilson', 'ethan.wilson@email.com', '1997-12-18', 2, 51.5074, -0.1278),
    ('Ava', 'Thomas', 'ava.thomas@email.com', '1993-09-22', 3, 34.0522, -118.2437),
    ('Liam', 'Clark', 'liam.clark@email.com', '1992-05-30', 4, 40.7128, -74.0060),
    ('Mia', 'Hernandez', 'mia.hernandez@email.com', '1996-11-15', 5, 48.8566, 2.3522),
    ('Oliver', 'Garcia', 'oliver.garcia@email.com', '1998-04-02', 6, 52.5200, 13.4050),
    ('Sophia', 'Smith', 'sophia.smith@email.com', '1995-07-14', 7, 41.9028, 12.4964),
    ('Emma', 'Brown', 'emma.brown@email.com', '1991-01-30', 8, 35.6895, 139.6917),
    ('William', 'Jones', 'william.jones@email.com', '1999-03-12', 9, 22.5726, 88.3639),
    ('Luna', 'Miller', 'luna.miller@email.com', '1990-12-01', 10, 30.0444, 31.2357);


-- Insert data into the Driver table
INSERT INTO Driver (driv_fname, driv_lname, email, dob, date_of_join, driv_lic_num, driv_id, commission_rate, latitude, longitude)
VALUES
    ('Daniel', 'Taylor', 'daniel.taylor@email.com', '1989-06-12', '2021-12-05', 'DL123456', 1, 0.15, 37.7749, -122.4194),
    ('Aria', 'Wilson', 'aria.wilson@email.com', '1995-03-28', '2022-01-10', 'DL789012', 2, 0.18, 51.5074, -0.1278),
    ('Elijah', 'Brown', 'elijah.brown@email.com', '1993-08-15', '2021-10-20', 'DL567890', 3, 0.17, 34.0522, -118.2437),
    ('Emma', 'Hernandez', 'emma.hernandez@email.com', '1986-11-20', '2022-03-01', 'DL345678', 4, 0.16, 40.7128, -74.0060),
    ('Oliver', 'Clark', 'oliver.clark@email.com', '1990-05-08', '2022-04-15', 'DL901234', 5, 0.15, 48.8566, 2.3522),
    ('Ava', 'Miller', 'ava.miller@email.com', '1992-02-04', '2021-09-30', 'DL234567', 6, 0.18, 52.5200, 13.4050),
    ('Liam', 'Smith', 'liam.smith@email.com', '1988-09-14', '2021-11-25', 'DL678901', 7, 0.16, 41.9028, 12.4964),
    ('Sophia', 'Jones', 'sophia.jones@email.com', '1997-04-30', '2022-02-10', 'DL456789', 8, 0.17, 35.6895, 139.6917),
    ('William', 'Garcia', 'william.garcia@email.com', '1987-12-03', '2021-07-05', 'DL890123', 9, 0.15, 22.5726, 88.3639),
    ('Luna', 'Thomas', 'luna.thomas@email.com', '1996-06-25', '2022-05-12', 'DL123890', 10, 0.18, 30.0444, 31.2357);

-- Insert data into the Vehicle table
INSERT INTO Vehicle (registration_num, chassis_num, Capacity, puc_num, number_plate, model, company, type, ownership, driv_id)
VALUES
    ('CA123ABC', 'CH00001', 4, 'PUC1234', '123ABC', 'Sedan', 'Toyota', 'Sedan', 'Personal', 1),
    ('UK456DEF', 'CH00002', 3, 'PUC5678', '456DEF', 'Cooper', 'Mini Cooper', 'Mini','Rented', 2),
    ('US789GHI', 'CH00003', 3, 'PUC9101', '789GHI', 'Rickshaw', 'Bajaj', 'Auto-Rick', 'Personal', 3),
    ('NY101JKL', 'CH00004', 5, 'PUC1122', '101JKL', 'Explorer', 'Ford', 'SUV', 'Loaned', 4),
    ('FR123MNO', 'CH00005', 4, 'PUC3344', '123MNO', 'Clio', 'Renault', 'Sedan', 'Rented', 5),
    ('DE456PQR', 'CH00006', 6, 'PUC5566', '456PQR', 'Transporter', 'Volkswagen', 'Van', 'Personal', 6),
    ('IT789STU', 'CH00007', 5, 'PUC7788', '789STU', 'Portofino', 'Ferrari', 'SUV', 'Loaned', 7),
    ('JP101VWX', 'CH00008', 3, 'PUC9900', '101VWX', 'Swift', 'Suzuki', 'Mini', 'Rented', 8),
    ('IN123YZA', 'CH00009', 4, 'PUC1122', '123YZA', 'Civic', 'Honda', 'Sedan', 'Personal', 9),
    ('EG456BCD', 'CH00010', 3, 'PUC3344', '456BCD', 'Rickshaw', 'Bajaj', 'Auto-Rick', 'Loaned', 10);


-- Insert data into the Ride table
INSERT INTO Ride (distance, pickup_time, drop_time, car_pool, cust_rating, driv_rating, reserv_time, ride_id, review, charge_per_km, status, driv_id, latitude, longitude, pickuplatitude, pickuplongitude, cust_id)
VALUES
    (10.5, '2023-01-15 08:00:00', '2023-01-15 08:30:00', 'No', 5, 4, '2023-01-14 20:00:00', 1, 'Great ride!', 2.5, 'on the way', 1, 37.7749, -122.4194, 37.7749, -122.4194, 1),
    (5.3, '2023-02-10 09:30:00', '2023-02-10 09:55:00', 'Yes', 4, 4, '2023-02-09 18:00:00', 2, 'Smooth ride', 3.0, 'picked up', 2, 51.5074, -0.1278, 51.5074, -0.1278, 2),
    (7.8, '2023-03-20 12:45:00', '2023-03-20 13:15:00', 'No', 5, 5, '2023-03-19 22:00:00', 3, 'Excellent service', 2.8, 'ongoing', 3, 34.0522, -118.2437, 34.0522, -118.2437, 3),
    (6.2, '2023-04-15 14:15:00', '2023-04-15 14:45:00', 'No', 4, 4, '2023-04-14 21:00:00', 4, 'Polite driver', 2.7, 'reached destination', 4, 40.7128, -74.0060, 40.7128, -74.0060, 4),
    (8.4, '2023-05-22 17:30:00', '2023-05-22 18:15:00', 'No', 3, 4, '2023-05-21 23:00:00', 5, 'Nice vehicle', 2.9, 'on the way', 5, 48.8566, 2.3522, 48.8566, 2.3522, 5),
    (12.1, '2023-06-18 20:00:00', '2023-06-18 21:15:00', 'No', 5, 5, '2023-06-17 16:00:00', 6, 'Great experience', 2.4, 'ongoing', 6, 52.5200, 13.4050, 52.5200, 13.4050, 6),
    (5.9, '2023-07-11 10:45:00', '2023-07-11 11:15:00', 'Yes', 4, 4, '2023-07-10 19:00:00', 7, 'Prompt service', 3.2, 'picked up', 7, 41.9028, 12.4964, 41.9028, 12.4964, 7),
    (9.7, '2023-08-30 14:30:00', '2023-08-30 15:15:00', 'No', 3, 3, '2023-08-29 22:00:00', 8, 'Average ride', 2.6, 'reached destination', 8, 35.6895, 139.6917, 35.6895, 139.6917, 8),
    (7.2, '2023-09-25 19:15:00', '2023-09-25 19:45:00', 'No', 4, 4, '2023-09-24 17:00:00', 9, 'Friendly driver', 2.3, 'on the way', 9, 22.5726, 88.3639, 22.5726, 88.3639, 9),
    (10.0, '2023-10-18 08:15:00', '2023-10-18 08:45:00', 'No', 5, 5, '2023-10-17 20:00:00', 10, 'Excellent ride', 2.8, 'ongoing', 10, 30.0444, 31.2357, 30.0444, 31.2357, 10);

INSERT INTO Tracking (time, latitude, longitude, ride_id, cust_id)
VALUES
    ('2023-01-15 08:05:00', 37.7749, -122.4194, 1, 1),
    ('2023-02-10 09:40:00', 51.5074, -0.1278, 2, 2),
    ('2023-03-20 13:00:00', 34.0522, -118.2437, 3, 3),
    ('2023-04-15 14:25:00', 40.7128, -74.0060, 4, 4),
    ('2023-05-22 17:45:00', 48.8566, 2.3522, 5, 5),
    ('2023-06-18 20:10:00', 52.5200, 13.4050, 6, 6),
    ('2023-07-11 11:00:00', 41.9028, 12.4964, 7, 7),
    ('2023-08-30 15:00:00', 35.6895, 139.6917, 8, 8),
    ('2023-09-25 19:30:00', 22.5726, 88.3639, 9, 9),
    ('2023-10-18 08:30:00', 30.0444, 31.2357, 10, 10);

-- Make sure the driv_id and rev_id values exist in their respective tables before inserting into Verify
INSERT INTO Verify (pay_timestamp, tax_rate, payment, driv_id, rev_id)
VALUES
    ('2023-01-15 08:10:00', 0.1, 100.0, 1, 1),
    ('2023-02-10 09:50:00', 0.08, 85.0, 2, 2),
    ('2023-03-20 13:05:00', 0.12, 120.0, 3, 3),
    ('2023-04-15 14:30:00', 0.09, 95.0, 4, 4),
    ('2023-05-22 17:50:00', 0.1, 100.0, 5, 5),
    ('2023-06-18 20:20:00', 0.08, 85.0, 6, 6),
    ('2023-07-11 11:10:00', 0.11, 110.0, 7, 7),
    ('2023-08-30 15:05:00', 0.09, 95.0, 8, 8),
    ('2023-09-25 19:35:00', 0.1, 100.0, 9, 9),
    ('2023-10-18 08:35:00', 0.08, 85.0, 10, 10);

-- -- Make sure the driv_id and guarantor_id values exist in their respective tables before inserting into Car_loan
INSERT INTO Car_loan (amount, interest_rate, tenure, emi_amount, status, loan_id, driv_id, guarantor_id, chassis_num)
VALUES
    (50000.00, 5.0, 12.0, 4500.00, 'Partially paid', 1, 1, 1, 'CH00001'),
    (60000.00, 6.0, 12.0, 5500.00, 'Completely paid', 2, 2, 2, 'CH00002'),
    (55000.00, 5.5, 12.0, 5000.00, 'Zero installments', 3, 3, 3, 'CH00003');

-- -- Make sure the driv_id and loan_id values exist in their respective tables before inserting into Loan_payment
INSERT INTO Loan_payment (timestamp, amount, mode, status, gateway, tax_rate, balance_amt, driv_id, loan_id)
VALUES
    ('2023-01-15 08:15:00', 4500.00, 'Online', 'Partially paid', 'PayPal', 0.2, 4000.00, 1, 1),
    ('2023-02-10 09:55:00', 5500.00, 'Cheque', 'Completely paid', 'Bank', 0.08, 500, 2, 2),
    ('2023-03-20 13:10:00', 5000.00, 'Online', 'Zero installments', 'PayPal', 0.1, 2500.00, 3, 3);
