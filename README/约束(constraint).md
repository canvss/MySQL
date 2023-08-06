### 约束（constraint）概述

#### 为什么需要约束？

数据完整性（Data Integrity）是指数据的精确性（Accuracy）和可靠性（Reliability）。它是防止数据库中存在不符合语义规定的数据和防止因错误信息的输入输出造成无效操作或错误信息而提出的。

为了保证数据的完整性，SQL规范以约束的方式对表数据进行额外的条件限制。从以下四个方面考虑：

- 实体完整性（Entity Integrity）：例如，同一个表中，不能存在两条完全相同无法区分的记录
- 域完整性（Domain Integrity）：例如：年龄范围0-120，性别范围男/女
- 引用完整性（Referential Integrity）：例如：员工所在部门，在部门表中要能找到这个部门
- 用户自定义完整性（User-defined Integrity）：例如：用户名唯一、密码不能为空等

#### 什么是约束

约束时表级的强制规定；可以在创建时规定约束，或者在表创建完成后通过ALTER TABLE语句规定约束。

#### 约束的分类

- 根据约束数据列的限制
  - 单列约束：每个约束值约束一列
  - 多列约束：每个约束可约束多列数据
- 根据约束的作用范围
  - 列级约束：只能作用在一个列上，跟在列的定义后面
  - 表级约束：可以作用在多个列上，不与列一起，而是单独定义
- 根据约束起的作用
  - NOT NULL 非空约束，规定某个字段不能为空
  - UNIQUE 唯一约束，规定某个字段在整个表中是唯一的
  - PRIMARY KEY 主键(非空且唯一)约束
  - FOREIGN KEY 外键约束
  - CHECK 检查约束
  - DEFAULT 默认值约束

> 注意：MySQL不支持check约束，但可以使用check约束，而没有任何效果

- 查看某个已有的约束

```sql
#information_schema数据库名(系统库)
#table_constraints表名称(专门存储各个表的约束)
SELECT * FROM information_schema.table_constraints WHERE table_name = '表名称';
```

### 非空约束

- 作用：限定某个字段/某列的值不允许为空

- 关键字：NOT NULL

- 特点：

  - 默认，所有的类型的值都可以是NULL，包括INT、DOUBLE等数据类型

  - 非空约束只能出现在表对象的列上，只能某个列单独限定非空，不能组合非空

  - 一个表可以有很多列都分别限定了非空

  - 空字符串不等于NULL，0也不等于NULL

#### 添加非空约束

##### 建表时

```sql
CREATE TABLE 表名称( 字段名 数据类型,
字段名 数据类型 NOT NULL,
字段名 数据类型 NOT NULL );
```

```SQL
CREATE TABLE test(
	id INT NOT NULL,
	name VARCHAR(15)
);
```

##### 建表后

```SQL
alter table 表名称 modify 字段名 数据类型 not null;
```

```sql
ALTER TABLE test MODIFY name VARCHAR(20) NOT NULL;
```

#### 删除非空约束

```sql
alter table 表名称 modify 字段名 数据类型 NULL;#去掉not null，相当于修改某个非注解字段，该字段允许为空
alter table 表名称 modify 字段名 数据类型;#去掉not null，相当于修改某个非注解字段，该字段允许为空
```

```sql
ALTER TABLE test01 MODIFY id int;
```

### 唯一性约束

- 作用：限制某个字段/某列的值不能重复
- 关键字：UNIQUE
- 特点
  - 同一个表可以有多个唯一约束
  - 唯一约束可以是某一个列的值唯一，也可以多个列组合的唯一值。
  - 唯一性约束允许列值为空
  - 在创建唯一约束的时候，如果不给唯一约束命名，就默认和列名相同
  - MySQL会给唯一约束的列上默认创建一个唯一索引

#### 添加唯一约束

##### 建表时

```sql
create table 表名称( 字段名 数据类型,
字段名 数据类型 unique, 字段名 数据类型 unique key, 字段名 数据类型
);
create table 表名称(
字段名 数据类型,
字段名 数据类型,
字段名 数据类型,
[constraint 约束名] unique key(字段名)
);
```

