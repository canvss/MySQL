SHOW TABLES;

SELECT * FROM employees;

SELECT * FROM departments;

SELECT emp.employee_id,emp.last_name,dep.department_id,dep.department_name
FROM employees AS emp,departments AS dep;

#查询员工姓名和所在部门名称
SELECT emp.last_name,dep.department_name
FROM employees AS emp,departments AS dep
WHERE emp.department_id = dep.department_id;

SELECT e.last_name,d.department_name
FROM employees AS e JOIN departments AS d 
ON e.department_id = d.department_id;

SELECT * FROM locations;

#查询员工姓名、员工部门名称、员工所在城市
SELECT e.last_name,d.department_name,l.city
FROM employees AS e,departments AS d, locations AS l
WHERE e.department_id = d.department_id 
AND d.location_id = l.location_id;

SELECT  e.last_name,d.department_name,l.city
FROM employees AS e JOIN departments AS d 
ON e.department_id = d.department_id 
JOIN locations AS l ON d.location_id = l.location_id;


SELECT * FROM job_grades;

#查询员工对应工资等级
SELECT e.last_name,e.salary,j.grade_level
FROM employees e, job_grades j
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal;

SELECT e.last_name,e.salary,j.grade_level
FROM employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

#查询员工ID、姓名、上级ID、上级姓名
SELECT e1.employee_id,e1.last_name,e2.employee_id,e2.last_name
FROM employees e1, employees e2
WHERE e1.manager_id = e2.employee_id;

SELECT e1.employee_id,e1.last_name,e2.employee_id,e2.last_name
FROM employees e1 JOIN employees e2
ON e1.manager_id = e2.employee_id;

#查询出last_name为 ‘Chen’ 的员工的 manager 的信息。
SELECT e1.last_name,e2.last_name AS "员工领导"
FROM employees e1,employees e2  WHERE e1.last_name = "Chen"
AND e1.manager_id = e2.employee_id;

#INNER可以省略
SELECT e.last_name,d.department_name
FROM employees e INNER JOIN departments d 
ON e.department_id = d.department_id;


#查询员工ID、姓名、部门、城市
SELECT e.employee_id, e.last_name,d.department_name,l.city
FROM employees e JOIN departments d 
ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

#左连接查询员工的部门信息
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id;

#右外连接查询员工部门信息
SELECT  e.employee_id,e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d 
ON e.department_id = d.department_id;

#满外连接
SELECT e.employee_id,e.last_name,d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
UNION
SELECT  e.employee_id,e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d 
ON e.department_id = d.department_id;

#内连接中间图
SELECT e.last_name,d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id;
#左外连接左上图
SELECT e.last_name,d.department_name
FROM employees e LEFT JOIN departments d 
ON e.department_id = d.department_id
#右外连接右上图
SELECT e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d 
ON e.department_id = d.department_id;
#左中图排除查询A表中去除B表重复剩下的数据
SELECT e.last_name,d.department_name
FROM employees e LEFT JOIN departments d 
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;
#右中图查询B表中除去A表重复剩下的数据
SELECT e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;
#右下图
SELECT e.last_name,d.department_name
FROM employees e LEFT JOIN departments d 
ON e.department_id = d.department_id
WHERE e.department_id is NULL
UNION ALL
SELECT e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d 
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;
#左下图:满外连接
SELECT e.last_name,d.department_name
FROM employees e RIGHT JOIN departments d 
ON e.department_id = d.department_id
UNION ALL
SELECT e.last_name,d.department_name
FROM employees e LEFT JOIN departments d 
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;