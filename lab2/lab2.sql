CREATE TABLE jbmanager(
       id INT,	     
       bonus INT,
       PRIMARY KEY (id),
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
