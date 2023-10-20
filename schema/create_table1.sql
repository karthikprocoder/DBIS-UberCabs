CREATE TABLE Location
(
  latitude NUMERIC(8, 5) NOT NULL,
  longitude NUMERIC(8, 5) NOT NULL,
  name VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  street VARCHAR(50) NOT NULL,
  country VARCHAR(50) NOT NULL,
  landmark VARCHAR(50) NOT NULL,
  state VARCHAR(50) NOT NULL,
  PRIMARY KEY (latitude, longitude)
);

CREATE TABLE Reviewer
(
  rev_fname VARCHAR(50) NOT NULL,
  rev_lname VARCHAR(50) NOT NULL,
  dob DATE NOT NULL,
  email VARCHAR(50) NOT NULL,
  date_of_join DATE NOT NULL,
  rev_id INT NOT NULL,
  latitude NUMERIC(8, 5),
  longitude NUMERIC(8, 5),
  PRIMARY KEY (rev_id),
  FOREIGN KEY (latitude, longitude) REFERENCES Location(latitude, longitude),
  CHECK(dob < date_of_join)
);

CREATE TABLE Guarantor
(
  guarantor_fname VARCHAR(50) NOT NULL,
  guarantor_lname VARCHAR(50) NOT NULL,
  guarantor_email VARCHAR(50) NOT NULL,
  guarantor_id INT NOT NULL,
  latitude NUMERIC(8, 5),
  longitude NUMERIC(8, 5),
  PRIMARY KEY (guarantor_id),
  FOREIGN KEY (latitude, longitude) REFERENCES Location(latitude, longitude)
);

CREATE TABLE Reviewer_phone
(
  phone VARCHAR(12) NOT NULL,
  rev_id INT NOT NULL,
  PRIMARY KEY (phone, rev_id),
  FOREIGN KEY (rev_id) REFERENCES Reviewer(rev_id)
);

CREATE TABLE Guarantor_guarantor_phone
(
  guarantor_phone VARCHAR(12) NOT NULL,
  guarantor_id INT NOT NULL,
  PRIMARY KEY (guarantor_phone, guarantor_id),
  FOREIGN KEY (guarantor_id) REFERENCES Guarantor(guarantor_id)
);

CREATE TABLE Customer
(
  cust_fname VARCHAR(50) NOT NULL,
  cust_lname VARCHAR(50) NOT NULL,
  email VARCHAR(50),
  dob DATE,
  cust_id INT NOT NULL,
  latitude NUMERIC(8, 5),
  longitude NUMERIC(8, 5),
  PRIMARY KEY (cust_id),
  FOREIGN KEY (latitude, longitude) REFERENCES Location(latitude, longitude)
);

CREATE TABLE Driver
(
  driv_fname VARCHAR(50) NOT NULL,
  driv_lname VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  dob DATE NOT NULL,
  date_of_join DATE NOT NULL,
  driv_lic_num VARCHAR(20) NOT NULL,
  driv_id INT NOT NULL,
  commission_rate NUMERIC(4, 2) NOT NULL CHECK(commission_rate > 0),
  latitude NUMERIC(8, 5),
  longitude NUMERIC(8, 5),
  PRIMARY KEY (driv_id),
  FOREIGN KEY (latitude, longitude) REFERENCES Location(latitude, longitude),
  CHECK(dob < date_of_join)
);

CREATE TABLE Vehicle
(
  registration_num VARCHAR(20) NOT NULL,
  chassis_num VARCHAR(20) NOT NULL,
  Capacity INT NOT NULL CHECK(Capacity > 0 AND Capacity <= 6),
  puc_num VARCHAR(20) NOT NULL,
  number_plate VARCHAR(12) NOT NULL,
  model VARCHAR(20) NOT NULL,
  company VARCHAR(20) NOT NULL,
  -- variant VARCHAR(20) NOT NULL,
  type VARCHAR(10) NOT NULL CHECK(type IN ('Auto-Rick', 'Mini', 'Sedan', 'Van', 'SUV', 'Premium')),
  ownership VARCHAR(10) NOT NULL CHECK(ownership IN ('Personal', 'Rented', 'Loaned')),
  driv_id INT NOT NULL,
  PRIMARY KEY (chassis_num),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id)
);

CREATE TABLE Ride
(
  distance NUMERIC(4, 1) NOT NULL CHECK(distance > 0),
  pickup_time TIMESTAMP NOT NULL,
  drop_time TIMESTAMP NOT NULL,
  car_pool VARCHAR(5) NOT NULL CHECK(car_pool IN ('Yes', 'No')),
  cust_rating INT NOT NULL CHECK(cust_rating >= 0 AND cust_rating <= 5),
  driv_rating INT NOT NULL CHECK(driv_rating >= 0 AND driv_rating <= 5),
  reserv_time TIMESTAMP NOT NULL,
  ride_id INT NOT NULL,
  review VARCHAR(200),
  charge_per_km NUMERIC(4, 2) NOT NULL CHECK(charge_per_km > 0),
  status VARCHAR(20) NOT NULL,
  driv_id INT,
  latitude NUMERIC(8, 5),
  longitude NUMERIC(8, 5),
  pickuplatitude NUMERIC(8, 5),
  pickuplongitude NUMERIC(8, 5),
  cust_id INT NOT NULL,
  PRIMARY KEY (ride_id, cust_id),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (latitude, longitude) REFERENCES Location(latitude, longitude),
  FOREIGN KEY (pickuplatitude, pickuplongitude) REFERENCES Location(latitude, longitude),
  FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
  CHECK(reserv_time <= pickup_time AND pickup_time <= drop_time),
  CHECK(status IN ('on the way', 'picked up', 'ongoing', 'reached destination'))
);

