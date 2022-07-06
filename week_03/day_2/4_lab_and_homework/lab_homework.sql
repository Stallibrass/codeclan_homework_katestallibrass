-- MVP

-- Q1
-- a
SELECT 
	e.first_name,
	e.last_name,
	t."name" 
FROM employees e INNER JOIN teams t
	ON e.team_id = t.id;

-- b
SELECT 
	e.first_name,
	e.last_name,
	t."name" 
FROM employees e INNER JOIN teams t
	ON e.team_id = t.id
WHERE e.pension_enrol IS TRUE;

-- c 
SELECT 
	e.first_name,
	e.last_name,
	t."name" 
FROM employees e INNER JOIN teams t
	ON e.team_id = t.id
WHERE CAST(t.charge_cost AS INT4) > 80;


-- Q2
-- a 
SELECT 
	e.*,
	p.local_account_no ,
	p.local_sort_code 
FROM employees e INNER JOIN pay_details p
	ON e.pay_detail_id = p.id
WHERE p.local_account_no IS NOT NULL 
AND p.local_sort_code IS NOT NULL; 

-- b
SELECT 
	e.*,
	p.local_account_no ,
	p.local_sort_code,
	t."name" AS team_name
FROM (employees e INNER JOIN pay_details p
	ON e.pay_detail_id = p.id) 
	INNER JOIN teams t
		ON e.team_id = t.id;

	
-- Q3
-- a
SELECT 
	e.id,
	t."name" AS team_name
FROM employees e LEFT JOIN teams t
	ON e.team_id = t.id;

-- b
SELECT 
	t."name" AS team_name,
	COUNT(e.id) AS num_team_members
FROM employees e LEFT JOIN teams t
	ON e.team_id = t.id
GROUP BY t."name";

-- c 
SELECT 
	t."name" AS team_name,
	COUNT(e.id) AS num_team_members
FROM employees e LEFT JOIN teams t
	ON e.team_id = t.id
GROUP BY t."name"
ORDER BY COUNT(e.id) ASC;

-- Q4
-- a
SELECT 
	t.id,
	t."name" AS team_name,
	COUNT(e.id) AS num_team_members
FROM employees e LEFT JOIN teams t
	ON e.team_id = t.id 
GROUP BY t.id;

-- b
SELECT 
	t.id,
	t."name",
	CAST(t.charge_cost AS INT4)*COUNT(e.id) AS total_day_charge
FROM teams t LEFT JOIN employees e
	ON t.id = e.team_id 
GROUP BY t.id; 

-- c 
SELECT 
	t.id,
	t."name",
	CAST(t.charge_cost AS INT4)*COUNT(e.id) AS total_day_charge
FROM teams t LEFT JOIN employees e
	ON t.id = e.team_id 
GROUP BY t.id
HAVING CAST(t.charge_cost AS INT4)*COUNT(e.id) > 5000;

-- Q5
SELECT 
	COUNT(DISTINCT(employee_id)) 
FROM employees_committees;


-- Q6
SELECT 
	COUNT(e.id)
FROM employees e LEFT JOIN employees_committees ec
	ON e.id = ec.employee_id
WHERE ec.committee_id IS NULL;