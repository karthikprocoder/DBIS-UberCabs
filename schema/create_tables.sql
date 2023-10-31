CREATE TABLE Location
(
  loc_id INT NOT NULL,
  latitude NUMERIC(8, 5) NOT NULL,
  longitude NUMERIC(8, 5) NOT NULL,
  name VARCHAR(50),
  city VARCHAR(50) DEFAULT 'Pune',
  street VARCHAR(50) UNIQUE,
  country VARCHAR(50) DEFAULT 'India',
  landmark VARCHAR(50),
  state VARCHAR(50) DEFAULT 'MH',
  PRIMARY KEY (loc_id)
);

CREATE TABLE Reviewer
(
  rev_fname VARCHAR(50) NOT NULL,
  rev_lname VARCHAR(50) NOT NULL,
  dob DATE NOT NULL,
  email VARCHAR(50) NOT NULL,
  date_of_join DATE NOT NULL,
  rev_id INT NOT NULL,
  loc_id INT NOT NULL,
  PRIMARY KEY (rev_id),
  FOREIGN KEY (loc_id) REFERENCES Location(loc_id),
  CHECK(dob < date_of_join)
);

CREATE TABLE Guarantor
(
  guarantor_fname VARCHAR(50) NOT NULL,
  guarantor_lname VARCHAR(50) NOT NULL,
  guarantor_email VARCHAR(50) UNIQUE NOT NULL,
  guarantor_id INT NOT NULL,
  loc_id INT NOT NULL,
  PRIMARY KEY (guarantor_id),
  FOREIGN KEY (loc_id) REFERENCES Location(loc_id)
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
  email VARCHAR(50) UNIQUE,
  dob DATE,
  cust_id INT NOT NULL,
  loc_id INT,
  PRIMARY KEY (cust_id),
  FOREIGN KEY (loc_id) REFERENCES Location(loc_id)
);

CREATE TABLE Driver
(
  driv_fname VARCHAR(50) NOT NULL,
  driv_lname VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  dob DATE NOT NULL,
  date_of_join DATE NOT NULL,
  driv_lic_num VARCHAR(20) NOT NULL,
  driv_id INT NOT NULL,
  commission_rate NUMERIC(4, 2) NOT NULL CHECK(commission_rate > 0),
  loc_id INT NOT NULL,
  PRIMARY KEY (driv_id),
  FOREIGN KEY (loc_id) REFERENCES Location(loc_id),
  CHECK(dob < date_of_join)
);

CREATE TABLE Vehicle_generics
(
  vehicle_type VARCHAR(10) NOT NULL,
  extra_per NUMERIC(4, 2) NOT NULL,
  capacity INT NOT NULL,
  PRIMARY KEY (vehicle_type)
);

CREATE TABLE Vehicle
(
  registration_num VARCHAR(20) NOT NULL,
  chassis_num VARCHAR(20) NOT NULL,
  puc_num VARCHAR(20) NOT NULL,
  number_plate VARCHAR(12) NOT NULL,
  model VARCHAR(20) NOT NULL,
  company VARCHAR(20) NOT NULL,
  -- variant VARCHAR(20) NOT NULL,
  type VARCHAR(10) NOT NULL,
  ownership VARCHAR(10) NOT NULL CHECK(ownership IN ('Personal', 'Rented', 'Loaned')),
  driv_id INT NOT NULL,
  PRIMARY KEY (chassis_num),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (type) REFERENCES Vehicle_generics(vehicle_type)
);

CREATE TABLE Ride
(
  -- distance NUMERIC(4, 1) NOT NULL CHECK(distance > 0),
  pickup_time TIMESTAMP,
  drop_time TIMESTAMP,
  car_pool VARCHAR(5) DEFAULT 'No' CHECK(car_pool IN ('Yes', 'No')),
  cust_rating INT CHECK(cust_rating >= 0 AND cust_rating <= 5),
  driv_rating INT CHECK(driv_rating >= 0 AND driv_rating <= 5),
  reserv_time TIMESTAMP,
  ride_id INT NOT NULL,
  review VARCHAR(200),
  -- charge_per_km NUMERIC(4, 2) NOT NULL CHECK(charge_per_km > 0),
  status VARCHAR(20) NOT NULL,
  driv_id INT,
  pickup_loc_id INT NOT NULL,
  drop_loc_id INT NOT NULL,
  cust_id INT NOT NULL,
  PRIMARY KEY (ride_id, cust_id),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (pickup_loc_id) REFERENCES Location(loc_id),
  FOREIGN KEY (drop_loc_id) REFERENCES Location(loc_id),
  FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
  CHECK(reserv_time <= pickup_time AND pickup_time <= drop_time),
  CHECK(status IN ('on the way', 'ongoing', 'reached destination'))
);

