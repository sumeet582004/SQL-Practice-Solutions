/*
  SQL Practice Questions & Solutions (35 - 43)
  Database: Hospital
*/

-- QUESTION 35: Show patient_id, first_name from patients whose diagnosis is 'Dementia' and order results by first_name ascending.
SELECT
    p.patient_id,
    p.first_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia'
ORDER BY p.first_name ASC;


-- QUESTION 36: Display every patient's patient_id, first_name, last_name, and diagnosis of patients that have had admissions.
SELECT DISTINCT
    p.patient_id,
    p.first_name,
    p.last_name,
    a.diagnosis
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id;


-- QUESTION 37: Display the total amount of admissions.
SELECT COUNT(*) AS total_admissions
FROM admissions;


-- QUESTION 38: Show all the columns from admissions where the patient had a weight gain. (The patient's weight_in_kg is now greater than the weight they previously recorded.)
SELECT *
FROM admissions ad1
WHERE ad1.weight_in_kg > (
    SELECT ad2.weight_in_kg
    FROM admissions ad2
    WHERE ad2.patient_id = ad1.patient_id
    AND ad2.admission_date < ad1.admission_date
    ORDER BY ad2.admission_date DESC
    LIMIT 1
);


-- QUESTION 39: Show patient_id, weight, and height. Calculate BMI (body mass index). BMI = weight(kg) / (height(m))^2, and round BMI to 1 decimal place.
SELECT
    patient_id,
    weight_in_kg,
    height_in_cm,
    ROUND(weight_in_kg / POWER(height_in_cm / 100.0, 2), 1) AS BMI
FROM admissions;


-- QUESTION 40: Show patient_id and diagnosis of patients admitted multiple times for the same diagnosis.
SELECT
    patient_id,
    diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;


-- QUESTION 41: Show the brand name of the medication with the heaviest side effect weight for each half body part side effect.
SELECT
    med.brand_name,
    side_effect.side_effect_name,
    side_effect.weight
FROM medications med
JOIN side_effects side_effect ON med.medication_id = side_effect.medication_id
WHERE side_effect.weight = (
    SELECT MAX(weight)
    FROM side_effects
    WHERE medication_id = med.medication_id
);


-- QUESTION 42: Show the patient first name and the diagnosis they were admitted with and sort the results by patient first name ascending in the following order: 'Dementia', 'Osteoporosis', 'Anemia'. Display results with Dementia first, Osteoporosis second, and Anemia third.
SELECT
    p.first_name,
    a.diagnosis
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis IN ('Dementia', 'Osteoporosis', 'Anemia')
ORDER BY 
    CASE 
        WHEN a.diagnosis = 'Dementia' THEN 1
        WHEN a.diagnosis = 'Osteoporosis' THEN 2
        WHEN a.diagnosis = 'Anemia' THEN 3
    END,
    p.first_name ASC;


-- QUESTION 43: Show the doctors first and last name that have a specialty of Cardiology with a city of Hamilton.
SELECT
    first_name,
    last_name
FROM doctors
WHERE specialty = 'Cardiology' AND city = 'Hamilton';
