-- ====================================================================
-- SQL Practice Questions & Solutions (Questions 25 - 35)
-- Platform: SQL-Practice.com
-- ====================================================================


-- 25: Show the city and the total number of patients in the city. 
-- Order from most to least patients and then by city name ascending.
SELECT 
    city, 
    COUNT(patient_id) AS pt_cnt 
FROM patients 
GROUP BY city 
ORDER BY 
    pt_cnt DESC, 
    city ASC;


-- 26: Show first name, last name and role of every person that is either patient or doctor. 
-- The roles are either "Patient" or "Doctor".
SELECT 
    first_name, 
    last_name, 
    'Patient' AS role 
FROM patients 
UNION ALL 
SELECT 
    first_name, 
    last_name, 
    'Doctor' AS role 
FROM doctors;


-- 27: Show all allergies ordered by popularity. Remove NULL values from query.
SELECT 
    COUNT(allergies) AS alcnt, 
    allergies 
FROM patients 
WHERE allergies IS NOT NULL 
GROUP BY allergies 
ORDER BY alcnt DESC;


-- 28: Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
-- Sort the list starting from the earliest birth_date.
SELECT 
    first_name, 
    last_name, 
    birth_date 
FROM patients 
WHERE birth_date LIKE '197%' 
ORDER BY birth_date ASC;


-- 29: We want to display each patient's full name in a single column. 
-- Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
-- Separate the last_name and first_name with a comma. Order the list by the first_name in descending order.
-- EX: SMITH,jane
SELECT 
    CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name 
FROM patients 
ORDER BY first_name DESC;


-- 30: Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
SELECT 
    SUM(height) AS heights, 
    province_id 
FROM patients 
GROUP BY province_id 
HAVING SUM(height) >= 7000;


-- 31: Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'.
SELECT 
    MAX(weight) - MIN(weight) AS diff 
FROM patients 
WHERE last_name = 'Maroni';


-- 32: Show all of the days of the month (1-31) and how many admission_dates occurred on that day. 
-- Sort by the day with most admissions to least admissions.
SELECT 
    DAY(admission_date) AS day_m, 
    COUNT(admission_date) AS visits 
FROM admissions 
GROUP BY day_m 
ORDER BY visits DESC;


-- 33: Show all columns for patient_id 542's most recent admission_date.
SELECT * FROM admissions 
WHERE patient_id = '542' 
ORDER BY admission_date DESC 
LIMIT 1;


-- 34: Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
SELECT 
    patient_id, 
    attending_doctor_id, 
    diagnosis 
FROM admissions 
WHERE 
    (patient_id % 2 != 0 AND attending_doctor_id IN (1, 5, 19)) 
    OR 
    (LEN(patient_id) = 3 AND attending_doctor_id LIKE '%2%');


-- 35: Show first_name, last_name, and the total number of admissions attended for each doctor. 
-- Every admission has been attended by a doctor.
SELECT 
    doctors.first_name, 
    doctors.last_name, 
    COUNT(admissions.admission_date) AS admissions_total 
FROM doctors 
JOIN admissions ON admissions.attending_doctor_id = doctors.doctor_id 
GROUP BY 
    doctors.first_name, 
    doctors.last_name;


