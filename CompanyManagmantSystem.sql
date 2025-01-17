# Create the company database
CREATE DATABASE CompanyManagmantSystem;

# Create the database tables
USE CompanyManagmantSystem;

# Create 'DEPARTMENT' table
CREATE TABLE DEPARTMENT (
  dname        varchar(25) not null,
  dnumber      int not null,
  mgrssn       char(9) not null,
  mgrstartdate date,
  CONSTRAINT pk_Department primary key (dnumber),
  CONSTRAINT uk_dname UNIQUE (dname)
);

# Create 'EMPLOYEE' table
CREATE TABLE EMPLOYEE (
  fname    varchar(15) not null,
  minit    varchar(1),
  lname    varchar(15) not null,
  ssn      char(9),
  bdate    date,
  address  varchar(50),
  sex      char,
  salary   decimal(10,2),
  superssn char(9),
  dno      int,
  CONSTRAINT pk_employee primary key (ssn),
  CONSTRAINT fk_employee_department foreign key (dno) references DEPARTMENT(dnumber)
  # CONSTRAINT fk_employee_employee foreign key (superssn) references EMPLOYEE(ssn)
  # Adding FK constraint later to prevent cyclic referential integrity violation
);

# Create 'DEPENDENT' table
CREATE TABLE DEPENDENT (
  essn           char(9),
  dependent_name varchar(15),
  sex            char,
  bdate          date,
  relationship   varchar(8),
  CONSTRAINT pk_dependent primary key (essn,dependent_name),
  CONSTRAINT fk_dependent_employee foreign key (essn) references EMPLOYEE(ssn)
);

# Create 'DEPT_LOCATIONS' table
CREATE TABLE DEPT_LOCATIONS (
  dnumber   int,
  dlocation varchar(15),
  CONSTRAINT pk_deptlocations primary key (dnumber,dlocation),
  CONSTRAINT fk_deptlocations_department foreign key (dnumber) references DEPARTMENT(dnumber)
);

# Create 'PROJECT' table
CREATE TABLE PROJECT (
  pname      varchar(25) not null,
  pnumber    int,
  plocation  varchar(15),
  dnum       int not null,
  CONSTRAINT pk_project primary key (pnumber),
  CONSTRAINT uk_pname unique (pname),
  CONSTRAINT fk_project_department foreign key (dnum) references DEPARTMENT(dnumber)
);

# Create 'WORKS_ON' table
CREATE TABLE WORKS_ON (
  essn   char(9),
  pno    int,
  hours  decimal(4,1),
  CONSTRAINT pk_workson primary key (essn,pno),
  CONSTRAINT fk_workson_employee foreign key (essn) references EMPLOYEE(ssn),
  CONSTRAINT fk_workson_project foreign key (pno) references PROJECT(pnumber)
);

