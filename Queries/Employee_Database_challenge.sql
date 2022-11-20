-- Retrieve the emp_no, first_name, 
-- and last_name columns from the Employees table.
SELECT emp_no, first_name, last_name
FROM employees;

-- Retrieve the title, from_date, 
-- and to_date columns from the Titles table.
SELECT title, from_date, to_date
FROM titles;

-- Create a new table using the INTO clause.
-- Join both tables on the pk
-- Filter data by birth_date and sort by emp_no
SELECT employees.emp_no, 
employees.first_name, 
employees.last_name,
titles.title,
titles.from_date,
titles.to_date
INTO retirement_titles
FROM employees
RIGHT JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no ASC;

-- View table
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE retirement_titles.to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

-- Retrieve the number of employees by their 
-- most recent job title who are about to retire
SELECT COUNT(title) AS "no of titles", title
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY "no of titles" DESC;

SELECT * FROM retiring_titles;

-- Create a Mentorship Eligibility table
SELECT DISTINCT ON(employees.emp_no) employees.emp_no, 
employees.first_name, 
employees.last_name, 
employees.birth_date,
dept_emp.from_date,
dept_emp.to_date,
titles.title
INTO mentorship_eligibility
FROM employees
JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE (dept_emp.to_date = '9999-01-01')
AND (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY employees.emp_no;

SELECT * FROM mentorship_eligibility;
