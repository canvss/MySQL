USE test;
SHOW TABLES;
CREATE TABLE test(
	id INT NOT NULL,
	name VARCHAR(15)
);
INSERT INTO test(id,name)VALUES(1,'tom');
DESC test;

ALTER TABLE test MODIFY name VARCHAR(20) NOT NULL;

RENAME TABLE test TO test01;
ALTER TABLE test01 MODIFY id int;

SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE table_name = 'student_course';

CREATE TABLE test02(
	id INT,
	name VARCHAR(20),
	UNIQUE KEY(id)
);
INSERT INTO test02(name) VALUES('tom');
UPDATE test02 SET id = 1001 WHERE name = 'tom';
SELECT * FROM test0;

CREATE TABLE test03(
	id INT UNIQUE KEY,
	name VARCHAR(20)
);

CREATE TABLE test04(
	id INT,
	name VARCHAR(10)
);

ALTER TABLE test04 MODIFY id INT UNIQUE KEY;


CREATE TABLE student(
	sid INT,
	sname VARCHAR(10),
	tel char(11) UNIQUE KEY,
	cardid char(18) UNIQUE KEY
);
CREATE TABLE course(
	sid INT,
	cname VARCHAR(20)
);
CREATE TABLE student_sourse(
	id int,
	sid INT,
	cid INT,
	score INT,
	UNIQUE KEY(sid,cid)	#复合唯一
);

ALTER TABLE student_sourse DROP INDEX sid;
SHOW INDEX FROM student_sourse;
SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp5';

DROP TABLE test01,test02,test03,test04;

CREATE TABLE emp(
	id INT PRIMARY KEY,
	name VARCHAR(20),
	gender CHAR(2)
);
INSERT INTO emp(id,name,gender) VALUES(1001,'canvs','男'),(1002,'lisa','女');
SELECT * FROM emp;

CREATE TABLE emp2(
	id INT AUTO_INCREMENT,
	name VARCHAR(20),
	gender CHAR(2),
	PRIMARY KEY(id)
);
INSERT INTO emp2(name,gender) VALUES('canvs','男'),('lisa','女');
SELECT * FROM emp2;


CREATE TABLE emp3(
	id INT,
	name VARCHAR(20),
	gender CHAR(2)
)
ALTER TABLE emp3 MODIFY id INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE emp3 drop PRIMARY KEY;

DESC emp3;

