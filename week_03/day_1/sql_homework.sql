/* MVP */


-- Q1

SELECT *
FROM employees 
WHERE department = 'Human Resources';

-- Q2

SELECT 
	first_name,
	last_name,
	country
FROM employees 
WHERE department = 'Legal';

-- Q3

SELECT 
	COUNT(*) AS num_portugal_employees
FROM employees 
WHERE country = 'Portugal';

-- Q4

SELECT 
	COUNT(*)
FROM employees 
WHERE country = 'Portugal' OR country = 'Spain';

-- Q5

SELECT *
FROM pay_details 
LIMIT 5;

SELECT 
	COUNT(*) AS num_null_account_no
FROM pay_details 
WHERE local_account_no IS NULL;

-- Q6

SELECT *
FROM pay_details 
WHERE local_account_no IS NULL 
AND (iban IS NULL);

-- Q7

SELECT *
FROM employees 
ORDER BY last_name NULLS LAST;

-- Q8

SELECT 
	first_name,
	last_name,
	country
FROM employees
ORDER BY country, last_name NULLS LAST;

-- Q9 

SELECT *
FROM employees 
ORDER BY salary DESC NULLS LAST 
LIMIT 10;

-- Q10

SELECT 
	first_name, 
	last_name,
	salary
FROM employees 
WHERE country = 'Hungary'
ORDER BY salary ASC 
LIMIT 1;

-- Q11

SELECT 
	COUNT(*) AS num_name_f
FROM employees 
WHERE first_name LIKE 'F%';

-- Q12

SELECT *
FROM employees 
WHERE email LIKE '%yahoo%';

-- Q13

SELECT 
	COUNT(*)
FROM employees 
WHERE country NOT IN ('France', 'Germany')
AND (pension_enrol = TRUE); 

-- Q14

SELECT 
	MAX(salary)
FROM employees
WHERE department = 'Engineering' 
AND fte_hours = 1.0;

-- Q15

SELECT 
	first_name,
	last_name,
	fte_hours,
	salary,
	fte_hours * salary AS effective_yearly_salary
FROM employees;



/* Extension */


-- Q16

SELECT 
	CONCAT(first_name, ' ', last_name, ' - ', department) AS badge_label
FROM employees
WHERE first_name IS NOT NULL
AND last_name IS NOT NULL 
AND department IS NOT NULL;

-- Q17

SELECT 
	CONCAT(first_name, ' ', last_name, ' - ', department, '(joined ', EXTRACT(YEAR FROM start_date), ')') AS badge_label
FROM employees
WHERE first_name IS NOT NULL
AND last_name IS NOT NULL 
AND department IS NOT NULL
AND start_date IS NOT NULL;

-- Q18

SELECT 
	first_name,
	last_name,
	salary,
	CASE 
		WHEN salary < 40000 THEN 'low'
		WHEN salary >= 40000 THEN 'high'
	END AS salary_class
FROM employees 
WHERE salary IS NOT NULL; 
	

