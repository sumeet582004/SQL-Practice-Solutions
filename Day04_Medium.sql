/*
  SQL Practice Questions & Solutions (24 - 34)
  Database: Hospital
*/

-- QUESTION 24: Show unique birth years from patients and order them ascending.
SELECT DISTINCT
    YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;


-- QUESTION 25: Show all allergies ordered by their popularity. Remove NULL values from total.
SELECT
    allergies,
    COUNT(*) AS total_diagnosis
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC;


-- QUESTION 26: Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Order by birth date ascending.
SELECT
    first_name,
    last_name,
    birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;


-- QUESTION 27: Show first_name, last_name, and the full province name of each patient.
SELECT
    p.first_name,
    p.last_name,
    pn.province_name
FROM patients p
JOIN province_names pn ON p.province_id = pn.province_id;


-- QUESTION 28: Show the total amount of male patients and the total amount of female patients in the patients table. Display columns as male_count and female_count.
SELECT
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM patients;


-- QUESTION 29: Show first name and last name duplicated distinct pairs of patients in the table.
SELECT
    first_name,
    last_name,
    COUNT(*) AS num_of_duplicates
FROM patients
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;


-- QUESTION 30: Show patient_id, first_name, last_name, and attending_doctor_id for patients whose attending_doctor_id is not null and first_name starts with 'C' or ends with 'r'.
SELECT
    patient_id,
    first_name,
    last_name,
    attending_doctor_id
FROM patients
WHERE attending_doctor_id IS NOT NULL
  AND (first_name LIKE 'C%' OR first_name LIKE '%r');


-- QUESTION 31: Show patient_id, diagnosis from admissions where the total amount of admissions for that patient_id is equal to a multiple of 3.
SELECT
    patient_id,
    diagnosis
FROM admissions
GROUP BY patient_id
HAVING COUNT(*) % 3 = 0;


-- QUESTION 32: Show the city and the total number of patients in the city in reverse alphabetical order, only for cities with 10 or more patients.
SELECT
    city,
    COUNT(*) AS total_patients
FROM patients
GROUP BY city
HAVING total_patients >= 10
ORDER BY city DESC;


-- QUESTION 33: Show first_name, last_name, and allergies from patients who have allergies directed to 'Penicillin' or 'Morphine'. Order results by allergies, then first_name, then last_name.
SELECT
    first_name,
    last_name,
    allergies
FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies ASC, first_name ASC, last_name ASC;


-- QUESTION 34: Show the province_id(s) where the total number of patients is greater than or equal to 500.
SELECT
    province_id
FROM patients
GROUP BY province_id
HAVING COUNT(*) >= 500;
