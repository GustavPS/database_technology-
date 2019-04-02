/*
Lab 1 report    Filip, filer358
                Gustaf, gussv375
                Jimmy, jimbj685
                
All non code should be within SQL-comments /* like this */ 


/*
Drop all user created tables that have been created when solving the lab
*/

DROP TABLE IF EXISTS custom_table CASCADE;

/* Have the source scripts in the file so it is easy to recreate!*/

SOURCE company_schema.sql;
SOURCE company_data.sql;

/*
Question 0: Print a message that says "hello world"
*/

SELECT 'hello world!' AS 'message';

/* Show the output for every question.
+--------------+
| message      |
+--------------+
| hello world! |
+--------------+
1 row in set (0.00 sec)
*/ 

/*
Question 1: List all employees, i.e. all tuples in the jbemployee relation
*/
SELECT * FROM jbemployee;
/*
+------+--------------------+--------+---------+-----------+-----------+
| id   | name               | salary | manager | birthyear | startyear |
+------+--------------------+--------+---------+-----------+-----------+
|   10 | Ross, Stanley      |  15908 |     199 |      1927 |      1945 |
|   11 | Ross, Stuart       |  12067 |    NULL |      1931 |      1932 |
|   13 | Edwards, Peter     |   9000 |     199 |      1928 |      1958 |
|   26 | Thompson, Bob      |  13000 |     199 |      1930 |      1970 |
|   32 | Smythe, Carol      |   9050 |     199 |      1929 |      1967 |
|   33 | Hayes, Evelyn      |  10100 |     199 |      1931 |      1963 |
|   35 | Evans, Michael     |   5000 |      32 |      1952 |      1974 |
|   37 | Raveen, Lemont     |  11985 |      26 |      1950 |      1974 |
|   55 | James, Mary        |  12000 |     199 |      1920 |      1969 |
|   98 | Williams, Judy     |   9000 |     199 |      1935 |      1969 |
|  129 | Thomas, Tom        |  10000 |     199 |      1941 |      1962 |
|  157 | Jones, Tim         |  12000 |     199 |      1940 |      1960 |
|  199 | Bullock, J.D.      |  27000 |    NULL |      1920 |      1920 |
|  215 | Collins, Joanne    |   7000 |      10 |      1950 |      1971 |
|  430 | Brunet, Paul C.    |  17674 |     129 |      1938 |      1959 |
|  843 | Schmidt, Herman    |  11204 |      26 |      1936 |      1956 |
|  994 | Iwano, Masahiro    |  15641 |     129 |      1944 |      1970 |
| 1110 | Smith, Paul        |   6000 |      33 |      1952 |      1973 |
| 1330 | Onstad, Richard    |   8779 |      13 |      1952 |      1971 |
| 1523 | Zugnoni, Arthur A. |  19868 |     129 |      1928 |      1949 |
| 1639 | Choy, Wanda        |  11160 |      55 |      1947 |      1970 |
| 2398 | Wallace, Maggie J. |   7880 |      26 |      1940 |      1959 |
| 4901 | Bailey, Chas M.    |   8377 |      32 |      1956 |      1975 |
| 5119 | Bono, Sonny        |  13621 |      55 |      1939 |      1963 |
| 5219 | Schwarz, Jason B.  |  13374 |      33 |      1944 |      1959 |
+------+--------------------+--------+---------+-----------+-----------+
25 rows in set (0.01 sec)
*/

/*
Question 2: List the name of all departments in alphabetical order. Note: by “name” we mean
the name attribute for all tuples in the jbdept relation
*/
SELECT name FROM jbdept ORDER BY name  ASC;
/*
+------------------+
| name             |
+------------------+
| Bargain          |
| Book             |
| Candy            |
| Children's       |
| Children's       |
| Furniture        |
| Giftwrap         |
| Jewelry          |
| Junior Miss      |
| Junior's         |
| Linens           |
| Major Appliances |
| Men's            |
| Sportswear       |
| Stationary       |
| Toys             |
| Women's          |
| Women's          |
| Women's          |
+------------------+
19 rows in set (0.01 sec)
*/

