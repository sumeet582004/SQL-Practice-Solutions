-- ==========================================
-- DAY 3: SQL PRACTICE QUESTIONS (18 - 24)
-- ==========================================

-- Q18. Show unique first names from the patients table which only occurs once in the list.
SELECT first_name 
FROM patients 
GROUP BY first_name 
HAVING COUNT(first_name) = 1;

-- Q19. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
SELECT patient_id, first_name 
FROM patients 
WHERE first_name LIKE 'S%S' AND LEN(first_name) >= 6;

-- Q20. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
SELECT patients.patient_id, first_name, last_name 
FROM patients 
JOIN admissions ON admissions.patient_id = patients.patient_id 
WHERE diagnosis = 'Dementia';

-- Q21. Display every patient's first_name. Order the list by the length of each name and then alphabetically.
SELECT first_name 
FROM patients 
ORDER BY LEN(first_name), first_name;

-- Q22. Show the total amount of male patients and the total amount of female patients in the patients table (Same row).
SELECT 
  SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count,
  SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM patients;

-- Q23. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'.
SELECT first_name, last_name, allergies 
FROM patients 
WHERE allergies IN ('Penicillin', 'Morphine') 
ORDER BY allergies, first_name, last_name;

-- Q24. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis 
FROM admissions 
GROUP BY patient_id, diagnosis 
HAVING COUNT(*) > 1;
