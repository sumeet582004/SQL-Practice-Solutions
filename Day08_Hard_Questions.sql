/* ==========================================================================
   SQL-PRACTICE.COM - HOSPITAL DATABASE (QUESTIONS 64 TO 70)
   ========================================================================== */

-- Q64. Show patient_id, first_name, last_name, and total admissions for patients from 'Hamilton' who have more than 3 admissions.
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    COUNT(a.admission_date) AS total_admissions
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE p.city = 'Hamilton'
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING COUNT(a.admission_date) > 3;


-- Q65. Show the province_id and the total number of patients, but only for provinces where the patient count is greater than 100.
SELECT 
    province_id,
    COUNT(*) AS total_patients
FROM patients
GROUP BY province_id
HAVING COUNT(*) > 100;


-- Q66. Show patient_id, weight, height, and IS_OBESE status (where BMI >= 30 is 1, else 0).
-- Formula: BMI = weight (kg) / [height (m)]^2
SELECT 
    patient_id, 
    weight, 
    height,
    CASE 
        WHEN (weight / POWER(height / 100.0, 2)) >= 30 THEN 1
        ELSE 0
    END AS is_obese
FROM patients;


-- Q67. Display each patient's full name and a conditional insurance cost based on patient_id.
-- Even patient_id gets 'Yes' ($10 cost), Odd patient_id gets 'No' ($50 cost). Group by insurance status.
SELECT 
    CASE 
        WHEN patient_id % 2 = 0 THEN 'Yes'
        ELSE 'No'
    END AS has_insurance,
    SUM(CASE 
        WHEN patient_id % 2 = 0 THEN 10
        ELSE 50
    END) AS total_admission_cost
FROM admissions
GROUP BY has_insurance;


-- Q68. Show patient_id, first_name, last_name, and attending doctor's specialty for patients admitted with 'Epilepsy'.
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy';


-- Q69. Pull all patient details where first_name has 'r' as 3rd letter, gender is 'F', born in Feb/May/Dec, weight 60-80, and patient_id is odd.
SELECT *
FROM patients
WHERE first_name LIKE '__r%'
  AND gender = 'F'
  AND MONTH(birth_date) IN (2, 5, 12)
  AND weight BETWEEN 60 AND 80
  AND patient_id % 2 != 0;


-- Q70. Display full name formatted: LAST_NAME in uppercase, first_name in lowercase, separated by a comma. Order by first_name DESC.
SELECT 
    CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS formatted_name
FROM patients
ORDER BY first_name DESC;
