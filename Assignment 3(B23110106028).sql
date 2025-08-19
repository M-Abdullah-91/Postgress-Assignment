CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    dept_id INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12,2),
    start_date DATE,
    end_date DATE
);

CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    hours_worked INT,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO departments (dept_id, dept_name, location) VALUES
(1, 'Human Resources', 'New York'),
(2, 'Information Technology', 'San Francisco'),
(3, 'Finance', 'Chicago'),
(4, 'Marketing', 'Los Angeles'),
(5, 'Research & Development', 'Boston'); -- Department with no employees

INSERT INTO employees (emp_id, emp_name, salary, dept_id, hire_date) VALUES
(101, 'John Smith', 65000.00, 1, '2022-01-15'),
(102, 'Sarah Johnson', 85000.00, 2, '2021-06-10'),
(103, 'Mike Davis', 75000.00, 2, '2023-03-20'),
(104, 'Lisa Wilson', 70000.00, 3, '2022-11-05'),
(105, 'David Brown', 90000.00, 2, '2020-08-30'),
(108, 'Jennifer Lee', 55000.00, NULL, '2023-05-25'),
(109, 'Michael Anderson', 60000.00, NULL, '2023-02-14');

INSERT INTO projects (project_id, project_name, budget, start_date, end_date) VALUES
(201, 'Website Redesign', 150000.00, '2023-01-01', '2023-06-30'),
(202, 'Mobile App Development', 300000.00, '2023-03-15', '2023-12-31'),
(203, 'Data Migration', 200000.00, '2023-02-01', '2023-08-31'),
(204, 'Security Audit', 75000.00, '2023-04-01', '2023-05-31'),
(205, 'Customer Portal', 180000.00, '2023-06-01', '2023-11-30');

INSERT INTO employee_projects (emp_id, project_id, hours_worked) VALUES
(102, 201, 120),
(103, 201, 150), 
(102, 202, 200),
(105, 202, 180),
(103, 203, 160),
(104, 203, 140),
(105, 204, 80), 
(101, 204, 60), 
(107, 201, 90);

-- PART 1: BASIC JOINS

-- Query 1:
SELECT 
    e.emp_id,
    e.emp_name,
    e.salary,
    e.hire_date,
    d.dept_name,
    d.location
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
ORDER BY e.emp_id;

-- Query 2:
    d.dept_id,
    d.dept_name,
    d.location,
    e.emp_id,
    e.emp_name,
    e.salary,
    e.hire_date
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
ORDER BY d.dept_id, e.emp_id;

-- Query 3:
SELECT 
    emp_id,
    emp_name,
    salary,
    hire_date
FROM employees
WHERE dept_id IS NULL
ORDER BY emp_id;


-- PART 2: COMPLEX JOINS

-- Query 4: 
SELECT 
    p.project_id,
    p.project_name,
    p.budget,
    p.start_date,
    p.end_date,
    e.emp_id,
    e.emp_name,
    ep.hours_worked
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
LEFT JOIN employees e ON ep.emp_id = e.emp_id
ORDER BY p.project_id, e.emp_id;

-- Query 5: 
SELECT 
    d.dept_id,
    d.dept_name,
    d.location,
    COALESCE(SUM(ep.hours_worked), 0) AS total_hours_worked
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY d.dept_id, d.dept_name, d.location
ORDER BY d.dept_id;

-- Query 6: 
SELECT 
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name
FROM employees e
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE ep.emp_id IS NULL
ORDER BY e.emp_id;


-- PART 3: ANALYSIS QUESTIONS

/*
QUESTION 1:

INNER JOIN:
- Returns only rows that have matching values in both tables
- Excludes rows that don't have a match in either table
- Results in a smaller dataset with only complete matches

LEFT JOIN:
- Returns all rows from the left table, regardless of whether there's a match in the right table
- For rows in the left table with no match in the right table, NULL values are returned for right table columns
- Preserves all data from the left table

WHEN TO USE EACH:

Use INNER JOIN when:
- You only want records that exist in both tables
- You need complete data relationships
- Example: Show only employees who have departments assigned

Use LEFT JOIN when:
- You want to preserve all records from the main/primary table
- You need to identify missing relationships (NULL values)
- You want to include records even if related data doesn't exist
- Example: Show all employees, including those without departments

QUESTION 2: 

RIGHT JOIN is less commonly used than LEFT JOIN for several reasons:

1. READABILITY AND CONVENTION:
   - Most developers read queries from left to right
   - It's more intuitive to think of the main table as the "left" table

2. QUERY STRUCTURE:
   - The FROM clause typically contains the main/primary table
   - It's logical to preserve all records from this primary table using LEFT JOIN

3. EQUIVALENCE:
   - Any RIGHT JOIN can be rewritten as a LEFT JOIN by swapping table positions
   - Developers prefer the LEFT JOIN version for consistency

4. MAINTAINABILITY:
   - LEFT JOIN creates more predictable and maintainable code
   - Most SQL style guides recommend using LEFT JOIN over RIGHT JOIN
   - Team collaboration is easier when everyone uses the same join convention


*/

-- VERIFICATION QUERIES (Optional - to verify sample data covers all scenarios)

-- Verify we have employees without departments
SELECT 'Employees without departments:' AS description, COUNT(*) AS count
FROM employees WHERE dept_id IS NULL
UNION ALL

-- Verify we have departments without employees  
SELECT 'Departments without employees:', COUNT(*)
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.dept_id IS NULL
UNION ALL

-- Verify we have projects without employees
SELECT 'Projects without employees:', COUNT(*)
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
WHERE ep.project_id IS NULL
UNION ALL

-- Verify we have employees without projects
SELECT 'Employees without projects:', COUNT(*)
FROM employees e
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
WHERE ep.emp_id IS NULL;