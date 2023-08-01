SELECT ABS(-20),PI(),MOD(10,3),RAND(),RAND(2),RAND(2),ROUND(4.7),ROUND(3.2),SQRT(16)
FROM DUAL;

SELECT BIN(10),HEX(12),OCT(10)
FROM DUAL;

SELECT ASCII('A'),CHAR_LENGTH('helloworld'),LENGTH("你好"),CONCAT("hello","world"),UPPER("Hello"),LOWER("HELLO"),REVERSE("hello")
FROM
DUAL;

SELECT CURDATE(),CURRENT_DATE(),CURDATE(),NOW(),UTC_DATE()
FROM 
DUAL;

SELECT UNIX_TIMESTAMP(),UNIX_TIMESTAMP("2020-9-25"),FROM_UNIXTIME("1600992000")
FROM
DUAL;

SELECT CURRENT_TIME FROM DUAL;

SELECT YEAR(CURRENT_DATE),MONTH(CURRENT_DATE),DAY(CURRENT_DATE),HOUR(CURRENT_TIME),MINUTE(CURRENT_TIME),SECOND(CURRENT_TIME)
FROM
DUAL;

SELECT STR_TO_DATE(NOW(),"%Y-%m-%d %H:%i:%s")
FROM
DUAL;

SELECT e.last_name,e.salary,CASE
	WHEN e.salary > 10000 THEN
		"高薪"
	WHEN e.salary > 8000 THEN
	"屌丝"
END
FROM employees e 

SELECT VERSION(),CONNECTION_ID(),DATABASE(),SESSION_USER()
FROM DUAL;

# 1.显示系统时间(注:日期+时间)
SELECT NOW() FROM DUAL;
# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果(new salary)
SELECT e.employee_id,e.last_name,e.salary,e.salary*(1+0.2) "new salary" FROM employees e;
# 3.将员工的姓名按首字母排序，并写出姓名的长度(length)
SELECT e.last_name,LENGTH(e.last_name) FROM employees e ORDER BY last_name DESC;
# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
SELECT CONCAT(e.employee_id,e.last_name,e.salary) OUT_PUT FROM employees e;
# 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
SELECT e.last_name,DATEDIFF(SYSDATE(),e.hire_date)/265 worked_years, DATEDIFF(SYSDATE(),e.hire_date) worked_days 
FROM employees e ORDER BY worked_years DESC;
# 6.查询员工姓名，hire_date , department_id，满足以下条件:雇用时间在1997年之后，department_id 为80 或 90 或110, commission_pct不为空
SELECT e.last_name,e.hire_date,e.department_id
FROM employees e 
WHERE DATE_FORMAT(e.hire_date,"%Y") >= "1997"
AND e.department_id IN(80,90,110)
AND e.commission_pct IS NOT NULL;
# 7.查询公司中入职超过10000天的员工姓名、入职时间
SELECT e.last_name,e.hire_date
FROM employees e 
WHERE DATEDIFF(NOW(),e.hire_date) > 10000;
