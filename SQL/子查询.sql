#方式1 
SELECT e.salary
FROM employees e
WHERE e.last_name = 'Abel'; 

SELECT e.last_name,e.salary
FROM employees e 
WHERE e.salary > 11000;

#自连接
SELECT e2.last_name,e2.salary
FROM employees e1, employees e2
WHERE e1.salary < e2.salary AND e1.last_name = "Abel";

#子查询
SELECT e.last_name,
WHERE e.salary > (Se.salary
FROM employees e ELECT e.salary FROM employees e WHERE e.last_name = "Abel");


#查询工资大于149号员工工资的员工的信息
SELECT e1.last_name,e1.salary
FROM employees e1,employees e2 
WHERE e1.salary > e2.salary AND e2.employee_id = 149;

SELECT e1.last_name,e1.salary
FROM employees e1 
WHERE e1.salary > (
	SELECT salary FROM employees WHERE employee_id = 149
);

#返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
SELECT e.last_name,e.job_id,e.salary
FROM employees e 
WHERE e.job_id = (
	SELECT job_id FROM employees WHERE employee_id = 141
)
AND e.salary > (
	SELECT salary FROM employees WHERE employee_id = 143
);

#返回公司工资最少的员工的last_name,job_id和salary
 SELECT last_name,job_id,salary
 FROM employees
 WHERE salary = (SELECT min(salary) FROM employees)
 
 #查询与141号或174号员工的manager_id和department_id相同的其他员工的employee_id， manager_id，department_id
 SELECT employee_id,manager_id,department_id
 FROM employees
 WHERE department_id IN (SELECT department_id FROM employees WHERE employee_id IN (141,174))
 AND manager_id IN (SELECT manager_id FROM employees WHERE employee_id IN(141,174))
 AND employee_id NOT IN (141,174);
 
SELECT employee_id,manager_id,department_id
FROM employees
WHERE (manager_id,department_id) IN (
	SELECT manager_id,department_id FROM employees WHERE employee_id IN(141,174)
)AND employee_id NOT IN(141,174)

#查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT department_id,MIN(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;
HAVING MIN(salary) > (
		SELECT MIN(salary)
		FROM employees
		WHERE department_id = 50
);



#返回其它job_id中比job_id为‘IT_PROG’部门任一工资低的员工的员工号、姓名、job_id 以及salary
SELECT employee_id,last_name,job_id,salary
FROM employees
WHERE salary < ANY(SELECT salary FROM employees WHERE job_id = "IT_PROG") 
AND job_id <> "IT_PROG";

#返回其它job_id中比job_id为‘IT_PROG’部门所有工资都低的员工的员工号、姓名、job_id以及 salary
SELECT employee_id,last_name,job_id,salary
FROM employees
WHERE salary < ALL(SELECT salary FROM employees WHERE job_id = "IT_PROG") 
AND job_id <> "IT_PROG";

#查询平均工资最低的部门id
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
	SELECT MIN(avg_salary) FROM (SELECT AVG(salary) AS avg_salary FROM employees GROUP BY department_id) avg_sal
);


SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) <= ALL(
	SELECT AVG(salary) FROM employees GROUP BY department_id
)

