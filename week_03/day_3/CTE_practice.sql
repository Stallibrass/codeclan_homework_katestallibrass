-- CTE practice

/*
 * Get a list of the id, first_name, last_name, department, salary and 
 * fte_hours of employees in the smallest department. 
 * Add two extra columns showing the ratio of each employee's 
 * salary to that department's max salary, and each employee's fte_hours 
 * to that department's max fte_hours.
 */

-- 1. Imagine the final table
-- id, first_name, last_name, department, salary, fte_hours, ratios_involving_department_averages

-- 2. Where do these columns come from?
-- employees table, but some need to be derived - ie the ratio columns

-- 3. derive in advance with CTEs

WITH department_breakdown AS (
	SELECT 
		department,
		MAX(fte_hours) AS max_fte_hours,
		MAX(salary) AS max_salary,
		COUNT(id)
	FROM employees
	GROUP BY department
), 
least_employees AS ( 
	SELECT 
		MIN(COUNT) AS smallest_dep_size
	FROM department_breakdown
)
SELECT 
	e.id,
	e.first_name,
	e.department,
	e.salary,
	e.fte_hours,
	dep.max_fte_hours,
	dep.max_salary,
	e.fte_hours / dep.max_fte_hours AS fte_hours_ratio,
	CAST(e.salary AS REAL)/ dep.max_salary AS salary_ratio
FROM employees e LEFT JOIN department_breakdown AS dep 
ON e.department = dep.department;




