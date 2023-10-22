INSERT INTO Location (loc_id, latitude, longitude, name, city, street, country, landmark, state)
VALUES 
    (1, 37.7749, -122.4194, 'Joggers Park', 'Pune', 'Rd. 17', 'India', 'CCD', 'MH'),
    (2, 51.5074, -0.1278, 'Phoenix Mall', 'Pune', '123 Hyde St', 'India', 'Hyde Park Corner', 'MH'),
    (3, 52.5200, 13.4050, 'SC Gate', 'Pune', 'Shastri Chowk', 'India', 'Apple Store', 'MH');

INSERT INTO Driver (driv_fname, driv_lname, email, dob, date_of_join, driv_lic_num, driv_id, commission_rate, loc_id)
VALUES
    ('Ravi', 'Kumar', 'ravi@gmail.com', '1989-06-12', '2021-12-05', 'MH453456', 1, 0.15, 1),
    ('Aria', 'Wilson', 'aria.wilson@email.com', '1995-03-28', '2022-01-10', 'DL789012', 2, 0.18, 2),
    ('Ava', 'Miller', 'ava@email.com', '1992-02-04', '2021-09-30', 'DL234567', 3, 0.18, 3);

INSERT INTO Vehicle (registration_num, chassis_num, Capacity, puc_num, number_plate, model, company, type, ownership, driv_id)
VALUES
    ('CA123ABC', 'CH00001', 4, 'PUC1234', '123ABC', 'Sedan', 'Toyota', 'Sedan', 'Personal', 1),
    ('UK456DEF', 'CH00002', 5, 'PUC5678', '456DEF', 'SUV', 'Mini Cooper', 'SUV','Rented', 2),
    ('DE456PQR', 'CH00003', 5, 'PUC5566', '456PQR', 'Transporter', 'Volkswagen', 'SUV', 'Personal', 3);

INSERT INTO Driver_phone (phone, driv_id) 
VALUES
    ('114-1561-790', 1),
    ('214-1561-790', 2),
    ('314-1561-790', 3);