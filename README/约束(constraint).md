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

```

##### 建表后

```SQL
alter table 表名称 modify 字段名 数据类型 not null;
```

```sql

```

#### 删除非空约束

```sql
alter table 表名称 modify 字段名 数据类型 NULL;#去掉not null，相当于修改某个非注解字段，该字段允许为空
alter table 表名称 modify 字段名 数据类型;#去掉not null，相当于修改某个非注解字段，该字段允许为空
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

```

##### 建表后指定唯一键约束

```sql
#字段列表中如果是一个字段，表示该列的值唯一。如果是两个或更多个字段，那么复合唯一，即多个字段的组合是唯 一的
#方式1:
alter table 表名称 add unique key(字段列表);
#方式2:
alter table 表名称 modify 字段名 字段类型 unique;
```

```

```

