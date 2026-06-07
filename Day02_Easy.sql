-- ====================================================================
-- 📊 SQL-PRACTICE.COM - DAY 2: easy level QUESTIONS (10 to 17)
-- ====================================================================

-- 🔹 Question 10: Show first name and last name of patients who do not live in 'Hamilton'.
SELECT first_name, last_name
FROM patients
WHERE city <> 'Hamilton';


-- 🔹 Question 11: Show first name and last name of patients who have a weight between 60 and 80 (inclusive).
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 60 AND 80;


-- 🔹 Question 12: Show first name, last name, and city of patients who are from 'Toronto', 'Guelph', or 'Hamilton'.
SELECT first_name, last_name, city
FROM patients
WHERE city IN ('Toronto', 'Guelph', 'Hamilton');


-- 🔹 Question 13: Show first name, last name of patients whose height is greater than 160 and weight is greater than 70.
SELECT first_name, last_name
FROM patients
WHERE height > 160 AND weight > 70;


-- 🔹 Question 14: Show unique cities that patients are from where the country is 'Canada' or province_id is 'ON'.
SELECT DISTINCT city
FROM patients
WHERE province_id = 'ON';


-- 🔹 Question 15: Show first name, last name of patients whose first_name starts with 'C' and ends with 'r'.
SELECT first_name, last_name
FROM patients
WHERE first_name LIKE 'C%r';


-- 🔹 Question 16: Show first name and last name of patients who do not have a registered phone number (phone number is null).
SELECT first_name, last_name
FROM patients
WHERE phone_number IS NULL;


-- 🔹 Question 17: Show first name, last name, and allergies of patients from 'Hamilton' who have allergies.
SELECT first_name, last_name, allergies
FROM patients
WHERE city = 'Hamilton' AND allergies IS NOT NULL;
