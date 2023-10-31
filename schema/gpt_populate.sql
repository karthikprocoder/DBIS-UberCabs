-- Sample data for the "Location" table:
INSERT INTO Location (loc_id, latitude, longitude, name, city, street, country, landmark, state)
VALUES
  (1, 18.5204, 73.8567, 'Location 1', 'Pune', 'Street 1', 'India', 'Landmark 1', 'MH'),
  (2, 18.5246, 73.8576, 'Location 2', 'Pune', 'Street 2', 'India', 'Landmark 2', 'MH'),
  (3, 18.5278, 73.8568, 'Location 3', 'Pune', 'Street 3', 'India', 'Landmark 3', 'MH'),
  (4, 18.5310, 73.8554, 'Location 4', 'Pune', 'Street 4', 'India', 'Landmark 4', 'MH'),
  (5, 18.5352, 73.8547, 'Location 5', 'Pune', 'Street 5', 'India', 'Landmark 5', 'MH'),
  (6, 18.5411, 73.8493, 'Location 6', 'Pune', 'Street 6', 'India', 'Landmark 6', 'MH'),
  (7, 18.5457, 73.8438, 'Location 7', 'Pune', 'Street 7', 'India', 'Landmark 7', 'MH'),
  (8, 18.5506, 73.8366, 'Location 8', 'Pune', 'Street 8', 'India', 'Landmark 8', 'MH'),
  (9, 18.5559, 73.8281, 'Location 9', 'Pune', 'Street 9', 'India', 'Landmark 9', 'MH'),
  (10, 18.5603, 73.8198, 'Location 10', 'Pune', 'Street 10', 'India', 'Landmark 10', 'MH');

-- Sample data for the "Reviewer" table:
INSERT INTO Reviewer (rev_id, rev_fname, rev_lname, dob, email, date_of_join, loc_id)
VALUES
  (1, 'John', 'Doe', '1980-05-15', 'john@example.com', '2023-01-15', 1),
  (2, 'Alice', 'Smith', '1985-12-10', 'alice@example.com', '2023-02-20', 2),
  (3, 'Bob', 'Johnson', '1988-07-22', 'bob@example.com', '2023-03-10', 3),
  (4, 'Emily', 'Wilson', '1990-03-25', 'emily@example.com', '2023-04-05', 4),
  (5, 'Michael', 'Davis', '1992-09-12', 'michael@example.com', '2023-05-12', 5),
  (6, 'Linda', 'Taylor', '1987-11-30', 'linda@example.com', '2023-06-18', 6),
  (7, 'Daniel', 'Brown', '1982-04-28', 'daniel@example.com', '2023-07-25', 7),
  (8, 'Sophia', 'Lee', '1995-02-14', 'sophia@example.com', '2023-08-04', 8),
  (9, 'Matthew', 'Clark', '1991-08-19', 'matthew@example.com', '2023-09-15', 9),
  (10, 'Olivia', 'Anderson', '1989-06-01', 'olivia@example.com', '2023-10-20', 10);

-- Sample data for the "Guarantor" table:
INSERT INTO Guarantor (guarantor_id, guarantor_fname, guarantor_lname, guarantor_email, loc_id)
VALUES
  (1, 'Grace', 'Thomas', 'grace@example.com', 1),
  (2, 'Aiden', 'White', 'aiden@example.com', 2),
  (3, 'Chloe', 'Harris', 'chloe@example.com', 3),
  (4, 'Ethan', 'Martin', 'ethan@example.com', 4),
  (5, 'Isabella', 'Wilson', 'isabella@example.com', 5),
  (6, 'Mason', 'Davis', 'mason@example.com', 6),
  (7, 'Ava', 'Miller', 'ava@example.com', 7),
  (8, 'Liam', 'Brown', 'liam@example.com', 8),
  (9, 'Harper', 'Jones', 'harper@example.com', 9),
  (10, 'Noah', 'Garcia', 'noah@example.com', 10);