```sql
CREATE TABLE test03(
	id INT UNIQUE KEY,
	name VARCHAR(20)
);
CREATE TABLE test02(
	id INT,
	name VARCHAR(20),
	UNIQUE KEY(id)
);
```

##### 建表后指定唯一键约束

```sql
#字段列表中如果是一个字段，表示该列的值唯一。如果是两个或更多个字段，那么复合唯一，即多个字段的组合是唯 一的
#方式1:
alter table 表名称 add unique key(字段列表);
#方式2:
alter table 表名称 modify 字段名 字段类型 unique;
```

```sql
CREATE TABLE test04(
	id INT,
	name VARCHAR(10)
);
ALTER TABLE test04 MODIFY id INT UNIQUE KEY;
```

#### 复合约束

```sql
create table 表名称(
 字段名 数据类型, 
 字段名 数据类型, 
 字段名 数据类型,
 unique key(字段列表) #字段列表中写的是多个字段名，多个字段名用逗号分隔，表示那么是复合唯一，即多 个字段的组合是唯一的
);
```

```sql
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
```

#### 删除唯一约束

- 添加唯一性约束的列上也会自动查u你更加爱你唯一索引
- 删除唯一约束只能通过删除唯一索引的方式删除
- 删除时需要指定唯一索引名，唯一索引名就和唯一约束名一样
- 如果创建唯一约束时未指定名称，如果是单列，就默认和列名相同；如果是组合列，那么默认和（）中排在第一个的列名相同。也可以自定义唯一性约束名

```sql
ALTER TABLE student_sourse DROP INDEX sid;
SHOW INDEX FROM student_sourse;	# 查看表的索引
```

### PRIMARY KEY约束

- 作用：用来唯一标识表中的一行记录

- 关键字：primary key

- 特点：
  - 主键约束相当于唯一约束+非空约束的组合，主键约束列不允许重复，也不允许出现空值
  - 一个表最多只能有一个主键约束，建立主键约束可以在列级别创建，也可以在表级别上创建
  - 主键约束对应着表中的一列或多列（复合主键）
  - 如果是多列组合的复合主键约束，那么这些列都不允许为空值，并且组合的值不允许重复
  - MySQL的主键名总是PRIMARY，就算自己命名了主键约束名也没用
  - 当创建主键约束时，系统默认会在所在的列货列组合上建立对应的主键索引（能够根据主键查询的，就根据主键查询，效率更高）。如果删除主键约束了，主键约束对应的索引就自定删除了
  - 需要注意的是，不要修改主键字段的值。因为主键是数据记录的唯一标识，如果修改了主键值，就有可能会破坏数据的完整性

#### 添加主键约束

**建表时指定主键约束**

```sql
create table 表名称(
字段名 数据类型 primary key, #列级模式 字段名 数据类型,
字段名 数据类型
);
create table 表名称(
字段名 数据类型,
字段名 数据类型,
字段名 数据类型,
[constraint 约束名] primary key(字段名) #表级模式
);
```

```sql
CREATE TABLE emp(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20),
	gender CHAR(2)
);
INSERT INTO emp(id,name,gender) VALUES(1001,'canvs','男'),(1002,'lisa','女');
```

```sql
CREATE TABLE emp2(
	id INT AUTO_INCREMENT,
	name VARCHAR(20),
	gender CHAR(2),
	PRIMARY KEY(id)
);
INSERT INTO emp2(name,gender) VALUES('canvs','男'),('lisa','女');
SELECT * FROM emp2;
```

**建表后增加主键约束**

```sql
CREATE TABLE emp3(
	id INT,
	name VARCHAR(20),
	gender CHAR(2)
)
ALTER TABLE emp3 MODIFY id INT PRIMARY KEY AUTO_INCREMENT;
```

#### 关于复合主键

```sql
create table 表名称(
	字段名 数据类型,
	字段名 数据类型,
	字段名 数据类型,
	primary key(字段名1,字段名2) #表示字段1和字段2的组合是唯一的，也可以有更多个字段 
);
```

```sql
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
```

#### 删除主键约束

```sql
alter table 表名称 drop primary key;
```

```sql
ALTER TABLE emp3 drop PRIMARY KEY;
```

### 自增列：AUTO_INCREMENT