CREATE TABLE EMPLOYEE_AUDIT (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    ssn CHAR(9),
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

# Insert all records into the tables
# DEPARTMENT table records
USE CompanyManagmantSystem;
INSERT INTO DEPARTMENT VALUES ('Research','5','333445555','1978-05-22');
INSERT INTO DEPARTMENT VALUES ('Administration','4','987654321','1985-01-01');
INSERT INTO DEPARTMENT VALUES ('Headquarters','1','888665555','1971-06-19');
INSERT INTO DEPARTMENT VALUES ('Software','6','111111100','1999-05-15');
INSERT INTO DEPARTMENT VALUES ('Hardware','7','444444400','1998-05-15');
INSERT INTO DEPARTMENT VALUES ('Sales','8','555555500','1997-01-01');

# EMPLOYEE table records
USE CompanyManagmantSystem;
INSERT INTO EMPLOYEE VALUES ('Bob','B','Bender','666666600','1968-04-17','8794 Garfield, Chicago, IL','M','96000.00',NULL,'8' );
INSERT INTO EMPLOYEE VALUES ('Kim','C','Grace','333333300','1970-10-23','6677 Mills Ave, Sacramento, CA','F','79000.00',NULL,'6');
INSERT INTO EMPLOYEE VALUES ('James','E','Borg','888665555','1927-11-10','450 Stone, Houston, TX','M','55000.00',NULL,'1');
INSERT INTO EMPLOYEE VALUES ('Alex','D','Freed','444444400','1950-10-09','4333 Pillsbury, Milwaukee, WI','M','89000.00',NULL,'7');
INSERT INTO EMPLOYEE VALUES ('Evan','E','Wallis','222222200','1958-01-16','134 Pelham, Milwaukee, WI','M','92000.00',NULL,'7');
INSERT INTO EMPLOYEE VALUES ('Jared','D','James','111111100','1966-10-10','123 Peachtree, Atlanta, GA','M','85000.00',NULL,'6');
INSERT INTO EMPLOYEE VALUES ('John','C','James','555555500','1975-06-30','7676 Bloomington, Sacramento, CA','M','81000.00',NULL,'6');
INSERT INTO EMPLOYEE VALUES ('Andy','C','Vile','222222202','1944-06-21','1967 Jordan, Milwaukee, WI','M','53000.00','222222200','7');
INSERT INTO EMPLOYEE VALUES ('Brad','C','Knight','111111103','1968-02-13','176 Main St., Atlanta, GA','M','44000.00','111111100','6');
INSERT INTO EMPLOYEE VALUES ('Josh','U','Zell','222222201','1954-05-22','266 McGrady, Milwaukee, WI','M','56000.00','222222200','7');
INSERT INTO EMPLOYEE VALUES ('Justin','n','Mark','111111102','1966-01-12','2342 May, Atlanta, GA','M','40000.00','111111100','6');
INSERT INTO EMPLOYEE VALUES ('Jon','C','Jones','111111101','1967-11-14','111 Allgood, Atlanta, GA','M','45000.00','111111100','6');
INSERT INTO EMPLOYEE VALUES ('Ahmad','V','Jabbar','987987987','1959-03-29','980 Dallas, Houston, TX','M','25000.00','987654321','4');
INSERT INTO EMPLOYEE VALUES ('Joyce','A','English','453453453','1962-07-31','5631 Rice, Houston, TX','F','25000.00','333445555','5');
INSERT INTO EMPLOYEE VALUES ('Ramesh','K','Narayan','666884444','1952-09-15','971 Fire Oak, Humble, TX','M','38000.00','333445555','5');
INSERT INTO EMPLOYEE VALUES ('Alicia','J','Zelaya','999887777','1958-07-19','3321 Castle, Spring, TX','F','25000.00','987654321','4');
INSERT INTO EMPLOYEE VALUES ('John','B','Smith','123456789','1955-01-09','731 Fondren, Houston, TX','M','30000.00','333445555','5');
INSERT INTO EMPLOYEE VALUES ('Jennifer','S','Wallace','987654321','1931-06-20','291 Berry, Bellaire, TX','F','43000.00','888665555','4');
INSERT INTO EMPLOYEE VALUES ('Franklin','T','Wong','333445555','1945-12-08','638 Voss, Houston, TX','M','40000.00','888665555','5');
INSERT INTO EMPLOYEE VALUES ('Tom','G','Brand','222222203','1966-12-16','112 Third St, Milwaukee, WI','M','62500.00','222222200','7');
INSERT INTO EMPLOYEE VALUES ('Jenny','F','Vos','222222204','1967-11-11','263 Mayberry, Milwaukee, WI','F','61000.00','222222201','7');
INSERT INTO EMPLOYEE VALUES ('Chris','A','Carter','222222205','1960-03-21','565 Jordan, Milwaukee, WI','F','43000.00','222222201','7');
INSERT INTO EMPLOYEE VALUES ('Jeff','H','Chase','333333301','1970-01-07','145 Bradbury, Sacramento, CA','M','44000.00','333333300','6');
INSERT INTO EMPLOYEE VALUES ('Bonnie','S','Bays','444444401','1956-06-19','111 Hollow, Milwaukee, WI','F','70000.00','444444400','7');
INSERT INTO EMPLOYEE VALUES ('Alec','C','Best','444444402','1966-06-18','233 Solid, Milwaukee, WI','M','60000.00','444444400','7');
INSERT INTO EMPLOYEE VALUES ('Sam','S','Snedden','444444403','1977-07-31','987 Windy St, Milwaukee, WI','M','48000.00','444444400','7');
INSERT INTO EMPLOYEE VALUES ('Nandita','K','Ball','555555501','1969-04-16','222 Howard, Sacramento, CA','M','62000.00','555555500','6');
INSERT INTO EMPLOYEE VALUES ('Jill','J','Jarvis','666666601','1966-01-14','6234 Lincoln, Chicago, IL','F','36000.00','666666600','8');
INSERT INTO EMPLOYEE VALUES ('Kate','W','King','666666602','1966-04-16','1976 Boone Trace, Chicago, IL','F','44000.00','666666600','8');
INSERT INTO EMPLOYEE VALUES ('Lyle','G','Leslie','666666603','1963-06-09','417 Hancock Ave, Chicago, IL','M','41000.00','666666601','8');
INSERT INTO EMPLOYEE VALUES ('Billie','J','King','666666604','1960-01-01','556 Washington, Chicago, IL','F','38000.00','666666603','8');
INSERT INTO EMPLOYEE VALUES ('Jon','A','Kramer','666666605','1964-08-22','1988 Windy Creek, Seattle, WA','M','41500.00','666666603','8');
INSERT INTO EMPLOYEE VALUES ('Ray','H','King','666666606','1949-08-16','213 Delk Road, Seattle, WA','M','44500.00','666666604','8');
INSERT INTO EMPLOYEE VALUES ('Gerald','D','Small','666666607','1962-05-15','122 Ball Street, Dallas, TX','M','29000.00','666666602','8');
INSERT INTO EMPLOYEE VALUES ('Arnold','A','Head','666666608','1967-05-19','233 Spring St, Dallas, TX','M','33000.00','666666602','8');
INSERT INTO EMPLOYEE VALUES ('Helga','C','Pataki','666666609','1969-03-11','101 Holyoke St, Dallas, TX','F','32000.00','666666602','8');
INSERT INTO EMPLOYEE VALUES ('Naveen','B','Drew','666666610','1970-05-23','198 Elm St, Philadelphia, PA','M','34000.00','666666607','8');
INSERT INTO EMPLOYEE VALUES ('Carl','E','Reedy','666666611','1977-06-21','213 Ball St, Philadelphia, PA','M','32000.00','666666610','8');
INSERT INTO EMPLOYEE VALUES ('Sammy','G','Hall','666666612','1970-01-11','433 Main Street, Miami, FL','M','37000.00','666666611','8');
INSERT INTO EMPLOYEE VALUES ('Red','A','Bacher','666666613','1980-05-21','196 Elm Street, Miami, FL','M','33500.00','666666612','8');

# DEPENDANT table records
USE CompanyManagmantSystem;
INSERT INTO DEPENDENT VALUES ('333445555','Alice','F','1976-04-05','Daughter');
INSERT INTO DEPENDENT VALUES ('333445555','Theodore','M','1973-10-25','Son');
INSERT INTO DEPENDENT VALUES ('333445555','Joy','F','1948-05-03','Spouse');
INSERT INTO DEPENDENT VALUES ('987654321','Abner','M','1932-02-29','Spouse');
INSERT INTO DEPENDENT VALUES ('123456789','Michael','M','1978-01-01','Son');
INSERT INTO DEPENDENT VALUES ('123456789','Alice','F','1978-12-31','Daughter');
INSERT INTO DEPENDENT VALUES ('123456789','Elizabeth','F',Null,'Spouse');
INSERT INTO DEPENDENT VALUES ('444444400','Johnny','M','1997-04-04','Son');
INSERT INTO DEPENDENT VALUES ('444444400','Tommy','M','1999-06-07','Son');
INSERT INTO DEPENDENT VALUES ('444444401','Chris','M','1969-04-19','Spouse');
INSERT INTO DEPENDENT VALUES ('444444402','Sam','M','1964-02-14','Spouse');  

# DEPT_LOCATIONS table records
USE CompanyManagmantSystem;
INSERT INTO DEPT_LOCATIONS VALUES ('1','Houston');
INSERT INTO DEPT_LOCATIONS VALUES ('4','Stafford');
INSERT INTO DEPT_LOCATIONS VALUES ('5','Bellaire');
INSERT INTO DEPT_LOCATIONS VALUES ('5','Houston');
INSERT INTO DEPT_LOCATIONS VALUES ('5','Sugarland');
INSERT INTO DEPT_LOCATIONS VALUES ('6','Atlanta');
INSERT INTO DEPT_LOCATIONS VALUES ('6','Sacramento');
INSERT INTO DEPT_LOCATIONS VALUES ('7','Milwaukee');
INSERT INTO DEPT_LOCATIONS VALUES ('8','Chicago');
INSERT INTO DEPT_LOCATIONS VALUES ('8','Dallas');
INSERT INTO DEPT_LOCATIONS VALUES ('8','Miami');
INSERT INTO DEPT_LOCATIONS VALUES ('8','Philadephia');
INSERT INTO DEPT_LOCATIONS VALUES ('8','Seattle');

# PROJECT table records
USE CompanyManagmantSystem;
INSERT INTO PROJECT VALUES ('ProductX','1','Bellaire','5');
INSERT INTO PROJECT VALUES ('ProductY','2','Sugarland','5');
INSERT INTO PROJECT VALUES ('ProductZ','3','Houston','5');
INSERT INTO PROJECT VALUES ('Computerization','10','Stafford','4');
INSERT INTO PROJECT VALUES ('Reorganization','20','Houston','1');
INSERT INTO PROJECT VALUES ('Newbenefits','30','Stafford','4');
INSERT INTO PROJECT VALUES ('OperatingSystems','61','Jacksonville','6');
INSERT INTO PROJECT VALUES ('DatabaseSystems','62','Birmingham','6');
INSERT INTO PROJECT VALUES ('Middleware','63','Jackson','6');
INSERT INTO PROJECT VALUES ('InkjetPrinters','91','Phoenix','7');
INSERT INTO PROJECT VALUES ('LaserPrinters','92','LasVegas','7');

# WORKS_ON table records
USE CompanyManagmantSystem;
INSERT INTO WORKS_ON VALUES ('123456789','1','32.5');
INSERT INTO WORKS_ON VALUES ('123456789','2','7.5');
INSERT INTO WORKS_ON VALUES ('666884444','3','40.0');
INSERT INTO WORKS_ON VALUES ('453453453','1','20.0');
INSERT INTO WORKS_ON VALUES ('453453453','2','20.0');
INSERT INTO WORKS_ON VALUES ('333445555','2','10.0');
INSERT INTO WORKS_ON VALUES ('333445555','3','10.0');
INSERT INTO WORKS_ON VALUES ('333445555','10','10.0');
INSERT INTO WORKS_ON VALUES ('333445555','20','10.0');
INSERT INTO WORKS_ON VALUES ('999887777','30','30.0');
INSERT INTO WORKS_ON VALUES ('999887777','10','10.0');
INSERT INTO WORKS_ON VALUES ('987987987','10','35.0');
INSERT INTO WORKS_ON VALUES ('987987987','30','5.0');
INSERT INTO WORKS_ON VALUES ('987654321','30','20.0');
INSERT INTO WORKS_ON VALUES ('987654321','20','15.0');
INSERT INTO WORKS_ON VALUES ('888665555','20','0.0');
INSERT INTO WORKS_ON VALUES ('111111100','61','40.0');
INSERT INTO WORKS_ON VALUES ('111111101','61','40.0');
INSERT INTO WORKS_ON VALUES ('111111102','61','40.0');
INSERT INTO WORKS_ON VALUES ('111111103','61','40.0');
INSERT INTO WORKS_ON VALUES ('222222200','62','40.0');
INSERT INTO WORKS_ON VALUES ('222222201','62','48.0');
INSERT INTO WORKS_ON VALUES ('222222202','62','40.0');
INSERT INTO WORKS_ON VALUES ('222222203','62','40.0');
INSERT INTO WORKS_ON VALUES ('222222204','62','40.0');
INSERT INTO WORKS_ON VALUES ('222222205','62','40.0');
INSERT INTO WORKS_ON VALUES ('333333300','63','40.0');
INSERT INTO WORKS_ON VALUES ('333333301','63','46.0');
INSERT INTO WORKS_ON VALUES ('444444400','91','40.0');
INSERT INTO WORKS_ON VALUES ('444444401','91','40.0');
INSERT INTO WORKS_ON VALUES ('444444402','91','40.0');
INSERT INTO WORKS_ON VALUES ('444444403','91','40.0');
INSERT INTO WORKS_ON VALUES ('555555500','92','40.0');
INSERT INTO WORKS_ON VALUES ('555555501','92','44.0');
INSERT INTO WORKS_ON VALUES ('666666601','91','40.0');
INSERT INTO WORKS_ON VALUES ('666666603','91','40.0');
INSERT INTO WORKS_ON VALUES ('666666604','91','40.0');
INSERT INTO WORKS_ON VALUES ('666666605','92','40.0');
INSERT INTO WORKS_ON VALUES ('666666606','91','40.0');
INSERT INTO WORKS_ON VALUES ('666666607','61','40.0');
INSERT INTO WORKS_ON VALUES ('666666608','62','40.0');
INSERT INTO WORKS_ON VALUES ('666666609','63','40.0');
INSERT INTO WORKS_ON VALUES ('666666610','61','40.0');
INSERT INTO WORKS_ON VALUES ('666666611','61','40.0');
INSERT INTO WORKS_ON VALUES ('666666612','61','40.0');
INSERT INTO WORKS_ON VALUES ('666666613','61','30.0');
INSERT INTO WORKS_ON VALUES ('666666613','62','10.0');
INSERT INTO WORKS_ON VALUES ('666666613','63','10.0');

# Adding FK constraint after loading data into system
Alter table EMPLOYEE
ADD CONSTRAINT fk_employee_employee foreign key (superssn) references EMPLOYEE(ssn);

# RETRIEVE tables by SELECT query to validate all the tables were created properly
SELECT * FROM CompanyManagmantSystem.DEPARTMENT;
SELECT * FROM CompanyManagmantSystem.DEPENDENT;
SELECT * FROM CompanyManagmantSystem.DEPT_LOCATIONS;
SELECT * FROM CompanyManagmantSystem.EMPLOYEE;
SELECT * FROM CompanyManagmantSystem.PROJECT;
SELECT * FROM CompanyManagmantSystem.WORKS_ON;

# query to find employees who are managers.
USE CompanyManagmantSystem;
SELECT *
FROM EMPLOYEE
WHERE EXISTS (SELECT * FROM DEPARTMENT
              WHERE ssn = mgrssn);
              
# query to find the highest salary of the employees in each department. Return department name and the maximum salary.
USE CompanyManagmantSystem;
SELECT dname, MAX(salary)
FROM DEPARTMENT, EMPLOYEE
WHERE dnumber = dno
GROUP BY dname;

# query to find employees who earn more than the maximum salary for a department of number 6.
USE CompanyManagmantSystem;
SELECT fname, lname, dno
FROM EMPLOYEE
WHERE salary > ALL (SELECT salary
                    FROM EMPLOYEE
                    WHERE dno = 6);
                    
# query to find employees who earn more than the average salary.
# Display employee ssn, first name and last name.
USE CompanyManagmantSystem;
SELECT ssn, fname, lname
FROM EMPLOYEE
WHERE salary > (SELECT AVG(salary)
				FROM EMPLOYEE);           
                
# query to find employees whose ssn matches any of the numbers 222222200, 333333300 and 444444402.
USE CompanyManagmantSystem;
SELECT *
FROM EMPLOYEE
WHERE ssn IN ('222222200', '333333300', '444444402');

# query to find employees who earn less than the average salary
# and work at the department where Justin (first name) is employed.
# Return first name, last name, salary, and department number.
USE CompanyManagmantSystem;
SELECT fname, lname, salary, dno
FROM EMPLOYEE
WHERE salary < (SELECT AVG(salary) FROM EMPLOYEE)
             AND dno = (SELECT dno FROM EMPLOYEE
                        WHERE fname = 'Justin');            
 

# sub-query finds employees who work on more than one project
USE CompanyManagmantSystem;
SELECT fname, lname, ssn
FROM EMPLOYEE
WHERE ssn IN (
    SELECT essn
    FROM WORKS_ON
    GROUP BY essn
    HAVING COUNT(DISTINCT pno) > 1
);

# query retrieves the department name and the employee names who work in each department
USE CompanyManagmantSystem;
SELECT D.dname, E.fname, E.lname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.dno = D.dnumber;

USE CompanyManagmantSystem;
select distinct EMPLOYEE.fname,DEPARTMENT.dname,DEPARTMENT.mgrstartdate
from EMPLOYEE 
inner join DEPARTMENT 
where
 mgrstartdate like '1978-05-22';
 
USE CompanyManagmantSystem;
select  EMPLOYEE.fname,EMPLOYEE.sex,EMPLOYEE.address,EMPLOYEE.salary
from EMPLOYEE
 where     
salary = (SELECT AVG(salary) FROM EMPLOYEE);

USE CompanyManagmantSystem;
select distinct EMPLOYEE.fname,DEPARTMENT.dname 
from EMPLOYEE 
inner join DEPARTMENT;

USE CompanyManagmantSystem;
update EMPLOYEE SET salary = '100000.00' where ssn = '666666600';
update EMPLOYEE SET salary ='90000.00' where ssn = '222222200';
update EMPLOYEE SET salary = '300000.00' where ssn = '888665555';
update EMPLOYEE SET salary = '200000.00' where ssn = '555555500';
update EMPLOYEE SET salary = '150000.00' where ssn = '987987987';

USE CompanyManagmantSystem;
DELIMITER //
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF NEW.salary <> OLD.salary THEN
        INSERT INTO EMPLOYEE_AUDIT (ssn, old_salary, new_salary)
        VALUES (OLD.ssn, OLD.salary, NEW.salary);
    END IF;
END; //
DELIMITER ;

select * from EMPLOYEE_AUDIT;

USE CompanyManagmantSystem;
# this is a query that update a row to set a date column to the current date and time using CURDATE():
UPDATE EMPLOYEE
SET bdate = CURDATE()
WHERE ssn = '123456789';
SELECT * FROM CompanyManagmantSystem.EMPLOYEE;

USE CompanyManagmantSystem;
/*Imagine sara works at a company with many departments, each identified by a number. 
sara only has the department number but needs the department name.
 To make her life easier, the database has a stored procedure,
 GetDepartmentName, that instantly converts department numbers into names.
 */
DELIMITER //
CREATE PROCEDURE GetDepartmentName(IN depNum INT, OUT depName VARCHAR(25))
BEGIN
    CASE depNum
        WHEN 1 THEN SET depName = 'Research';
        WHEN 2 THEN SET depName = 'Sales';
        WHEN 3 THEN SET depName = 'Administration';
		WHEN 4 THEN SET depName = 'Software';
		WHEN 5 THEN SET depName = 'Headquarters';
        ELSE SET depName = 'Unknown';
    END CASE;
END //
DELIMITER ;

SET @depName = '';
CALL GetDepartmentName(5, @depName);
SELECT @depName AS 'Department Name';


explain SELECT* from EMPLOYEE 
where salary = 40000 ;

CREATE INDEX salary 
On EMPLOYEE (salary)  ;

