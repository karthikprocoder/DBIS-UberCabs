
# DBIS group project : Uber Cabs
In this project we have made a database schema for Uber Cabs and implemented some of the functionalities using python scripts.

## Steps to setup
1) Install the required python libraries
```
pip install psycopg2 tabulate inquirer numpy bcrypt
```
2) Create a database with name **ubercabs** and fill in your credentials in credentials.py
3) Use the create_tables.sql file in the schema folder to create tables and populate it using populate.sql

## Files
1) ride.py: Simulates the ride for a customer, right from booking the cab to reaching the destination
2) customer.py: A dashboard interface for customer
3) driver.py: A dashboard for the driver.
4) admin.py: Will be used by the UberCab admin to monitor and fetch statistics
5) loan.py and loan_payment.py: Driver-loan queries
  
## Team Members
- Aditya Zanjurne (210010001)
- Divy Jain (210010015)
- Karthik Hegde (210010022)
- Cebajel Tanan (210010055)