# 1.选择工资不在5000到12000的员工的姓名和工资
SELECT e.last_name,e.salary FROM employees e WHERE NOT e.salary BETWEEN 5000 AND 12000;
SELECT e.last_name,e.salary FROM employees e WHERE NOT (e.salary >= 5000 AND e.salary <= 12000);
# 2.选择在20或50号部门工作的员工姓名和部门号
SELECT e.last_name,e.department_id FROM employees e WHERE e.department_id = 50 OR e.department_id = 20;
# 3.选择公司中没有管理者的员工姓名及job_id
SELECT e.last_name,e.job_id FROM employees e WHERE e.department_id IS NULL;
# 4.选择公司中有奖金的员工姓名，工资和奖金级别 
SELECT e.last_name,e.commission_pct FROM employees e WHERE e.commission_pct IS NOT NULL;
# 5.选择员工姓名的第三个字母是a的员工姓名
SELECT e.last_name FROM employees e WHERE e.last_name LIKE('__a%');
# 6.选择姓名中有字母a和k的员工姓名
SELECT e.last_name FROM employees e WHERE e.last_name LIKE("%k%a%") OR e.last_name LIKE("%a%k%");
SELECT e.last_name FROM employees e WHERE e.last_name LIKE("%a%") AND e.last_name LIKE("%k%");
# 7.显示出表 employees 表中 first_name 以 'e'结尾的员工信息
SELECT e.first_name FROM employees e WHERE e.first_name LIKE('%e');
# 8.显示出表 employees 部门编号在 80-100 之间的姓名、工种
SELECT e.first_name,e.job_id,e.department_id FROM employees e WHERE e.department_id BETWEEN 80 AND 100;
# 9.显示出表 employees 的 manager_id 是 100,101,102 的员工姓名、工资、管理者id
select e.last_name,e.salary,e.manager_id FROM employees e WHERE e.manager_id IN(100,101,102);