-- Sample data for the "Reviewer_phone" table:
INSERT INTO Reviewer_phone (phone, rev_id)
VALUES
  ('111-222-5555', 1),
  ('222-333-6666', 2),
  ('333-444-7777', 3),
  ('444-555-8888', 4),
  ('555-666-9999', 5),
  ('666-777-0000', 6),
  ('777-888-1111', 7),
  ('888-999-2222', 8),
  ('999-000-3333', 9),
  ('000-111-4444', 10);

-- Sample data for the "Guarantor_guarantor_phone" table with different phone numbers:
INSERT INTO Guarantor_guarantor_phone (guarantor_phone, guarantor_id)
VALUES
  ('111-222-7777', 1),
  ('222-333-8888', 2),
  ('333-444-9999', 3),
  ('444-555-0000', 4),
  ('555-666-1111', 5),
  ('666-777-2222', 6),
  ('777-888-3333', 7),
  ('888-999-4444', 8),
  ('999-000-5555', 9),
  ('000-111-6666', 10);

-- Sample data for the "Customer" table:
INSERT INTO Customer (cust_id, cust_fname, cust_lname, email, dob, loc_id)
VALUES
  (1, 'Sarah', 'Williams', 'sarah@example.com', '1990-08-25', 1),
  (2, 'James', 'Johnson', 'james@example.com', '1992-05-10', 2),
  (3, 'Oliver', 'Brown', 'oliver@example.com', '1988-12-22', 3),
  (4, 'Emma', 'Martinez', 'emma@example.com', '1995-03-05', 4),
  (5, 'William', 'Jones', 'william@example.com', '1993-09-12', 5),
  (6, 'Charlotte', 'Taylor', 'charlotte@example.com', '1991-06-30', 6),
  (7, 'Daniel', 'Garcia', 'daniel@example.com', '1994-04-28', 7),
  (8, 'Sophia', 'Davis', 'sophia@example.com', '1996-02-14', 8),
  (9, 'Henry', 'Hernandez', 'henry@example.com', '1987-08-19', 9),
  (10, 'Amelia', 'Smith', 'amelia@example.com', '1989-10-01', 10);

-- Sample data for the "Driver" table:
INSERT INTO Driver (driv_id, driv_fname, driv_lname, email, dob, date_of_join, driv_lic_num, commission_rate, loc_id)
VALUES
  (1, 'David', 'Martinez', 'david@example.com', '1985-03-15', '2022-01-15', 'DL123456', 0.15, 1),
  (2, 'Mia', 'Garcia', 'mia@example.com', '1987-07-10', '2022-02-20', 'DL234567', 0.12, 2),
  (3, 'Elijah', 'Johnson', 'elijah@example.com', '1988-05-22', '2022-03-10', 'DL345678', 0.14, 3),
  (4, 'Sophia', 'Brown', 'sophia@example.com', '1990-12-25', '2022-04-05', 'DL456789', 0.10, 4),
  (5, 'Lucas', 'Smith', 'lucas@example.com', '1992-09-12', '2022-05-12', 'DL567890', 0.13, 5),
  (6, 'Olivia', 'Wilson', 'olivia@example.com', '1987-11-30', '2022-06-18', 'DL678901', 0.11, 6),
  (7, 'Logan', 'Davis', 'logan@example.com', '1983-04-28', '2022-07-25', 'DL789012', 0.16, 7),
  (8, 'Liam', 'Miller', 'liam@example.com', '1994-02-14', '2022-08-04', 'DL890123', 0.09, 8),
  (9, 'Ava', 'Jones', 'ava@example.com', '1986-08-19', '2022-09-15', 'DL901234', 0.17, 9),
  (10, 'Emma', 'Taylor', 'emma@example.com', '1991-06-01', '2022-10-20', 'DL012345', 0.08, 10);

INSERT INTO Vehicle_generics (vehicle_type, extra_per, capacity)
VALUES
  ('Auto-Rick', 0, 3),
  ('Mini', 0.05, 4),
  ('Sedan', 0.1, 4),
  ('Van', 0.12, 6),
  ('SUV', 0.15, 6),
  ('Premium', 0.2, 4);

