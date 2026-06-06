-- ====================================================================
-- DAY 6: SQL HOSPITAL DATABASE PRACTICE (Questions 36 - 45)
-- ====================================================================

-- 36: For each doctor, display their id, full name, and the first and last admission date they attended.
SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS full_name,
    MIN(a.admission_date) AS first_admission_date,
    MAX(a.admission_date) AS last_admission_date
FROM admissions a
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id, full_name;


-- 37: Display the total amount of patients for each province. Order by descending.
SELECT 
    pn.province_name,
    COUNT(p.patient_id) AS patient_count
FROM patients p
JOIN province_names pn ON pn.province_id = p.province_id
GROUP BY pn.province_name
ORDER BY patient_count DESC;


-- 38: For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    a.diagnosis,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON d.doctor_id = a.attending_doctor_id;


-- 39: Display the number of duplicate patients based on their first_name and last_name.
SELECT 
    first_name,
    last_name,
    COUNT(*) AS num_of_dupes
FROM patients
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;


-- 40: Display patient's full name, height in feet (rounded to 1 decimal), weight in pounds (rounded to 0 decimals), birth_date, and gender non-abbreviated.
-- (Convert CM to feet by dividing by 30.48. Convert KG to pounds by multiplying by 2.205)
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    ROUND((height / 30.48), 1) AS height_feet,
    ROUND((weight * 2.205), 0) AS weight_pounds,
    birth_date,
    CASE 
        WHEN gender = 'M' THEN 'MALE' 
        ELSE 'FEMALE' 
    END AS gender
FROM patients;


-- 41: Show patient_id, first_name, last_name from patients who do not have any records in the admissions table.
SELECT 
    p.patient_id, 
    p.first_name, 
    p.last_name
FROM patients p
WHERE p.patient_id NOT IN (
    SELECT a.patient_id 
    FROM admissions a 
    WHERE a.patient_id IS NOT NULL
);


-- ====================================================================
-- HARD CATEGORY QUESTIONS (42 - 45)
-- ====================================================================

-- 42: Show all of the patients grouped into weight groups (10kg intervals). Show total patients in each group, ordered descending.
SELECT 
    FLOOR(weight / 10) * 10 AS weight_group,
    COUNT(patient_id) AS patients_in_grp
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;


-- 43: Show patient_id, weight, height, and isObese (Display as 1 or 0). Obese defined as weight(kg)/(height(m)^2) >= 30.
SELECT 
    patient_id, 
    weight, 
    height, 
    CASE 
        WHEN weight / POWER(height / 100.0, 2) >= 30 THEN 1 
        ELSE 0 
    END AS isObese
FROM patients;


-- 44: Show patient_id, first_name, last_name, and attending doctor's specialty. Filter for diagnosis 'Epilepsy' and doctor's first name 'Lisa'.
SELECT 
    p.patient_id, 
    p.first_name, 
    p.last_name, 
    d.specialty
FROM patients p
JOIN admissions a ON a.patient_id = p.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';


-- 45: All patients are given a temporary password after their first admission. Show patient_id and temp_password.
-- Password format: patient_id + numerical length of last_name + year of birth_date
SELECT 
    p.patient_id,
    CONCAT(p.patient_id, LENGTH(p.last_name), YEAR(p.birth_date)) AS temp_password
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
GROUP BY p.patient_id;