#学生表
create table student(
sid int primary key, #学号
sname varchar(20) #学生姓名 );
#课程表
create table course(
cid int primary key, #课程编号
cname varchar(20) #课程名称 );
#选课表
create table student_course(
sid int,
cid int,
score int,
primary key(sid,cid) #复合主键
);


CREATE TABLE emp4(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20)
);

CREATE TABLE emp5(
	id INT PRIMARY KEY,
	name VARCHAR(20)
)
ALTER TABLE emp5 MODIFY id INT AUTO_INCREMENT;
ALTER TABLE emp5 MODIFY id INT;

DESC emp5;


CREATE TABLE dept(
	did INT PRIMARY KEY,
	dname VARCHAR(20)
);
CREATE TABLE emp(
	eid INT PRIMARY KEY,
	ename VARCHAR(15),
	dept_id INT,
	FOREIGN KEY(dept_id) REFERENCES dept(did)
);
USE test;
INSERT INTO dept(did,dname)VALUES(10,'IT')；
INSERT INTO dept(did,dname) VALUES(20,'研发部');
INSERT INTO emp(eid,ename,dept_id)VALUES(1001,'canvs',20),(1002,'lisa',10);
# 部门不存在
# INSERT INTO emp(eid,ename,dept_id) VALUES(1003,'tom',30);
SELECT * FROM emp;
SELECT * FROM dept;
DELETE FROM emp WHERE eid = 1001;
DELETE FROM dept WHERE did = 10;

CREATE TABLE dept1(
	did INT PRIMARY KEY,
	dname VARCHAR(20)
);
CREATE TABLE emp1(
	eid INT PRIMARY KEY,
	ename VARCHAR(15),
	dept_id INT
);
ALTER TABLE emp1 ADD FOREIGN KEY(eid) REFERENCES dept(did);


CREATE DATABASE test02 CHARACTER SET "utf8";
USE test02;
CREATE TABLE dept(
	did INT PRIMARY KEY,
	dname VARCHAR(50)
);
CREATE TABLE emp(
	eid INT PRIMARY KEY,
	ename VARCHAR(20),
	dept_id INT,
	FOREIGN KEY(dept_id) REFERENCES dept(did) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO dept VALUES(1001,'教学部'); 
INSERT INTO dept VALUES(1002, '财务部'); 
INSERT INTO dept VALUES(1003, '咨询部');

INSERT INTO emp VALUES(1,'canvs',1001);
INSERT INTO emp VALUES(2,'lisa',1001);
INSERT INTO emp VALUES(3,'jack',1002);

SELECT * FROM emp;

UPDATE dept SET did = 1004 WHERE did = 1002;
DELETE FROM dept WHERE did = 1001;


CREATE DATABASE test03;
USE test03;
CREATE TABLE dept(
	did INT PRIMARY KEY,
	dname VARCHAR(50)
);
CREATE TABLE emp(
	eid INT PRIMARY KEY,
	ename VARCHAR(20),
	dept_id INT,
	FOREIGN KEY(dept_id) REFERENCES dept(did) ON UPDATE SET NULL ON DELETE CASCADE
);
INSERT INTO dept VALUES(1001,'教学部'); 
INSERT INTO dept VALUES(1002, '财务部'); 
INSERT INTO dept VALUES(1003, '咨询部');

INSERT INTO emp VALUES(1,'canvs',1001);
INSERT INTO emp VALUES(2,'lisa',1001);
INSERT INTO emp VALUES(3,'jack',1002);

SELECT * FROM emp;
SELECT * FROM dept;

UPDATE dept SET did = 1004 WHERE did = 1002;

DELETE FROM dept WHERE did = 1001;


CREATE DATABASE test04;
USE test04;
CREATE TABLE dept(
	did INT PRIMARY KEY,
	dname VARCHAR(50)
);
CREATE TABLE emp(
	eid INT PRIMARY KEY,
	ename VARCHAR(20),
	dept_id INT,
	FOREIGN KEY(dept_id) REFERENCES dept(did) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO dept VALUES(1001,'教学部'); 
INSERT INTO dept VALUES(1002, '财务部'); 
INSERT INTO dept VALUES(1003, '咨询部');

INSERT INTO emp VALUES(1,'canvs',1001);
INSERT INTO emp VALUES(2,'lisa',1001);
INSERT INTO emp VALUES(3,'jack',1002);

UPDATE dept SET did = 1004 WHERE did = 1002;
DELETE FROM dept WHERE did = 1001;

SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
ALTER TABLE emp DROP FOREIGN KEY emp_ibfk_1;
SHOW INDEX FROM emp;
ALTER TABLE emp DROP INDEX dept_id;


CREATE TABLE test2(
	id INT PRIMARY KEY,
	name VARCHAR(20),
	age INT CHECK(age>0 AND age<100)
);
INSERT INTO test2(id,name,age)VALUES(1001,'canvs',102);
INSERT INTO test2 VALUES(1001,'canvs',70);
SELECT * from test;

CREATE TABLE test3(
	id INT PRIMARY KEY,
	name VARCHAR(20),
	age INT CHECK(age>0 AND age<100),
	gender CHAR CHECK(gender IN('男','女'))
);
INSERT INTO test3 VALUES(1001,'tom',22,'男');
INSERT INTO test3 VALUES(1002,'jerry',22,'鼠');
SELECT * from test3;


CREATE TABLE test4(
	id INT PRIMARY KEY,
	name VARCHAR(20),
	gender char(1) DEFAULT('男')
);
INSERT INTO test4(id,name) VALUES(1001,'canvs');
SELECT * FROM test4;

ALTER TABLE test4 MODIFY name VARCHAR(20) DEFAULT('jack');

ALTER TABLE test4 MODIFY name VARCHAR(20);