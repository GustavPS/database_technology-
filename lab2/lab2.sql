/*
3: Implement your extensions in the database by first creating tables, if any, then
populating them with existing manager data, then adding/modifying foreign key
constraints. Do you have to initialize the bonus attribute to a value? Why?
*/
CREATE TABLE jbmanager(
       id INT,	     
       bonus INT,
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