CREATE TABLE Tracking
(
  time TIMESTAMP NOT NULL,
  loc_id INT NOT NULL,
  ride_id INT NOT NULL,
  cust_id INT NOT NULL,
  FOREIGN KEY (loc_id) REFERENCES Location(loc_id),
  FOREIGN KEY (ride_id, cust_id) REFERENCES Ride(ride_id, cust_id)
);

CREATE TABLE Verify
(
  pay_timestamp TIMESTAMP NOT NULL,
  -- tax_rate NUMERIC(4, 2) NOT NULL,
  -- payment NUMERIC(7, 2) NOT NULL,
  driv_id INT,
  rev_id INT,
  PRIMARY KEY (driv_id, rev_id),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (rev_id) REFERENCES Reviewer(rev_id)
);

CREATE TABLE Car_loan
(
  amount NUMERIC(8, 2) NOT NULL CHECK(amount > 0),
  unpaid_amount NUMERIC(8, 2) NOT NULL,
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
  FOREIGN KEY (chassis_num) REFERENCES Vehicle(chassis_num),
  CHECK(
    status =
    CASE
    WHEN amount = unpaid_amount THEN 'Zero installments'
    WHEN unpaid_amount = 0 THEN 'Completely paid'
    WHEN unpaid_amount <= amount THEN 'Partially paid'
    END
  )
);

CREATE TABLE Loan_payment
(
  timestamp TIMESTAMP NOT NULL,
  amount NUMERIC(8, 2) NOT NULL,
  mode VARCHAR(20) NOT NULL CHECK(mode IN ('Online', 'Cheque', 'Cash')),
  -- status VARCHAR(20) NOT NULL CHECK(status IN ('Zero installments', 'Partially paid', 'Completely paid')),
  gateway VARCHAR(20),
  -- tax_rate NUMERIC(4, 2) NOT NULL CHECK(tax_rate > 0),
  -- balance_amt NUMERIC(8, 2) NOT NULL CHECK(balance_amt <= amount AND balance_amt > 0),
  driv_id INT,
  loan_id INT,
  PRIMARY KEY (loan_id, timestamp),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (loan_id) REFERENCES Car_loan(loan_id),
  CHECK(gateway =
  CASE
  WHEN mode = 'Online' THEN 'PayPal'
  ELSE NULL
  END)
  -- CHECK(
  --   status =
  --   CASE
  --   WHEN amount = balance_amt THEN 'Zero installments'
  --   WHEN balance_amt = 0 THEN 'Completely paid'
  --   WHEN balance_amt <= amount THEN 'Partially paid'
  --   END
  -- )
);

CREATE TABLE Charges
(
  amount NUMERIC(5, 2) NOT NULL CHECK(amount > 0),
  timestamp TIMESTAMP DEFAULT current_timestamp,
  -- late_fees NUMERIC(5, 2) NOT NULL CHECK(late_fees >= 0),
  -- purpose_of_pay VARCHAR(50) NOT NULL,
  status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Completed')),
  mode_of_payment VARCHAR(20) NOT NULL CHECK(mode_of_payment IN ('Online', 'Cash')),
  ride_id INT NOT NULL,
  cust_id INT NOT NULL,
  PRIMARY KEY (ride_id, cust_id),
  FOREIGN KEY (ride_id, cust_id) REFERENCES Ride(ride_id, cust_id)
);

CREATE TABLE Commission
(
  -- purpose_of_pay VARCHAR(50) NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  -- bonus NUMERIC(5, 2) NOT NULL CHECK(bonus >= 0),
  -- tax NUMERIC(5, 2) NOT NULL CHECK(tax > 0),
  earning NUMERIC(4, 2),
  driv_id INT,
  ride_id INT NOT NULL,
  cust_id INT NOT NULL,
  PRIMARY KEY (ride_id, cust_id),
  FOREIGN KEY (driv_id) REFERENCES Driver(driv_id),
  FOREIGN KEY (ride_id, cust_id) REFERENCES Ride(ride_id, cust_id)
);

-- CREATE TABLE Stops
-- (
--   loc_id INT NOT NULL,
--   ride_id INT NOT NULL,
--   cust_id INT NOT NULL,
--   FOREIGN KEY (loc_id) REFERENCES Location(loc_id),
--   FOREIGN KEY (ride_id, cust_id) REFERENCES Ride(ride_id, cust_id)
-- );

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