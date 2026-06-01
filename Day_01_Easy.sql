-- Day 1: 9 Easy Category Questions

-- 1. Patient Gender
-- Question: Show first name, last name, and gender of patients whose gender is 'M'.
SELECT first_name, last_name, gender 
FROM patients 
WHERE gender = 'M';

-- 2. Patients with No Allergies
-- Question: Show first name and last name of patients who does not have any allergies (is null).
SELECT first_name, last_name 
FROM patients 
WHERE allergies IS NULL;

-- 3. First Name Starting with 'C'
-- Question: Show first name of patients that start with the letter 'C'.
SELECT first_name 
FROM patients 
WHERE first_name LIKE 'C%';

-- 4. Patients with Specific Weight Range
-- Question: Show first name and last name of patients that weigh between 100 and 120 (inclusive).
SELECT first_name, last_name 
FROM patients 
WHERE weight BETWEEN 100 AND 120;

-- 5. Update Allergies Column
-- Question: Update the patients table of the allergies column. If the patient's allergy is null, change it to 'NKA' (No Known Allergies).
UPDATE patients 
SET allergies = 'NKA' 
WHERE allergies IS NULL;

-- 6. Concatenate First and Last Name
-- Question: Show first name and last name concatenated into one column to show their full name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name 
FROM patients;

-- 7. Patients from Specific Cities
-- Question: Show first name, last name, and city of patients who live in 'Hamilton' or 'Toronto'.
SELECT first_name, last_name, city 
FROM patients 
WHERE city IN ('Hamilton', 'Toronto');

-- 8. Patient ID and Height
-- Question: Show patient_id and height of patients whose height is greater than 160.
SELECT patient_id, height 
FROM patients 
WHERE height > 160;

-- 9. Patient Count by Gender
-- Question: Show the total number of female ('F') and male ('M') patients in the patients table.
SELECT gender, COUNT(*) AS total_patients 
FROM patients 
GROUP BY gender;
