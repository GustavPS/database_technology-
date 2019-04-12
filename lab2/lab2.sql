/*
Lab 1 report    Filip, filer358
                Gustav, gussv375
                Jimmy, jimbj685
                
All non code should be within SQL-comments /* like this */ 

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
SET FOREIGN_KEY_CHECKS=1;
/*
3: Implement your extensions in the database by first creating tables, if any, then
populating them with existing manager data, then adding/modifying foreign key
constraints. Do you have to initialize the bonus attribute to a value? Why?

No, we do not have to initialize jbmanager's bonus attribute to a value but we choose to make it default 0 since we want as few NULL values as possible.
*/


CREATE TABLE jbmanager(
       id INT,	     
       bonus INT DEFAULT 0,
       PRIMARY KEY (id)
);

INSERT INTO jbmanager(id)
SELECT DISTINCT manager FROM jbdept;

INSERT INTO jbmanager(id)
SELECT DISTINCT manager FROM jbemployee
WHERE manager IS NOT NULL AND manager NOT IN (SELECT id FROM jbmanager);

ALTER TABLE jbdept DROP FOREIGN KEY fk_dept_mgr;
ALTER TABLE jbemployee DROP FOREIGN KEY fk_emp_mgr;

ALTER TABLE jbdept
ADD CONSTRAINT `fk_dept_mgr` 
FOREIGN KEY (`manager`) REFERENCES `jbmanager`(`id`);

ALTER TABLE jbemployee
ADD CONSTRAINT `fk_emp_mgr`
FOREIGN KEY (manager) REFERENCES jbmanager(id);


/*
4: All departments showed good sales figures last year! Give all current department
managers $10,000 in bonus. This bonus is an addition to other possible bonuses
they have.
Hint: Not all managers are department managers. Update all managers that are
referred in the jbdept relation.
*/
UPDATE jbmanager SET bonus = 10000
WHERE id IN (SELECT DISTINCT manager FROM jbdept);

/*
5B: Implement your extensions in your database. Add primary key constraints,
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

CREATE TABLE Account(
       account_number INT AUTO_INCREMENT,
       balance DOUBLE DEFAULT 0,
       customer_id INT,
       PRIMARY KEY(account_number),
       FOREIGN KEY(customer_id) REFERENCES Customer(id)
);

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

DELETE FROM jbsale;
ALTER TABLE jbsale DROP FOREIGN KEY fk_sale_debit;
ALTER TABLE jbsale ADD CONSTRAINT fk_sale_debit FOREIGN KEY (debit) REFERENCES Transaction(transaction_number);
