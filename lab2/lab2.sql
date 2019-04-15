/*
Lab 1 report    Filip, filer358
                Gustav, gussv375
                Jimmy, jimbj685
                
/*
Drop all user created tables that have been created when solving the lab
*/
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS jbmanager CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;
DROP TABLE IF EXISTS Account CASCADE;
DROP TABLE IF EXISTS Transaction CASCADE;

SOURCE company_schema.sql;
SOURCE company_data.sql;
DROP TABLE jbdebit; /* NOT USED ANYMORE */
SET FOREIGN_KEY_CHECKS=1;

/*
Question 3: Implement your extensions in the database by first creating tables, if any, then
populating them with existing manager data, then adding/modifying foreign key
constraints. Do you have to initialize the bonus attribute to a value? Why?

Answere: Yes, we have to initialize jbmanager's bonus attribute to a value since if the value is NULL we can't treat it like a value (int). If it where NULL we couldn't 
do question 4 since we use the old value in the bonus attribute and add 10 000 to it. That can't be done if the value in the bonus attribute is NULL since it can't be treater
like a value (int).

*/
CREATE TABLE jbmanager(
       id INT,	     
       bonus INT DEFAULT 0,
       PRIMARY KEY (id)
);
/*
Query OK, 0 rows affected (0.18 sec)
*/

INSERT INTO jbmanager(id)
SELECT DISTINCT manager FROM jbdept;
/*
Query OK, 11 rows affected (0.01 sec)
Records: 11  Duplicates: 0  Warnings: 0
*/

INSERT INTO jbmanager(id)
SELECT DISTINCT manager FROM jbemployee
WHERE manager IS NOT NULL AND manager NOT IN (SELECT id FROM jbmanager);
/*
Query OK, 1 row affected (0.02 sec)
Records: 1  Duplicates: 0  Warnings: 0
*/

ALTER TABLE jbdept DROP FOREIGN KEY fk_dept_mgr;
ALTER TABLE jbemployee DROP FOREIGN KEY fk_emp_mgr;
/*
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

ALTER TABLE jbdept
ADD CONSTRAINT `fk_dept_mgr` 
FOREIGN KEY (`manager`) REFERENCES `jbmanager`(`id`);
/*
Query OK, 19 rows affected (0.18 sec)
Records: 19  Duplicates: 0  Warnings: 0
*/

ALTER TABLE jbemployee
ADD CONSTRAINT `fk_emp_mgr`
FOREIGN KEY (manager) REFERENCES jbmanager(id);
/*
Query OK, 25 rows affected (0.17 sec)
Records: 25  Duplicates: 0  Warnings: 0
*/

/*
Question 4: All departments showed good sales figures last year! Give all current department
managers $10,000 in bonus. This bonus is an addition to other possible bonuses
they have.
*/
UPDATE jbmanager SET bonus = bonus + 10000
WHERE id IN (SELECT DISTINCT manager FROM jbdept);
/*
Query OK, 11 rows affected (0.01 sec)
Rows matched: 11  Changed: 11  Warnings: 0
*/


/*
Question 5B: Implement your extensions in your database. Add primary key constraints,
foreign key constraints and integrity constraints to your table definitions. Do
not forget to correctly set up the new and existing foreign keys. */

CREATE TABLE Customer(
       id INT AUTO_INCREMENT,
       city INT,
       name varchar(255),
       street_adress varchar(255),
       PRIMARY KEY(id),
       FOREIGN KEY(city) REFERENCES jbcity(id)
);
/*
Query OK, 0 rows affected (0.08 sec)
*/

CREATE TABLE Account(
       account_number INT AUTO_INCREMENT,
       balance DOUBLE DEFAULT 0,
       customer_id INT,
       PRIMARY KEY(account_number),
       FOREIGN KEY(customer_id) REFERENCES Customer(id)
);
/*
Query OK, 0 rows affected (0.07 sec)
*/

CREATE TABLE Transaction(
       transaction_number INT,
       employee_id INT,
       account_number INT,
       sdate DATE,
       transaction_type VARCHAR(255),
       amount DOUBLE,
       PRIMARY KEY(transaction_number),
       FOREIGN KEY(employee_id) REFERENCES jbemployee(id),
       FOREIGN KEY(account_number) REFERENCES Account(account_number)
);
/*
Query OK, 0 rows affected (0.07 sec)
*/

DELETE FROM jbsale;
/* Query OK, 8 rows affected (0.01 sec) */
ALTER TABLE jbsale DROP FOREIGN KEY fk_sale_debit;
/*
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/
ALTER TABLE jbsale ADD CONSTRAINT fk_sale_debit FOREIGN KEY (debit) REFERENCES Transaction(transaction_number);
/*
Query OK, 0 rows affected (0.16 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/