- 作用：某个字段的值自增
- 关键字：AUTO_INCREMENT
- 特点和要求
  - 一个表最多只能有一个自增长列
  - 当需要产生位移标识符或顺序值时，可以设置自增长
  - 自增长列约束的列必须是键列（主键列，唯一键列）
  - 自增约束的列的数据类型必须是整数类型
  - 如果自增列指定了0和null，会在当前最大值的基础上自增；如果自增列手动置顶了具体值，直接赋值为具体值

#### 指定自增约束

**建表时**

```sql
create table 表名称(
	字段名 数据类型 primary key auto_increment,
	字段名 数据类型 unique key not null,
	字段名 数据类型 unique key,
	字段名 数据类型 not null default 默认值,
);
create table 表名称(
	字段名 数据类型 default 默认值 ,
	字段名 数据类型 unique key auto_increment, 
  字段名 数据类型 not null default 默认值,
  primary key(字段名)
);
```

```sql
CREATE TABLE emp4(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20)
);
```

**建表后**

```sql
alter table 表名称 modify 字段名 数据类型 auto_increment;
```

```sql
CREATE TABLE emp5(
	id INT PRIMARY KEY,
	name VARCHAR(20)
)
ALTER TABLE emp5 MODIFY id INT AUTO_INCREMENT;
DESC emp5;
```

#### 删除自增约束

```sql
alter table 表名称 modify 字段名 数据类型; #去掉auto_increment相当于删除
```

```sql
ALTER TABLE emp5 MODIFY id INT;
```

> 在MySQL 8.0之前，自增主键AUTO_INCREMENT的值如果大于max(primary key)+1，在MySQL重启后，会重 置AUTO_INCREMENT=max(primary key)+1，这种现象在某些情况下会导致业务主键冲突或者其他难以发 现的问题。

### FOREIGN KEY约束

- 作用：限定某个表的某个字段的引用完整性，如：员工表的员工所在部门的选择，必须在部门表能找到对应的部分
- 关键字：FOREIGN KEY
- 主表和从表/父表和子表
  - 主表：被引用的表，被参考的表
  - 从表：引用别人的表，参考别人的表
  - 如：员工的员工所在部门这个字段的值需要参考部门表：部门表是主表，员工表是从表
- 特点：
  - 从表的外键列，必须引用/参考主表的主键或唯一约束的列
  - 在创建外键约束时，如果不给外间约束命名，默认名不是列名，而是自动产生一个外键名
  - 创建表时就指定外键约束的话，先创建主表，再创建从表
  - 删除表时，先删除从表（或先删除外键约束），再删除主表
  - 当主表的记录被从表参照时，主表的记录将不允许删除，如果要删除数据，需要先删除从表中依赖该记录的数据，然后才可以删除主表的数据
  - 在从表中指定外键约束，并且一个表可以建立多个外键约束
  - 从表的外键列与主表被参照的列名字可以不相同，但是数据类型必须一样，逻辑意义一致，如果类型不一样，创建子表时，就会出现错误`ERROR 1005 (HY000): Can't create table'database.tablename'(errno: 150)。`
  - 当创建外键约束时，系统默认会在所在的列上建立对应的普通索引。但是索引名是外键约束的约束名时（根据外键查询效率高）
  - 删除外键约束后，必须手动删除对应的索引

#### 添加外键约束

**建表时**

```sql
create table 主表名称(
	字段1 数据类型 primary key, 
  字段2 数据类型
);
create table 从表名称(
	字段1 数据类型 primary key,
	字段2 数据类型,
	[CONSTRAINT <外键约束名称>] FOREIGN KEY(从表的某个字段) references 主表名(被参考字段)
);
#(从表的某个字段)的数据类型必须与主表名(被参考字段)的数据类型一致，逻辑意义也一样
#(从表的某个字段)的字段名可以与主表名(被参考字段)的字段名一样，也可以不一样
-- FOREIGN KEY: 在表级指定子表中的列
-- REFERENCES: 标示在父表中的列
```

```sql
CREATE TABLE dept(
	did INT PRIMARY KEY,
	dname VARCHAR(20)
);
CREATE TABLE emp(
	eid INT PRIMARY KEY,
	ename VARCHAR(15),
	dept_id INT,
	FOREIGN KEY(dept_id) REFERENCES dept(did)	#emp表的deptid和和dept表的did的数据类型一致，意义都是表示部门的编号
);
```