/*
Question 3: What parts are not in store, i.e. qoh = 0? (qoh = Quantity On Hand)
*/
SELECT * FROM jbparts WHERE qoh=0;
/*
+----+-------------------+-------+--------+------+
| id | name              | color | weight | qoh  |
+----+-------------------+-------+--------+------+
| 11 | card reader       | gray  |    327 |    0 |
| 12 | card punch        | gray  |    427 |    0 |
| 13 | paper tape reader | black |    107 |    0 |
| 14 | paper tape punch  | black |    147 |    0 |
+----+-------------------+-------+--------+------+
4 rows in set (0.01 sec)
*/

/*
Question 4: Which employees have a salary between 9000 (included) and 10000 (included)?
*/
SELECT * FROM jbemployee WHERE salary BETWEEN 9000 AND 10000;
/*
+-----+----------------+--------+---------+-----------+-----------+
| id  | name           | salary | manager | birthyear | startyear |
+-----+----------------+--------+---------+-----------+-----------+
|  13 | Edwards, Peter |   9000 |     199 |      1928 |      1958 |
|  32 | Smythe, Carol  |   9050 |     199 |      1929 |      1967 |
|  98 | Williams, Judy |   9000 |     199 |      1935 |      1969 |
| 129 | Thomas, Tom    |  10000 |     199 |      1941 |      1962 |
+-----+----------------+--------+---------+-----------+-----------+
4 rows in set (0.00 sec)
*/

/*
Question 5: What was the age of each employee when they started working (startyear)?
*/
SELECT name, startyear - birthyear AS age FROM jbemployee;
/*
+--------------------+------+
| name               | age  |
+--------------------+------+
| Ross, Stanley      |   18 |
| Ross, Stuart       |    1 |
| Edwards, Peter     |   30 |
| Thompson, Bob      |   40 |
| Smythe, Carol      |   38 |
| Hayes, Evelyn      |   32 |
| Evans, Michael     |   22 |
| Raveen, Lemont     |   24 |
| James, Mary        |   49 |
| Williams, Judy     |   34 |
| Thomas, Tom        |   21 |
| Jones, Tim         |   20 |
| Bullock, J.D.      |    0 |
| Collins, Joanne    |   21 |
| Brunet, Paul C.    |   21 |
| Schmidt, Herman    |   20 |
| Iwano, Masahiro    |   26 |
| Smith, Paul        |   21 |
| Onstad, Richard    |   19 |
| Zugnoni, Arthur A. |   21 |
| Choy, Wanda        |   23 |
| Wallace, Maggie J. |   19 |
| Bailey, Chas M.    |   19 |
| Bono, Sonny        |   24 |
| Schwarz, Jason B.  |   15 |
+--------------------+------+
25 rows in set (0.00 sec)
*/

/*
Question 6: Which employees have a last name ending with “son”?
*/
SELECT * FROM jbemployee WHERE name LIKE '%son,%';
/*
+----+---------------+--------+---------+-----------+-----------+
| id | name          | salary | manager | birthyear | startyear |
+----+---------------+--------+---------+-----------+-----------+
| 26 | Thompson, Bob |  13000 |     199 |      1930 |      1970 |
+----+---------------+--------+---------+-----------+-----------+
1 row in set (0.01 sec)
*/

/*
Question 7: Which items (note items, not parts) have been delivered by a supplier called
Fisher-Price? Formulate this query using a subquery in the where-clause
*/
SELECT * FROM jbitem WHERE supplier = (SELECT id FROM jbsupplier WHERE name='Fisher-Price');
/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
+-----+-----------------+------+-------+------+----------+
3 rows in set (0.01 sec)
*/

/*
Question 8: Formulate the same query as above, but without a subquery.
*/
SELECT jbitem.* FROM jbitem INNER JOIN jbsupplier ON jbsupplier.name='Fisher-Price' AND jbitem.supplier=jbsupplier.id;
/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
+-----+-----------------+------+-------+------+----------+
3 rows in set (0.00 sec)
*/

