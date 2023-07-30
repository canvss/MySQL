#1. 查询员工的姓名和部门号和年薪，按年薪降序,按姓名升序显示
SELECT e.last_name,e.salary FROM employees e ORDER BY e.salary DESC,e.last_name ASC;
#2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序，显示第21到40位置的数据 
select e.last_name,e.salary FROM employees e WHERE NOT e.salary BETWEEN 8000 AND 17000 ORDER BY e.salary DESC LIMIT 20,20;
#3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升序
SELECT last_name,email,department_id FROM employees e WHERE e.email LIKE('%e%') ORDER BY LENGTH(e.email) DESC;