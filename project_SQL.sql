create database bank_management_system;
use bank_management_system;
create table branchees(branch_id int primary key auto_increment,branch_name varchar(100),city varchar(100),ifsc_code varchar(50) unique);
create table customers(customer_id int primary key auto_increment,first_name varchar(100),last_name varchar(100),phone varchar(50),email varchar(50),address varchar(100));
create table accountss(account_id int primary key auto_increment,customer_id int,branch_id int,account_type varchar(50),balance decimal(20,2),opening_date date,foreign key(customer_id)references customers(customer_id),foreign key (branch_id)references branchees(branch_id));#references means here customer_id(foregin key)in accounts table,it refers cust_id in cust_table,same as branch id too (##(20,2)means 20 is the value 2 is the value after the decimal point i.e .00)
create table employees(employee_id int primary key auto_increment,employee_name varchar(100),designation varchar(50),salary decimal(20,2),joining_date date,branch_id int,foreign key (branch_id) references branchees(branch_id));
create table transactions(transaction_id int primary key  auto_increment,account_id int,transaction_type varchar(100),amount decimal(20,2),transaction_date date,foreign key(account_id)references accountss(account_id));
create table loans(loan_id int primary key auto_increment,customer_id int,loan_type varchar(50),loan_amount decimal(20,2),interst_rate decimal(20,2),loan_status varchar(50),foreign key(customer_id) references customers(customer_id));
insert into branchees(branch_id,branch_name,city,ifsc_code) values (1,"hyderabad branch","hyderabad","SBIN0001001"),(2,"vijayawada branch","vijayawada","SBIN0001002"),(3,"visakhapatnam branch","visakhapatnam","SBIN0001003");
insert into customers(customer_id,first_name,last_name,phone,email,address)values(1,"gowthami","chowdary","9876543210","gowthami@gmail.com","hyderabad"),(2,"pawan","kalyan","9876543211","kalyan@gmail.com","vijayawada"),(3,"priya","reddy","9876543212","priya@gmail.com","visakhapatnam");
insert into accountss(customer_id,branch_id,account_type,balance,opening_date)values(1,1,"savings",50000.00,"2026-01-21"),(2,2,"current",75000.00,"2026-04-18"),(3,3,"savings",100000.00,"2026-07-23");
insert into employees(employee_id,employee_name,designation,salary,joining_date,branch_id)values(1,"ramesh","manager",65000.00,"2020-06-15",1),(2,"suresh","cashier",35000.00,"2021-03-20",2),(3,"anitha","clerk",30000.00,"2022-07-10",3);
insert into transactions(transaction_id,account_id,transaction_type,amount,transaction_date) values(1,1,"depoist",10000.00,"2024-04-01"),(2,2,"withdrawal",5000.00,"2024-04-05"),(3,3,"depoist",20000.00,"2024-04-08");
insert into loans(loan_id,customer_id,loan_type,loan_ammount,interst_rate,loan_status)values(1,1,"home loan",1500000.00,8.5,"approved"),(2,2,"car",500000.00,9.0,"pending"),(3,3,"education loan",300000.00,7.5,"approved");
select*from branchees;
select*from customers;
select*from accountss;
select*from employees;
select*from transactions;
select*from loans;
#SELECT QUERY
#1a
select*from customers;
#1b
select customer_id,first_name,phone from customers;
#1c
select c.first_name,a.balance,a.balance*12 as annual_balance from customers c join accountss a on c.customer_id=a.customer_id;
#2.SELECT WITH WHERE CLAUSE
#2a
select employee_name,designation,salary from employees where salary >20000;
#2b
select c.first_name,c.email from customers c join accounts a on c.customer_id = a.customer_id where month(a.opening_date) = 4;
#2c
select*from accountss where branch_id=2;
#2d
select first_name,email,phone from customers where last_name="reddy";
#2e
select employee_name,designation,salary from employees where salary between 30000 and 65000;
#2f
select first_name,email from customers where phone is null;
#2g
select employee_name,joining_date,branch_id from employees where year (joining_date)<2022 and month(joining_date)<7;
#2h
select employee_name,salary from employees where salary between 30000 and 35000 or salary;
#2i
select account_id,transaction_type,amount from transactions where account_id between 1 and 2;
#2j
select * from employees where designation like "%manager%";
#2k
select*from employees where designation like "__o%";
#2l
select distinct last_name from customers;
#2m
select distinct account_type,balance from accountss;
#JOIN QUERY
#3a
SELECT c.first_name, a.account_type, a.balance FROM customers c JOIN accountss a ON c.customer_id = a.customer_id;
#3b
SELECT e.employee_name, b.branch_name, e.designation FROM employees e JOIN branchees b ON e.branch_id = b.branch_id;
#3c
SELECT c.first_name, c.email, l.loan_type, l.loan_ammount FROM customers c JOIN loans l ON c.customer_id = l.customer_id;
#3d
SELECT b.branch_name, b.city, a.account_type FROM branchees b JOIN accountss a ON b.branch_id = a.branch_id;
#3e
SELECT c.first_name, a.account_type, a.balance,b.branch_name, b.city FROM customers c JOIN accountss a ON c.customer_id = a.customer_id JOIN branchees b ON a.branch_id = b.branch_id;
#3f
SELECT e.employee_name, b.branch_name, b.city FROM employees e JOIN branchees b ON e.branch_id = b.branch_id;
#GROUP BY
#4a
SELECT branch_id, COUNT(customer_id) AS total_customers FROM accountss GROUP BY branch_id;
#4b
SELECT branch_id, SUM(balance) AS total_balance FROM accountss GROUP BY branch_id;
#4c
SELECT designation, AVG(salary) AS average_salary FROM employees GROUP BY designation;
#4d
SELECT designation, MAX(salary) AS maximum_salary FROM employees GROUP BY designation;
#4e
SELECT loan_type, MIN(loan_ammount) AS minimum_loan FROM loans GROUP BY loan_type;
#4f
SELECT account_type, SUM(balance) AS total_balance FROM accountss GROUP BY account_type;
#SUB QUERY
#5a
SELECT c.first_name, a.balance FROM customers c JOIN accountss a ON c.customer_id = a.customer_id WHERE a.balance >
(
    SELECT AVG(balance)
    FROM accountss
);
#5b
SELECT employee_name, designation, salary FROM employees WHERE salary > 
(
    SELECT AVG(salary)
    FROM employees
);
#5c
SELECT first_name, last_name FROM customers WHERE customer_id IN
(
    SELECT customer_id
    FROM loans
    WHERE loan_status = 'approved'
);