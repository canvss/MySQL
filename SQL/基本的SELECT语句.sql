SELECT * FROM employees;
#查询员工12个月的工资总和，并起别名为ANNUAL SALARY
SELECT last_name "姓名",salary*12 "ANNUAL SALARY" FROM employees
SELECT last_name "姓名",salary*12*(1+IFNULL(commission_pct,0)) "ANNUAL SALARY" FROM employees
#查询employees表中去除重复的job_id以后的数据
SELECT DISTINCT job_id FROM employees;
#查询工资大于12000的员工姓名和工资
SELECT e.last_name "姓名",e.department_id "部门ID",e.salary "工资" FROM employees e WHERE e.salary > 12000;
#查询员工号为176的员工的姓名和部门号
SELECT e.last_name,e.department_id,e.employee_id FROM employees e WHERE e.employee_id = 176;
#显示表 departments 的结构，并查询其中的全部数据
DESCRIBE employees;
DESC employees;