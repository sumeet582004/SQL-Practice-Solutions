# SQL-Practice-Solutions

This repository contains my step-by-step solutions for the beginner-level SQL challenges from [SQL-Practice.com](https://www.sql-practice.com/). The goal is to build strong foundational skills in SQL queries.

---

## 📅 Day 1: 9 Easy Category Questions

### 1. Patient Gender
**Question:** Show first name, last name, and gender of patients whose gender is 'M'.
```sql
SELECT first_name, last_name, gender 
FROM patients 
WHERE gender = 'M';
