### SQL概述

#### SQL分类

- DDL（Data Definition Languages）数据定义语言，这些语句定义了不同的数据库、表、视图、索引等数据库对象，还可以用来创建、删除、修改数据库和数据表的结构。
  - 主要的语句关键字包括`CREATE`、`DROP`、`ALTER`等。
- DML（Data Manipulation Language）数据操作语言，用于添加、删除、更新和查询数据库等记录，并检查数据的完整性。
  - 主要的语句关键字包括`INSERT`、`DELETE`、`UPDATE`、`SELECT`等。
- DCL（Data Control Language）数据控制语言，用于定义数据库、表、字段、用户的访问权限和安全级别。
  - 主要的语句关键字包括`GRANT`、`REVOKE`、`COMMIT`、`ROLLBACK`、`SAVEPOINT`等。

#### SQL大小写规范

- MySQL在Windows环境下式大小写不敏感
- MySQL在Linux环境下大小写敏感的
  - 数据库名、表明、表的别名、变量名是严格区分大小写的
  - 关键字、函数名、列名（或字段名）、列的别名是忽略大小写的
- 推荐采用统一的书写规范：
  - 数据库名、表名、表别名、字段名、字段别名等都小写
  - SQL关键字、函数名、绑定变量等都大些

#### 命令规则

- 数据库、表名不得超过30个字符，变量名限制为29个
- 必须只能包含A-Z，a-z，0-9，_共63个字符
- 数据库名、表名、字段名等对象名中间不要包含空格
- 统一MySQL软件中，数据库不能同名；同一库中，表不能重名；同一表中，字段不能重名
- 必须保证你的字段没有和保留字、数据库系统或常用方法冲突。如果坚持使用，请在SQL语句中使用`引起来
- 保持字段名和类型的一致性，在命名字段并为其指定数据类型的时候一定要保证一致性。假如数据类型在一个表里是整数，那在另一个表里就别变成字符型。

#### 数据导入指令

在命令行客户端登录mysql，使用source指令导入

```sql
 mysql> source /root/mysqldb.sql
```

```java
mysql> desc employees;
+----------------+-------------+------+-----+---------+-------+
| Field          | Type        | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| employee_id    | int         | NO   | PRI | 0       |       |
| first_name     | varchar(20) | YES  |     | NULL    |       |
| last_name      | varchar(25) | NO   |     | NULL    |       |
| email          | varchar(25) | NO   | UNI | NULL    |       |
| phone_number   | varchar(20) | YES  |     | NULL    |       |
| hire_date      | date        | NO   |     | NULL    |       |
| job_id         | varchar(10) | NO   | MUL | NULL    |       |
| salary         | double(8,2) | YES  |     | NULL    |       |
| commission_pct | double(2,2) | YES  |     | NULL    |       |
| manager_id     | int         | YES  | MUL | NULL    |       |
| department_id  | int         | YES  | MUL | NULL    |       |
+----------------+-------------+------+-----+---------+-------+
11 rows in set (0.01 sec)
```

- Field:表示字段名称。
- Type:表示字段类型，这里 barcode、goodsname 是文本型的，price 是整数类型的。
- Null:表示该列是否可以存储NULL值。
- Key:表示该列是否已编制索引。PRI表示该列是表主键的一部分;UNI表示该列是UNIQUE索引的一 部分;MUL表示在列中某个给定值允许出现多次。
- Default:表示该列是否有默认值，如果有，那么值是多少。
- Extra:表示可以获取的与给定列有关的附加信息，例如AUTO_INCREMENT等。

#### 基本的SELECT语句

- SELECT....

```SQL
mysql> SELECT 1;
+---+
| 1 |
+---+
| 1 |
+---+
1 row in set (0.00 sec)
mysql> SELECT 1+1;
+-----+
| 1+1 |
+-----+
|   2 |
+-----+
1 row in set (0.00 sec)
```

- SELECT...FROM

```sql
SELECT * FROM employees;
SELECT employee_id,first_name,last_name FROM employees;
```

- 列的别名

```sql
SELECT employee_id AS id, first_name AS name FROM employees;
```

- 去除重复行

```sql
SELECT DISTINCT manager_id AS "领导ID" FROM employees;
SELECT DISTINCT department_id as "部门ID" FROM employees;
```

- 空值参与运算

```SQL
SELECT NULL + 1; #NULL
SELECT DISTINCT employee_id,salary,commission_pct,12 * salary * (1+commission_pct) FROM employees;
```

- 着重号`

```sql
SELECT * FROM `order`;
```

- 显示表结构

```sql
DESCRIBE employees;
DESC employees;
```

- where过滤

```sql
SELECT * FROM employees WHERE salary > 8000;	#查看工资大于8000的
```