-- Sample data for the "Vehicle" table with matching chassis_num values in Car_loan:
INSERT INTO Vehicle (registration_num, chassis_num, puc_num, number_plate, model, company, type, ownership, driv_id)
VALUES
  ('MH1234', 'ABC123456', 'PUC123', 'AB-CD-1234', 'Sedan', 'Toyota', 'Sedan', 'Personal', 1),
  ('MH5678', 'DEF789012', 'PUC456', 'EF-GH-5678', 'Van', 'Ford', 'Van', 'Rented', 2),
  ('MH9876', 'GHI345678', 'PUC789', 'GH-IJ-9876', 'SUV', 'Jeep', 'SUV', 'Loaned', 3),
  ('MH5432', 'JKL901234', 'PUC654', 'KL-MN-5432', 'Mini', 'Honda', 'Mini', 'Personal', 4),
  ('MH2468', 'MNO567890', 'PUC987', 'MN-OP-2468', 'Sedan', 'Hyundai', 'Sedan', 'Rented', 5),
  ('MH1111', 'PQR123456', 'PUC555', 'QR-ST-1111', 'SUV', 'Tesla', 'SUV', 'Loaned', 6),
  ('MH2222', 'STU789012', 'PUC333', 'ST-UV-2222', 'Mini', 'Kia', 'Mini', 'Personal', 7),
  ('MH3333', 'VWX345678', 'PUC222', 'WX-YZ-3333', 'Van', 'Volkswagen', 'Van', 'Rented', 8),
  ('MH4444', 'YZA901234', 'PUC111', 'YZ-AB-4444', 'Sedan', 'Chevrolet', 'Sedan', 'Personal', 9),
  ('MH5555', 'BCD567890', 'PUC999', 'CD-EF-5555', 'SUV', 'BMW', 'SUV', 'Loaned', 10);

-- Sample data for the "Ride" table:
INSERT INTO Ride (ride_id, pickup_time, drop_time, car_pool, cust_rating, driv_rating, reserv_time, review, status, driv_id, pickup_loc_id, drop_loc_id, cust_id)
VALUES
  (1, '2023-01-01 10:00:00', '2023-01-01 10:30:00', 'No', 5, 4, '2023-01-01 09:30:00', 'Excellent service', 'reached destination', 1, 1, 2, 1),
  (2, '2023-02-01 11:15:00', '2023-02-01 11:45:00', 'Yes', 4, 4, '2023-02-01 10:45:00', 'Good ride', 'reached destination', 2, 3, 4, 2),
  (3, '2023-03-01 12:30:00', '2023-03-01 13:00:00', 'No', 5, 5, '2023-03-01 12:00:00', 'Outstanding', 'reached destination', 3, 5, 6, 3),
  (4, '2023-04-01 14:45:00', '2023-04-01 15:15:00', 'Yes', 4, 3, '2023-04-01 14:15:00', 'Could be better', 'reached destination', 4, 7, 8, 4),
  (5, '2023-05-01 16:00:00', '2023-05-01 16:30:00', 'No', 3, 4, '2023-05-01 15:30:00', 'Average ride', 'reached destination', 5, 9, 10, 5),
  (6, '2023-06-01 17:15:00', '2023-06-01 17:45:00', 'No', 4, 5, '2023-06-01 16:45:00', 'Great service', 'reached destination', 6, 2, 1, 6),
  (7, '2023-07-01 18:30:00', '2023-07-01 19:00:00', 'Yes', 5, 4, '2023-07-01 18:00:00', 'Wonderful ride', 'reached destination', 7, 4, 3, 7),
  (8, '2023-08-01 20:45:00', '2023-08-01 21:15:00', 'No', 4, 4, '2023-08-01 20:15:00', 'Good driver', 'reached destination', 8, 6, 5, 8),
  (9, '2023-09-01 22:00:00', '2023-09-01 22:30:00', 'No', 3, 4, '2023-09-01 21:30:00', 'Average service', 'reached destination', 9, 8, 7, 9),
  (10, '2023-10-01 23:15:00', '2023-10-01 23:45:00', 'Yes', 5, 5, '2023-10-01 22:45:00', 'Excellent ride', 'reached destination', 10, 10, 9, 10);