CREATE TABLE Tracking
(
  time TIMESTAMP NOT NULL,
  latitude NUMERIC(8, 5),
  longitude NUMERIC(8, 5),
  ride_id INT NOT NULL,
  cust_id INT NOT NULL,
  FOREIGN KEY (latitude, longitude) REFERENCES Location(latitude, longitude),
  FOREIGN KEY (ride_id, cust_id) REFERENCES Ride(ride_id, cust_id)
);

CREATE TABLE Verify
(
  pay_timestamp TIMESTAMP NOT NULL,
  tax_rate NUMERIC(4, 2) NOT NULL,
  payment NUMERIC(7, 2) NOT NULL,
  driv_id INT,
  rev_id INT,
  PRIMARY KEY (driv_id, rev_id),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (rev_id) REFERENCES Reviewer(rev_id)
);

CREATE TABLE Car_loan
(
  amount NUMERIC(8, 2) NOT NULL CHECK(amount > 0),
  interest_rate NUMERIC(4, 2) NOT NULL CHECK(interest_rate > 0),
  tenure NUMERIC(4, 2) NOT NULL CHECK(tenure > 0),
  emi_amount NUMERIC(7, 2) NOT NULL CHECK(emi_amount >= 4000),
  status VARCHAR(20) NOT NULL CHECK(status IN ('Zero installments', 'Partially paid', 'Completely paid')),
  loan_id INT NOT NULL,
  driv_id INT,
  guarantor_id INT NOT NULL,
  chassis_num VARCHAR(20),
  PRIMARY KEY (loan_id),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (guarantor_id) REFERENCES Guarantor(guarantor_id),
  FOREIGN KEY (chassis_num) REFERENCES Vehicle(chassis_num)
);

CREATE TABLE Loan_payment
(
  timestamp TIMESTAMP NOT NULL,
  amount NUMERIC(8, 2) NOT NULL,
  mode VARCHAR(20) NOT NULL CHECK(mode IN ('Online', 'Cheque', 'Cash')),
  status VARCHAR(20) NOT NULL CHECK(status IN ('Zero installments', 'Partially paid', 'Completely paid')),
  gateway VARCHAR(20) NOT NULL,
  tax_rate NUMERIC(4, 2) NOT NULL CHECK(tax_rate > 0),
  balance_amt NUMERIC(8, 2) NOT NULL CHECK(balance_amt <= amount AND balance_amt > 0),
  driv_id INT,
  loan_id INT,
  PRIMARY KEY (driv_id, loan_id),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (loan_id) REFERENCES Car_loan(loan_id),
  CHECK(gateway =
  CASE
  WHEN mode = 'Online' THEN 'PayPal'
  ELSE NULL
  END)
);

CREATE TABLE Charges
(
  tax NUMERIC(5, 2) NOT NULL CHECK(tax > 0),
  timestamp TIMESTAMP NOT NULL,
  late_fees NUMERIC(5, 2) NOT NULL CHECK(late_fees >= 0),
  purpose_of_pay VARCHAR(50) NOT NULL,
  mode_of_payment VARCHAR(20) NOT NULL CHECK(mode_of_payment IN ('Online', 'Cash')),
  ride_id INT NOT NULL,
  cust_id INT NOT NULL,
  PRIMARY KEY (ride_id, cust_id),
  FOREIGN KEY (ride_id, cust_id) REFERENCES Ride(ride_id, cust_id)
);

CREATE TABLE Commission
(
  purpose_of_pay VARCHAR(50) NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  bonus NUMERIC(5, 2) NOT NULL CHECK(bonus >= 0),
  tax NUMERIC(5, 2) NOT NULL CHECK(tax > 0),
  driv_id INT,
  ride_id INT NOT NULL,
  cust_id INT NOT NULL,
  PRIMARY KEY (ride_id, cust_id),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (ride_id, cust_id) REFERENCES Ride(ride_id, cust_id)
);

CREATE TABLE Stops
(
  latitude NUMERIC(8, 5),
  longitude NUMERIC(8, 5),
  ride_id INT NOT NULL,
  cust_id INT NOT NULL,
  FOREIGN KEY (latitude, longitude) REFERENCES Location(latitude, longitude),
  FOREIGN KEY (ride_id, cust_id) REFERENCES Ride(ride_id, cust_id)
);

CREATE TABLE Customer_phone
(
  phone VARCHAR(12) NOT NULL,
  cust_id INT NOT NULL,
  PRIMARY KEY (phone, cust_id),
  FOREIGN KEY (cust_id) REFERENCES Customer(cust_id)
);

CREATE TABLE Driver_phone
(
  phone VARCHAR(12) NOT NULL,
  driv_id INT NOT NULL,
  PRIMARY KEY (phone, driv_id),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id)
);