**建表后**

```sql
ALTER TABLE 从表名 ADD [CONSTRAINT 约束名] FOREIGN KEY (从表的字段) REFERENCES 主表名(被引用 字段) [on update xx][on delete xx];
```

```sql
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
```

```sql
INSERT INTO dept(did,dname)VALUES(10,'IT')；
INSERT INTO dept(did,dname) VALUES(20,'研发部');
INSERT INTO emp(eid,ename,dept_id)VALUES(1001,'canvs',20),(1002,'lisa',10);
# 部门不存在
# INSERT INTO emp(eid,ename,dept_id) VALUES(1003,'tom',30);
SELECT * FROM emp;
SELECT * FROM dept;
DELETE FROM emp WHERE eid = 1001;
DELETE FROM dept WHERE did = 10;
```

#### 总结

- 添加了外键约束后，主表的修改和删除数据受约束
- 添加了外键约束后，从表的添加和修改数据受约束
- 在从表上建立外键，要求主表必须存在
- 删除主表时，要求从表先删除，或将从表中外键引用该主表的关系先删除

#### 约束等级

- Cascade方式：在父表上update/delete记录时，同步update/delete掉子表的匹配记录
- Set null方式：在父表上update/delete记录时，将子表上匹配的记录的列设为null，但是要注意子表的外键列不能为not null
- No action方式：如果子表中有匹配的记录，则不允许对父表对应候选键进行update/delete操作
- Restrict方式：同no action，都是立即检查外键约束
- Set default方式：父表有变更时，子表将外键列设置成一个默认值，但Innodb不能识别

如果没有指定等级，就相当于Restrict方式

对于外键约束，最好是采用：ON UPDATE CASCADE ON DELETE RESTRICT的方式

##### on update cascade on delete set null

```sql
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

UPDATE dept SET did = 1004 WHERE did = 1002;
mysql> select * from emp;
+-----+-------+---------+
| eid | ename | dept_id |
+-----+-------+---------+
|   1 | canvs |    1001 |
|   2 | lisa  |    1001 |
|   3 | jack  |    1004 |
+-----+-------+---------+
3 rows in set (0.00 sec)

DELETE FROM dept WHERE did = 1001;
mysql> select * from emp;
+-----+-------+---------+
| eid | ename | dept_id |
+-----+-------+---------+
|   1 | canvs |    NULL |
|   2 | lisa  |    NULL |
|   3 | jack  |    1004 |
+-----+-------+---------+
3 rows in set (0.00 sec)
```

##### on update set null on delete cascade

```sql
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
mysql> select * from emp;
+-----+-------+---------+
| eid | ename | dept_id |
+-----+-------+---------+
|   1 | canvs |    1001 |
|   2 | lisa  |    1001 |
|   3 | jack  |    1002 |
+-----+-------+---------+
3 rows in set (0.00 sec)

UPDATE dept SET did = 1004 WHERE did = 1002;
mysql> select * from emp;
+-----+-------+---------+
| eid | ename | dept_id |
+-----+-------+---------+
|   1 | canvs |    1001 |
|   2 | lisa  |    1001 |
|   3 | jack  |    NULL |
+-----+-------+---------+
3 rows in set (0.00 sec)

DELETE FROM dept WHERE did = 1001;
mysql> select * from emp;
+-----+-------+---------+
| eid | ename | dept_id |
+-----+-------+---------+
|   3 | jack  |    NULL |
+-----+-------+---------+
1 row in set (0.00 sec)
```

##### on update cascade on delete cascade

```sql
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

mysql> select * from emp;
+-----+-------+---------+
| eid | ename | dept_id |
+-----+-------+---------+
|   1 | canvs |    1001 |
|   2 | lisa  |    1001 |
|   3 | jack  |    1002 |
+-----+-------+---------+
3 rows in set (0.00 sec)

UPDATE dept SET did = 1004 WHERE did = 1002;
mysql> select * from emp;
+-----+-------+---------+
| eid | ename | dept_id |
+-----+-------+---------+
|   1 | canvs |    1001 |
|   2 | lisa  |    1001 |
|   3 | jack  |    1004 |
+-----+-------+---------+
3 rows in set (0.00 sec)

DELETE FROM dept WHERE did = 1001;
mysql> select * from emp;
+-----+-------+---------+
| eid | ename | dept_id |
+-----+-------+---------+
|   3 | jack  |    1004 |
+-----+-------+---------+
1 row in set (0.00 sec)
```