/*
Question 9: Show all cities that have suppliers located in them. Formulate this query using a
subquery in the where-clause.
*/
SELECT * FROM jbcity WHERE id IN (SELECT city FROM jbsupplier);
/*
+-----+----------------+-------+
| id  | name           | state |
+-----+----------------+-------+
|  10 | Amherst        | Mass  |
|  21 | Boston         | Mass  |
| 100 | New York       | NY    |
| 106 | White Plains   | Neb   |
| 118 | Hickville      | Okla  |
| 303 | Atlanta        | Ga    |
| 537 | Madison        | Wisc  |
| 609 | Paxton         | Ill   |
| 752 | Dallas         | Tex   |
| 802 | Denver         | Colo  |
| 841 | Salt Lake City | Utah  |
| 900 | Los Angeles    | Calif |
| 921 | San Diego      | Calif |
| 941 | San Francisco  | Calif |
| 981 | Seattle        | Wash  |
+-----+----------------+-------+
15 rows in set (0.00 sec)
*/

/*
Question 10: What is the name and color of the parts that are heavier than a card reader?
Formulate this query using a subquery in the where-clause. (The SQL query must
not contain the weight as a constant.)
*/
SELECT name, color FROM jbparts WHERE weight > (SELECT weight FROM jbparts WHERE name = 'card reader');
/*
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.00 sec)
*/

/*
Question 11: Formulate the same query as above, but without a subquery. (The query must not
contain the weight as a constant.)
*/
SELECT A.name, A.color FROM jbparts A, jbparts B WHERE A.weight > B.weight AND B.name = 'card reader';
/*
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.01 sec)
*/

/*
Question 12: What is the average weight of black parts?
*/
SELECT AVG(weight) AS 'Average Weight' FROM jbparts WHERE color='black';
/*
+----------------+
| Average Weight |
+----------------+
|       347.2500 |
+----------------+
1 row in set (0.01 sec)
*/

/*
Question 13: What is the total weight of all parts that each supplier in Massachusetts (“Mass”)
has delivered? Retrieve the name and the total weight for each of these suppliers.
Do not forget to take the quantity of delivered parts into account. Note that one
row should be returned for each supplier.
*/
SELECT supplier.name, SUM(supply.quan * jbparts.weight) AS 'Total weight' FROM  jbparts
INNER JOIN jbsupply AS supply ON jbparts.id = supply.part
INNER JOIN jbsupplier AS supplier ON supply.supplier = supplier.id
INNER JOIN jbcity ON supplier.city = jbcity.id AND jbcity.state = 'Mass'
GROUP BY supplier.name;
/*
+--------------+--------------+
| name         | Total weight |
+--------------+--------------+
| DEC          |         3120 |
| Fisher-Price |      1135000 |
+--------------+--------------+
2 rows in set (0.01 sec)
*/

/*
Question 14: Create a new relation (a table), with the same attributes as the table items using
the CREATE TABLE syntax where you define every attribute explicitly (i.e. not 
as a copy of another table). Then fill the table with all items that cost less than the
average price for items. Remember to define primary and foreign keys in your
table!*/

CREATE TABLE jbitemNew (
       id int(11) NOT NULL,
       name varchar(20) DEFAULT NULL,
       dept int(11) NOT NULL,
       price int(11) DEFAULT NULL,
       qoh int(10) unsigned DEFAULT NULL,
       supplier int(11) NOT NULL,
       PRIMARY KEY(id),
       CONSTRAINT fk_itemNew_dept FOREIGN KEY (dept) REFERENCES jbdept (id),
       CONSTRAINT fk_itemNew_supplier FOREIGN KEY (supplier) REFERENCES jbsupplier (id)
);
INSERT INTO jbitemNew (SELECT * FROM jbitem WHERE price < (SELECT AVG(price) FROM jbitem));
/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  26 | Earrings        |   14 |  1000 |   20 |      199 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
14 rows in set (0.00 sec)
*/

