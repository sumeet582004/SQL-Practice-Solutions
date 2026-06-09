-- ====================================================================
-- SQL-Practice.com (Hospital Database)
-- Questions 55 to 64: Medium & Hard Level Mixed Solutions
-- Topic: Conditional Logic (CASE WHEN), Data Cleaning & Aggregation
-- ====================================================================

-- 55. Province names ko ascending order mein sort karo, par 'Ontario' humesha top par hona chahiye.
SELECT province_name
FROM province_names
ORDER BY 
    CASE 
        WHEN province_name = 'Ontario' THEN 1 
        ELSE 2 
    END, 
    province_name ASC;


-- 56. Har patient ka full name, height (feet mein rounded to 1 decimal) aur weight (pounds mein) dikhao.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    ROUND(height / 30.48, 1) AS height_feet,
    ROUND(weight * 2.205, 0) AS weight_pounds
FROM patients;


-- 57. Un patients ki details nikalna jinka koi bhi record admissions table mein nahi hai.
SELECT 
    p.patient_id, 
    p.first_name, 
    p.last_name
FROM patients p
LEFT JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.patient_id IS NULL;


-- 58. Har doctor ka full name aur unke total admissions ka count dikhao.
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    COUNT(a.admission_date) AS total_admissions
FROM doctors d
JOIN admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY d.doctor_id;


-- 59. Un patients ki list jinka weight group wise categorization karna hai (e.g., 100-109 -> 100, 110-119 -> 110).
SELECT 
    FLOOR(weight / 10) * 10 AS weight_group,
    COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;


-- 60. Patient_id, weight, height, aur ek custom column 'isObese' (0 ya 1) dikhao based on BMI >= 30.
SELECT 
    patient_id, 
    weight, 
    height,
    CASE 
        WHEN (weight / POWER(height / 100.0, 2)) >= 30 THEN 1 
        ELSE 0 
    END AS isObese
FROM patients;


-- 61. Har unique city ka naam aur usme rehne wale patients ka count dikhao, sorted by highest patients.
SELECT 
    city, 
    COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;


-- 62. Complex Filtering: First name ke 3rd letter par 'r' ho, gender 'F' ho, birth month Feb, May ya Dec ho, aur weight 60-80 ho.
SELECT * FROM patients
WHERE first_name LIKE '__r%'
  AND gender = 'F'
  AND MONTH(birth_date) IN (2, 5, 12)
  AND weight BETWEEN 60 AND 80;


-- 63. Male patients ka percentage total patients mein se kitna hai nikalna.
SELECT 
    CONCAT(ROUND(COUNT(CASE WHEN gender = 'M' THEN 1 END) * 100.0 / COUNT(*), 2), '%') AS male_percentage
FROM patients;


-- 64. Har din ke total admissions aur pichle din ke mukable kitna change (difference) aaya, woh dikhao.
SELECT 
    admission_date,
    COUNT(*) AS current_day_admissions,
    COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY admission_date) AS admission_count_change
FROM admissions
GROUP BY admission_date;