#### 删除外键约束

```sql
(1)第一步先查看约束名和删除外键约束
SELECT * FROM information_schema.table_constraints WHERE table_name = '表名称';#查看某个 表的约束名
ALTER TABLE 从表名 DROP FOREIGN KEY 外键约束名;
(2)第二步查看索引名和删除索引。(注意，只能手动删除)
SHOW INDEX FROM 表名称; #查看某个表的索引名 
ALTER TABLE 从表名 DROP INDEX 索引名;
```

```sql
SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';
ALTER TABLE emp DROP FOREIGN KEY emp_ibfk_1;
SHOW INDEX FROM emp;
ALTER TABLE emp DROP INDEX dept_id;
```

#### 阿里开发规范

【 强制 】不得使用外键与级联，一切外键概念必须在应用层解决。

说明:(概念解释)学生表中的 student_id 是主键，那么成绩表中的 student_id 则为外键。如果更新学生表中的 student_id，同时触发成绩表中的 student_id 更新，即为级联更新。外键与级联更新适用于单机低并发 ，不适合 分布式 、 高并发集群 ;级联更新是强阻塞，存在数据库更新风暴的风险;外键影响数据库的 。

### CHECK约束

- 作用：检查某个字段的值是否符号xx要求，一般指的是值的范围
- 关键字：CHECK

```sql
CREATE TABLE test2(
	id INT PRIMARY KEY,
	name VARCHAR(20),
	age INT CHECK(age>0 AND age<100)
);
INSERT INTO test2(id,name,age)VALUES(1001,'canvs',102);
INSERT INTO test2 VALUES(1001,'canvs',70);
mysql> select * from test2;
+------+-------+------+
| id   | name  | age  |
+------+-------+------+
| 1001 | canvs |   70 |
+------+-------+------+
1 row in set (0.00 sec)

CREATE TABLE test3(
	id INT PRIMARY KEY,
	name VARCHAR(20),
	age INT CHECK(age>0 AND age<100),
	gender CHAR CHECK(gender IN('男','女'))
);
INSERT INTO test3 VALUES(1001,'tom',22,'男');
INSERT INTO test3 VALUES(1002,'jerry',22,'鼠');
```

### DEFAULT约束

- 作用：给某个字段/某列指定默认值，一旦设置默认值，在插入数据时，如果此字段没有显示赋值，则赋值为默认值
- 关键字：DEFAULT

#### 给字段添加默认值

```sql
CREATE TABLE test4(
	id INT PRIMARY KEY,
	name VARCHAR(20),
	gender char(1) DEFAULT('男')
);
INSERT INTO test4(id,name) VALUES(1001,'canvs');
mysql> select * from test4;
+------+-------+--------+
| id   | name  | gender |
+------+-------+--------+
| 1001 | canvs | 男     |
+------+-------+--------+
1 row in set (0.00 sec)
```

**建表后**

```sql
alter table 表名称 modify 字段名 数据类型 default 默认值;
#如果这个字段原来有非空约束，你还保留非空约束，那么在加默认值约束时，还得保留非空约束，否则非空约束就被 删除了 #同理，在给某个字段加非空约束也一样，如果这个字段原来有默认值约束，你想保留，也要在modify语句中保留默 认值约束，否则就删除了
alter table 表名称 modify 字段名 数据类型 default 默认值 not null;
```

```sql
ALTER TABLE test4 MODIFY name VARCHAR(20) DEFAULT('jack');
```

#### 删除默认值约束

```sql
alter table 表名称 modify 字段名 数据类型 ;#删除默认值约束，也不保留非空约束
alter table 表名称 modify 字段名 数据类型 not null; #删除默认值约束，保留非空约束
```

```sql
ALTER TABLE test4 MODIFY name VARCHAR(20);
```