/*
Question 15: Create a view that contains the items that cost less than the average price for
items
*/
CREATE VIEW jbitemView AS (SELECT * FROM jbitem WHERE price < (SELECT AVG(price) FROM jbitem));
/*
mysql> SELECT * FROM jbitemView;
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  26 | Earrings        |   14 |  1000 |   20 |      199 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
14 rows in set (0.00 sec)
*/

/*
Question 16: What is the difference between a table and a view? One is static and the other is
dynamic. Which is which and what do we mean by static respectively dynamic?

A view is dynamic since the view is not manually updated, it reflects the current state of the 
origin that it is based on. A table is static since for it to be updated you have to manually
update it/insert rows to it/delete rows from it.

You cannot run INSERT/UPDATE/REMOVE commands on a view.
*/

/*
Question 17: Create a view, using only the implicit join notation, i.e. only use where statements
but no inner join, right join or left join statements, that calculates the total cost of
each debit, by considering price and quantity of each bought item. (To be used for
charging customer accounts). The view should contain the sale identifier (debit)
and total cost
*/
CREATE VIEW view_17 AS
SELECT debit, SUM(price * quantity) AS total_cost FROM jbsale, jbitem WHERE item = id GROUP BY debit;
/*
+--------+------------+
| debit  | total_cost |
+--------+------------+
| 100581 |       2050 |
| 100582 |       1000 |
| 100586 |      13446 |
| 100592 |        650 |
| 100593 |        430 |
| 100594 |       3295 |
+--------+------------+
6 rows in set (0.00 sec)
*/

/*
Question 18: Do the same as in (17), using only the explicit join notation, i.e. using only left,
right or inner joins but no where statement. Motivate why you use the join you do
(left, right or inner), and why this is the correct one (unlike the others).
*/
CREATE VIEW view_18 AS
SELECT debit, SUM(price * quantity) AS total_cost FROM jbsale LEFT JOIN jbitem ON jbsale.item = jbitem.id GROUP BY debit;
/*
+--------+------------+
| debit  | total_cost |
+--------+------------+
| 100581 |       2050 |
| 100582 |       1000 |
| 100586 |      13446 |
| 100592 |        650 |
| 100593 |        430 |
| 100594 |       3295 |
+--------+------------+
6 rows in set (0.00 sec)
*/

/*
Question 19: Oh no! An earthquake!
a) Remove all suppliers in Los Angeles from the table jbsupplier. This will not
work right away (you will receive error code 23000) which you will have to
solve by deleting some other related tuples. However, do not delete more
tuples from other tables than necessary and do not change the structure of the
tables, i.e. do not remove foreign keys. Also, remember that you are only
allowed to use “Los Angeles” as a constant in your queries, not “199” or
“900”.
*/
START TRANSACTION;
DELETE FROM jbsale WHERE item IN (SELECT id FROM jbitem WHERE supplier IN (SELECT id FROM jbsupplier WHERE city IN (SELECT id FROM jbcity WHERE name = "Los Angeles")));

DELETE FROM jbsupply WHERE supplier IN (SELECT id FROM jbsupplier WHERE city = (SELECT id FROM jbcity WHERE name = "Los Angeles"));

DELETE FROM jbitem WHERE supplier IN (SELECT id FROM jbsupplier WHERE city = (SELECT id FROM jbcity WHERE name = "Los Angeles"));

DELETE FROM jbsupplier WHERE city IN (SELECT id FROM jbcity WHERE name = "Los Angeles");
COMMIT;
/*b) Explain what you did and why.
We located all the dependencies for the supplier table (jbitem, jbsale, jbsupply)
We then start to remove from the deepest dependency, so we delete jbsale first, then jbsupply,
then jbitem and last jbsupplier.

We do this in a TRANSACTION because if a system failure occurs between any of these delete commands
the system will be in an undefined state. Using transaction prevents this.

*/
