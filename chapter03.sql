--Chapter 3 exercise 1
SELECT school, first_name, last_name
FROM teachers
ORDER BY school ASC, last_name ASC;

--Chapter 3 exercise 2
SELECT first_name, last_name, salary
FROM teachers
WHERE first_name LIKE 'S%' AND salary > 40000;

--Chapter 3 exercise 3
SELECT first_name, 
       last_name, 
       hire_date, 
       salary
FROM teachers
WHERE hire_date >= '2010-01-01'
ORDER BY salary DESC;