-- Sample data for the "Tracking" table:
INSERT INTO Tracking (time, loc_id, ride_id, cust_id)
VALUES
  ('2023-01-01 10:05:00', 1, 1, 1),
  ('2023-02-01 11:20:00', 3, 2, 2),
  ('2023-03-01 12:35:00', 5, 3, 3),
  ('2023-04-01 14:50:00', 7, 4, 4),
  ('2023-05-01 16:05:00', 9, 5, 5),
  ('2023-06-01 17:20:00', 2, 6, 6),
  ('2023-07-01 18:35:00', 4, 7, 7),
  ('2023-08-01 20:50:00', 6, 8, 8),
  ('2023-09-01 22:05:00', 8, 9, 9),
  ('2023-10-01 23:20:00', 10, 10, 10);

-- Sample data for the "Verify" table:
-- INSERT INTO Verify (pay_timestamp, tax_rate, payment, driv_id, rev_id)
-- VALUES
--   ('2023-01-15 12:00:00', 0.10, 1000.00, 1, 1),
--   ('2023-02-20 12:30:00', 0.12, 1200.00, 2, 2),
--   ('2023-03-10 13:15:00', 0.14, 1400.00, 3, 3),
--   ('2023-04-05 13:45:00', 0.11, 1100.00, 4, 4),
--   ('2023-05-12 14:30:00', 0.13, 1300.00, 5, 5),
--   ('2023-06-18 15:00:00', 0.12, 1200.00, 6, 6),
--   ('2023-07-25 15:45:00', 0.15, 1500.00, 7, 7),
--   ('2023-08-04 16:15:00', 0.11, 1100.00, 8, 8),
--   ('2023-09-15 16:55:00', 0.14, 1400.00, 9, 9),
--   ('2023-10-20 17:30:00', 0.12, 1200.00, 10, 10);

INSERT INTO Verify (pay_timestamp, driv_id, rev_id)
VALUES
  ('2023-01-15 12:00:00', 1, 1),
  ('2023-02-20 12:30:00', 2, 2),
  ('2023-03-10 13:15:00', 3, 3),
  ('2023-04-05 13:45:00', 4, 4),
  ('2023-05-12 14:30:00', 5, 5),
  ('2023-06-18 15:00:00', 6, 6),
  ('2023-07-25 15:45:00', 7, 7),
  ('2023-08-04 16:15:00', 8, 8),
  ('2023-09-15 16:55:00', 9, 9),
  ('2023-10-20 17:30:00', 10, 10);


-- Sample data for the "Car_loan" table with emi_amount constraint:
INSERT INTO Car_loan (amount, interest_rate, tenure, emi_amount, status, loan_id, driv_id, guarantor_id, chassis_num, unpaid_amount)
VALUES
  (200000.00, 5.00, 6.00, 4000.00, 'Partially paid', 1, 1, 1, 'ABC123456', 100000),
  (250000.00, 6.00, 5.00, 5000.00, 'Completely paid', 2, 2, 2, 'DEF789012', 0),
  (300000.00, 5.50, 7.00, 4500.00, 'Zero installments', 3, 3, 3, 'GHI345678', 300000.00),
  (220000.00, 6.50, 4.00, 5500.00, 'Partially paid', 4, 4, 4, 'JKL901234', 210000.00),
  (280000.00, 5.00, 6.00, 4200.00, 'Completely paid', 5, 5, 5, 'MNO567890', 0),
  (210000.00, 6.00, 5.00, 4800.00, 'Partially paid', 6, 6, 6, 'PQR123456', 200000.00),
  (260000.00, 5.50, 7.00, 4400.00, 'Zero installments', 7, 7, 7, 'STU789012', 260000.00),
  (240000.00, 6.50, 4.00, 5200.00, 'Zero installments', 8, 8, 8, 'VWX345678', 240000.00),
  (290000.00, 5.00, 6.00, 4600.00, 'Completely paid', 9, 9, 9, 'YZA901234', 0),
  (270000.00, 6.00, 5.00, 5400.00, 'Partially paid', 10, 10, 10, 'BCD567890', 260000.00);

