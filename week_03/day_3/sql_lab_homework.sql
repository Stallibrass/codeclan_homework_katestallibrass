-- MVP

-- Q1

SELECT 
	COUNT(id)
FROM employees 
WHERE grade IS NULL AND salary IS NULL;

-- Q2

SELECT 
	department,
	CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
ORDER BY department, last_name;

-- Q3

SELECT 
	*
FROM employees
WHERE last_name LIKE 'A%'
ORDER BY salary DESC NULLS LAST
LIMIT 10;

-- Q4

SELECT 
	department,
	COUNT(id) AS employee_2003_start
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;

-- Q5

SELECT 
	department,
	fte_hours,
	COUNT(id) AS num_employees
FROM employees
GROUP BY department, fte_hours
ORDER BY department, fte_hours;

-- Q6 

SELECT 
	pension_enrol,
	COUNT(id)
FROM employees
GROUP BY pension_enrol;

-- Q7 

SELECT *
FROM employees
WHERE department = 'Accounting' AND pension_enrol IS FALSE
ORDER BY salary DESC NULLS LAST
LIMIT 1;

-- Q8 

SELECT 
	country, 
	COUNT(id) AS num_employees,
	AVG(salary) AS avg_salary
FROM employees
GROUP BY country
HAVING COUNT(id) > 30
ORDER BY avg_salary DESC NULLS LAST;

-- Q9

SELECT 
	first_name,
	last_name,
	fte_hours,
	salary, 
	fte_hours * salary AS effective_yearly_salary
FROM employees
WHERE fte_hours * salary > 30000;

-- Q10

SELECT 
	e.*,
	t.*
FROM employees e LEFT JOIN teams t 
ON e.team_id = t.id
WHERE t.name = 'Data Team 1' OR t.name = 'Data Team 2';

-- Q11

SELECT 
	e.first_name,
	e.last_name 
FROM employees e LEFT JOIN pay_details pd
ON e.pay_detail_id = pd.id
WHERE local_tax_code IS NULL;

-- Q12

SELECT 
	e.id,
	t.name,
	(48 * 35 * CAST(t.charge_cost AS INT) - e.salary) * fte_hours AS expected_profit
FROM employees e LEFT JOIN teams t
ON e.team_id = t.id;

-- Q13

WITH least_common_hours AS 
(SELECT 
	fte_hours AS least_hours,
	COUNT(id) 
FROM employees 
GROUP BY fte_hours
ORDER BY COUNT(id) ASC
LIMIT 1)
SELECT 
	first_name,
	last_name,
	salary
FROM employees 
WHERE country = 'Japan' AND (fte_hours = (SELECT 
											least_hours
										  FROM least_common_hours))
ORDER BY salary ASC NULLS LAST 
LIMIT 1;

-- Q14

SELECT 
	department,
	COUNT(id) AS num_employees_no_name
FROM employees 
WHERE first_name IS NULL
GROUP BY department
HAVING COUNT(id) >= 2
ORDER BY COUNT(id) DESC, department;

-- Q15

SELECT 
	first_name,
	COUNT(id) AS num_name
FROM employees
WHERE first_name IS NOT NULL
GROUP BY first_name
HAVING COUNT(id) > 1
ORDER BY COUNT(id) DESC, first_name;

-- Q16

SELECT 
	department,
	SUM(CAST(grade = 1 AS INT))/CAST(COUNT(id) AS REAL) AS proportion_grade_1
FROM employees
GROUP BY department;

-- Extension
-- Q2

SELECT 
	COALESCE(CAST(pension_enrol AS VARCHAR), 'unknown') AS pension_status,
	COUNT(id) AS num_employees
FROM employees
GROUP BY pension_enrol;

-- Q3

SELECT 
	e.first_name,
	e.last_name, 
	e.email,
	e.start_date,
	c."name" 
FROM (employees e INNER JOIN employees_committees ec 
ON e.id = ec.employee_id) INNER JOIN committees c 
ON ec.committee_id = c.id
WHERE c."name" = 'Equality and Diversity'
ORDER BY start_date ASC;



