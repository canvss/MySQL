#### 为什么要使用数据库

- 持久化(persistence)：持久化的主要作用是将内存中的数据存储在关系型数据库中，当然也可以存储在磁盘文件、XML数据文件中。

#### 数据库的相关概念

DB：数据库（Database）：即存储数据的仓库，其本质是一个文件系统。它保存了一系列有组织的数据。

DBMS：数据库管理系统（Database Management System）：是一种操纵和管理数据库的大型软件，用于建立、使用维护数据库，对数据库进行统一管理和控制。用户通过数据库系统访问数据库中表内的数据。

SQL：结构化查询语言（Structured Query Language）：专门用来与数据库通信的语言。

#### MySQL介绍

MySQL是一个 开放源代码的关系型数据库管理系统 ，由瑞典MySQL AB(创始人Michael Widenius)公 司1995年开发，迅速成为开源数据库的 No.1。

#### 关系型数据库（RDBMS）

- 关系型数据库模型是把复杂的数据结构归结为简单的二元关系（即二维表格形式）。
- 关系型数据库以行（row）和列（column）的形式存储数据，以便于用户理解。
- SQL就是关系型数据库的查询语言

**优势**：

- 复杂查询可以用SQL语句方便的在一个表以及多个表之间做的非常复杂的数据查询
- 事务支持使得对于安全性能很高的数据访问要求得以实现。

#### 非关系型数据库（非RDBMS）

非关系型数据库，可看成传统关系型数据库的功能 阉割版本 ，基于键值对存储数据，不需要经过SQL层
的解析， 性能非常高 。同时，通过减少不常用的功能，进一步提高性能。

- 键值型数据库
- 文档型数据库
- 搜索引擎数据库
- 列式数据库
- 图形数据库

#### 关系型数据设计规则

- 表、记录、字段
- 表的关联关系
  - 一对一关联（one-to-one）
  - 一对多关系（one-to-many）
  - 多对多（many-to-many）
  - 自我引用（Self reference）

#### MySQL的使用演示

- 登录数据库

```sql
root@f475ab77b5e0:/# mysql -u root -p
Enter password: 
```

- 查看所有的数据库

```sql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| demo               |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)
```

- 创建自己的数据库

```sql
mysql> create database test;
Query OK, 1 row affected (0.01 sec)
```

- 使用自己的数据库

```sql
mysql> use test
Database changed
```

- 创建新的表格

```sql
mysql> create table test(id int, name varchar(20));
Query OK, 0 rows affected (0.01 sec)
```

- 查看某个库的所有表格

```sql
mysql> show tables from test;
+----------------+
| Tables_in_test |
+----------------+
| test           |
+----------------+
1 row in set (0.00 sec)
```

- 添加一条记录

```sql
mysql> insert into test values(1,"Tom");
Query OK, 1 row affected (0.00 sec)
mysql> insert into test values(2,"Jerry");
Query OK, 1 row affected (0.00 sec)
```

- 查看一个表的数据

```sql
mysql> select * from test;
+------+-------+
| id   | name  |
+------+-------+
|    1 | Tom   |
|    2 | Jerry |
+------+-------+
2 rows in set (0.00 sec)
```

- 查看表的创建信息

```sql
mysql> show create table test\G
*************************** 1. row ***************************
       Table: test
Create Table: CREATE TABLE `test` (
  `id` int DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)
```

- 查看数据库的创建信息

```sql
mysql> show create database test\G
*************************** 1. row ***************************
       Database: test
Create Database: CREATE DATABASE `test` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */
1 row in set (0.00 sec)
```

- 删除表格

```sql
 mysql> drop table test;
Query OK, 0 rows affected (0.01 sec)
```

- 删除数据库

```sql
mysql> drop database test;
Query OK, 0 rows affected (0.00 sec)
```

