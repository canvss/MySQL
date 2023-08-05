CREATE DATABASE test;
SHOW DATABASES

CREATE DATABASE IF NOT EXISTS test2 
SHOW DATABASES

SELECT DATABASE() FROM DUAL;

USE demo;
SHOW TABLES;

SHOW CREATE DATABASE demo;

ALTER DATABASE test CHARACTER SET "GBK";
SHOW CREATE DATABASE test;


SHOW DATABASES;
DROP DATABASE test;
DROP DATABASE test2;
SHOW DATABASES;
DROP DATABASE IF NOT EXISTS test2;


CREATE DATABASE IF NOT EXISTS test;
SHOW DATABASES;
USE test;
CREATE TABLE IF NOT EXISTS emps(
	id INT,
	name VARCHAR(15),
	salary DOUBLE(8,2),
	birthday DATE
);
SHOW TABLES;
DESC emps;



CREATE TABLE IF NOT EXISTS user(
	user_id INT(2) AUTO_INCREMENT,
	name VARCHAR(15),
	PRIMARY KEY(user_id)
);
DESC user;


USE demo;
CREATE TABLE IF NOT EXISTS employees_2 AS SELECT employee_id,last_name,salary,department_id FROM employees;
SELECT * FROM employees_2;
DESC employees_2;
#创建employees_3是空表
CREATE TABLE IF NOT EXISTS employees_3 AS SELECT employee_id,last_name,salary,department_id FROM employees WHERE 1=2;

DESC employees_2;
DESCRIBE employees;

USE test;
SHOW TABLES;
SELECT * FROM emps;

ALTER TABLE emps ADD gender CHAR(2);

ALTER TABLE emps MODIFY gender CHAR(1) DEFAULT('男') 
ALTER TABLE emps MODIFY name VARCHAR(10);

ALTER TABLE emps CHANGE sex sex CHAR(1);

ALTER TABLE emps DROP sex;

RENAME TABLE emps TO myemps;
ALTER TABLE myemps RENAME emps;

DESC emps;

DROP TABLE IF NOT EXISTS emps;


USE demo;
TRUNCATE TABLE employees_2;
SELECT * FROM employees_2;
DROP TABLE employees_2;

DROP TABLE employees_3;
CREATE TABLE employees_copy AS SELECT employee_id,last_name,salary FROM employees;
SELECT * FROM employees_copy;
#设置不自动提交
SET autocommit = FALSE;
DELETE FROM employees_copy;
SELECT * FROM employees_copy;
ROLLBACK;
SELECT * FROM employees_copy;