-- Sample data for the "Loan_payment" table:
INSERT INTO Loan_payment (timestamp, amount, mode, gateway, driv_id, loan_id)
VALUES
  ('2023-01-15 10:30:00', 200000.00, 'Online', 'PayPal', 1, 1),
  ('2023-02-15 11:45:00', 250000.00, 'Cheque', 'Bank Transfer', 2, 2),
  ('2023-03-15 09:15:00', 300000.00, 'Cash', 'Cash Payment', 3, 3),
  ('2023-04-15 14:20:00', 220000.00, 'Online', 'PayPal', 4, 4),
  ('2023-05-15 13:10:00', 280000.00, 'Cheque', 'Bank Transfer', 5, 5),
  ('2023-06-15 16:50:00', 210000.00, 'Cash', 'Cash Payment', 6, 6),
  ('2023-07-15 08:25:00', 260000.00, 'Online', 'PayPal', 7, 7),
  ('2023-08-15 12:55:00', 240000.00, 'Cheque', 'Bank Transfer', 8, 8),
  ('2023-09-15 09:40:00', 290000.00, 'Cash', 'Cash Payment', 9, 9),
  ('2023-10-15 14:15:00', 270000.00, 'Online', 'PayPal', 10, 10);

-- Sample data for the "Charges" table:
INSERT INTO Charges (amount, timestamp, status, mode_of_payment, ride_id, cust_id)
VALUES
  (50.00, '2023-01-01 10:30:00', 'Completed', 'Online', 1, 1),
  (40.00, '2023-02-01 11:45:00', 'Completed', 'Cash', 2, 2),
  (30.00, '2023-03-01 13:00:00', 'Pending', 'Online', 3, 3),
  (60.00, '2023-04-01 15:15:00', 'Completed', 'Cash', 4, 4),
  (35.00, '2023-05-01 16:30:00', 'Pending', 'Online', 5, 5),
  (45.00, '2023-06-01 17:45:00', 'Completed', 'Cash', 6, 6),
  (55.00, '2023-07-01 19:00:00', 'Pending', 'Cash', 7, 7),
  (70.00, '2023-08-01 21:15:00', 'Pending', 'Cash', 8, 8),
  (65.00, '2023-09-01 22:30:00', 'Pending', 'Online', 9, 9),
  (75.00, '2023-10-01 23:45:00', 'Pending', 'Online', 10, 10);

-- Sample data for the "Commission" table:
INSERT INTO Commission (timestamp, earning, driv_id, ride_id, cust_id)
VALUES
  ('2023-01-01 10:30:00', 50.00, 1, 1, 1),
  ('2023-02-01 11:45:00', 40.00, 2, 2, 2),
  ('2023-03-01 13:00:00', 30.00, 3, 3, 3),
  ('2023-04-01 15:15:00', 60.00, 4, 4, 4),
  ('2023-05-01 16:30:00', 35.00, 5, 5, 5),
  ('2023-06-01 17:45:00', 45.00, 6, 6, 6),
  ('2023-07-01 19:00:00', 55.00, 7, 7, 7),
  ('2023-08-01 21:15:00', 70.00, 8, 8, 8),
  ('2023-09-01 22:30:00', 65.00, 9, 9, 9),
  ('2023-10-01 23:45:00', 75.00, 10, 10, 10);

-- Sample data for the "Customer_phone" table:
INSERT INTO Customer_phone (phone, cust_id)
VALUES
  ('111-222-3333', 1),
  ('222-333-4444', 2),
  ('333-444-5555', 3),
  ('444-555-6666', 4),
  ('555-666-7777', 5),
  ('666-777-8888', 6),
  ('777-888-9999', 7),
  ('888-999-0000', 8),
  ('999-000-1111', 9),
  ('000-111-2222', 10);

-- Sample data for the "Driver_phone" table with different phone numbers:
INSERT INTO Driver_phone (phone, driv_id)
VALUES
  ('111-222-4444', 1),
  ('222-333-5555', 2),
  ('333-444-6666', 3),
  ('444-555-7777', 4),
  ('555-666-8888', 5),
  ('666-777-9999', 6),
  ('777-888-0000', 7),
  ('888-999-1111', 8),
  ('999-000-2222', 9),
  ('000-111-3333', 10);