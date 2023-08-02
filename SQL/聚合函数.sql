SELECT AVG(e.salary),SUM(e.salary),MAX(e.salary),MIN(e.salary),COUNT(*),COUNT(1),COUNT(e.manager_id)
FROM employees e;

SELECT e.job_id, e.department_id,AVG(e.salary)
FROM employees e
GROUP BY e.department_id,e.job_id;


SELECT e.job_id,SUM(e.salary)
FROM employees e
GROUP BY e.job_id;


SELECT department_id,AVG(salary)
FROM employees e 
WHERE department_id > 80
GROUP BY department_id WITH ROLLUP;


SELECT
	e.department_id,
	MAX( salary ) 
FROM
	employees e 
GROUP BY
	e.department_id 
HAVING
	MAX( e.salary ) > 10000;
	
	
	
	#2.查询公司员工工资的最大值，最小值，平均值，总和

SELECT MAX(e.salary),MIN(e.salary),AVG(e.salary),SUM(e.salary) FROM employees e;
#3.查询各job_id的员工工资的最大值，最小值，平均值，总和

SELECT e.job_id,MAX(e.salary),MIN(e.salary),AVG(e.salary),SUM(e.salary) FROM employees e GROUP BY e.job_id;
 #4.选择具有各个job_id的员工人数
 SELECT e.job_id,COUNT(*) FROM employees e GROUP BY e.job_id
 
# 5.查询员工最高工资和最低工资的差距(DIFFERENCE)
SELECT MAX(e.salary) - MIN(e.salary) FROM employees e;

# 6.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
SELECT e.manager_id, MIN(e.salary) FROM employees e WHERE e.manager_id IS NOT NULL GROUP BY e.manager_id HAVING MIN(e.salary) > 6000;

# 7.查询所有部门的名字，location_id，员工数量和平均工资，并按平均工资降序
SELECT d.department_name,d.location_id,COUNT(e.department_id),AVG(e.salary) AS avg_salary FROM employees e, departments d
 WHERE e.department_id = d.department_id GROUP BY d.department_name,d.location_id ORDER BY avg_salary DESC;

# 8.查询每个工种、每个部门的部门名、工种名和最低工资
SELECT e.job_id,d.department_name,MIN(e.salary) FROM employees e RIGHT JOIN departments d ON
e.department_id = d.department_id GROUP BY e.job_id,d.department_name 