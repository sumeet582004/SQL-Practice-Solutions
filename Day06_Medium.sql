/*
  SQL Practice Questions & Solutions (44 - 54)
  Database: Hospital
*/

-- QUESTION 44: Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group.
SELECT
    CASE 
        WHEN weight_in_kg < 50 THEN 'Under 50 kg'
        WHEN weight_in_kg BETWEEN 50 AND 100 THEN '50-100 kg'
        WHEN weight_in_kg BETWEEN 100 AND 150 THEN '100-150 kg'
        ELSE 'Over 150 kg'
    END AS weight_group,
    COUNT(*) AS total_patients
FROM admissions
GROUP BY weight_group;


-- QUESTION 45: Show patient_id, weight, and a weight status based on their most recent weight. Underweight: weight < 50kg, Normal: 50-100kg, Overweight: 100-150kg, Obese: weight > 150kg.
SELECT
    a.patient_id,
    a.weight_in_kg,
    CASE 
        WHEN a.weight_in_kg < 50 THEN 'Underweight'
        WHEN a.weight_in_kg BETWEEN 50 AND 100 THEN 'Normal'
        WHEN a.weight_in_kg BETWEEN 100 AND 150 THEN 'Overweight'
        ELSE 'Obese'
    END AS weight_status
FROM admissions a
WHERE a.admission_date = (
    SELECT MAX(admission_date)
    FROM admissions
    WHERE patient_id = a.patient_id
);


-- QUESTION 46: Show patient_id, first_name, last_name, and doctor specialty. Show only the patients who see doctors with the Cardiology specialty. Order the results ascending by patient_id.
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE d.specialty = 'Cardiology'
ORDER BY p.patient_id ASC;


-- QUESTION 47: Show all of the patients and the province_name they are from. Order the results by patient_id.
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    pn.province_name
FROM patients p
JOIN province_names pn ON p.province_id = pn.province_id
ORDER BY p.patient_id ASC;


-- QUESTION 48: Show how many admissions both patients and doctors have on 2025-01-01. Show patient_id, first_name as patient_first_name, doctor_id, first_name as doctor_first_name.
SELECT
    p.patient_id,
    p.first_name AS patient_first_name,
    d.doctor_id,
    d.first_name AS doctor_first_name,
    COUNT(*) AS admissions_count
FROM admissions a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.admission_date = '2025-01-01'
GROUP BY p.patient_id, d.doctor_id
ORDER BY admissions_count DESC;


-- QUESTION 49: Show the difference between the weight of each admission within the same patient. Order the results by patient_id and admission_date.
SELECT
    patient_id,
    admission_date,
    weight_in_kg,
    weight_in_kg - LAG(weight_in_kg) OVER (PARTITION BY patient_id ORDER BY admission_date) AS weight_difference
FROM admissions
ORDER BY patient_id, admission_date;


-- QUESTION 50: Show patient first_name and last_name concatenated into one column to show their full name. Show their admissions count after ordering by the total number of admissions in descending order.
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    COUNT(a.admission_id) AS total_admissions
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_admissions DESC;


-- QUESTION 51: Show the patient_id, admission_date, and diagnosis of patients admitted with pneumonia grouped by patient showing patient's total admissions for pneumonia. Order results by admission_date DESC.
SELECT
    patient_id,
    admission_date,
    diagnosis,
    COUNT(*) OVER (PARTITION BY patient_id) AS total_pneumonia_admissions
FROM admissions
WHERE diagnosis = 'Pneumonia'
ORDER BY admission_date DESC;


-- QUESTION 52: Show the patient_id, first_name, last_name, diagnosis, and total number of times they were admitted with that same diagnosis.
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    a.diagnosis,
    COUNT(*) AS admission_count
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, a.diagnosis
ORDER BY p.patient_id;


-- QUESTION 53: Display average patient age grouped by diagnosis.
SELECT
    diagnosis,
    ROUND(AVG(YEAR(CURDATE()) - YEAR(birth_date)), 1) AS average_age
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
GROUP BY diagnosis
ORDER BY average_age DESC;


-- QUESTION 54: Show the first_name, last_name, and diagnosis of patients who were seen more than once by the same doctor with the same diagnosis.
SELECT DISTINCT
    p.first_name,
    p.last_name,
    a.diagnosis
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE (a.patient_id, a.attending_doctor_id, a.diagnosis) IN (
    SELECT patient_id, attending_doctor_id, diagnosis
    FROM admissions
    GROUP BY patient_id, attending_doctor_id, diagnosis
    HAVING COUNT(*) > 1
);
