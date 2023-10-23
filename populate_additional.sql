INSERT INTO customer(cust_fname, cust_lname, email, dob, cust_id, loc_id)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '1990-01-15', 1, 1),
    ('Jane', 'Smith', 'jane.smith@example.com', '1985-03-20', 2, 2),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '1995-07-10', 3, 1),
    ('Bob', 'Williams', 'bob.williams@example.com', '1980-11-25', 4, 2),
    ('Eve', 'Anderson', 'eve.anderson@example.com', '1992-04-30', 5, 2);


INSERT INTO ride (
    pickup_time, drop_time, car_pool, cust_rating, driv_rating, reserv_time, ride_id, review, status, driv_id, pickup_loc_id, drop_loc_id, cust_id
) 
VALUES  
    (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '1 hour', 'No', 1, 2, CURRENT_TIMESTAMP, 1, 'Review 1', 'reached destination', 1, 1, 2, 1),
    (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '2 hours', 'Yes', 1, 3, CURRENT_TIMESTAMP, 2, 'Review 2', 'reached destination', 1, 1, 2, 1),
    (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '3 hours', 'No', 1, 3, CURRENT_TIMESTAMP, 3, 'Review 3', 'ongoing', 1, 1, 2, 2),
    (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '4 hours', 'Yes', 1, 4, CURRENT_TIMESTAMP, 2, 'Review 4', 'reached destination', 1, 1, 2, 2),
    (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '5 hours', 'No', 1, 1, CURRENT_TIMESTAMP, 4, 'Review 5', 'reached destination', 1, 1, 2, 1);
		
INSERT INTO commission("timestamp", earning, driv_id, ride_id, cust_id)
VALUES
    (CURRENT_TIMESTAMP, 25.0, 1, 1, 1),
    (CURRENT_TIMESTAMP, 30.0, 1, 2, 1),
    (CURRENT_TIMESTAMP, 20.0, 1, 3, 2),
    (CURRENT_TIMESTAMP, 35.0, 1, 2, 2);
