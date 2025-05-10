-- Определите диапазон заработных плат в общем, а именно средние значения, минимумы и максимумы нижних и верхних порогов зарплаты.
SELECT ROUND(AVG(salary_from), 2) AS salary_from_avg, MIN(salary_from) AS salary_from_min, MAX(salary_from) AS salary_from_max, ROUND(AVG(salary_to), 2) AS salary_to_avg, MIN(salary_to) AS salary_to_min, MAX(salary_to) AS salary_to_max
FROM public.parcing_table; 

-- Выявите регионы и компании, в которых сосредоточено наибольшее количество вакансий.
SELECT area, COUNT(id) AS count_of_vacancies
FROM public.parcing_table
GROUP BY area
ORDER BY count_of_vacancies DESC
LIMIT 5;

SELECT employer , COUNT(id) AS count_of_vacancies
FROM public.parcing_table
GROUP BY employer 
ORDER BY count_of_vacancies DESC
LIMIT 5;

-- Проанализируйте, какие преобладают типы занятости, а также графики работы.
SELECT employment, COUNT(id) AS count_of_vacancies
FROM public.parcing_table
GROUP BY employment
ORDER BY count_of_vacancies DESC;

SELECT schedule, COUNT(id) AS count_of_vacancies
FROM public.parcing_table
GROUP BY schedule
ORDER BY count_of_vacancies DESC;

-- Изучите распределение грейдов (Junior, Middle, Senior) среди аналитиков данных и системных аналитиков.
SELECT experience, COUNT(id) AS count_of_vacancies
FROM public.parcing_table
GROUP BY experience
ORDER BY count_of_vacancies DESC;

-- Выявите основных работодателей, предлагаемые зарплаты и условия труда для аналитиков.
SELECT employer, ROUND(AVG(salary_from), 2) AS salary_from_avg, ROUND(AVG(salary_to), 2) AS salary_to_avg, schedule, employment, COUNT(id) AS count_of_vacancies 
FROM public.parcing_table
GROUP BY employer, schedule, employment
ORDER BY count_of_vacancies DESC
LIMIT 5;

-- Определите наиболее востребованные навыки (как жёсткие, так и мягкие) для различных грейдов и позиций.
SELECT key_skills_1, COUNT(id)
FROM public.parcing_table
WHERE key_skills_1 != ''
GROUP BY key_skills_1 
ORDER BY COUNT(id) DESC
LIMIT 5;

SELECT key_skills_2, COUNT(id)
FROM public.parcing_table
WHERE key_skills_2 != ''
GROUP BY key_skills_2 
ORDER BY COUNT(id) DESC
LIMIT 5;

SELECT key_skills_3, COUNT(id)
FROM public.parcing_table
WHERE key_skills_3 != ''
GROUP BY key_skills_3 
ORDER BY COUNT(id) DESC
LIMIT 5;

SELECT key_skills_4, COUNT(id)
FROM public.parcing_table
WHERE key_skills_4 != ''
GROUP BY key_skills_4 
ORDER BY COUNT(id) DESC
LIMIT 5;

SELECT soft_skills_1, COUNT(id)
FROM public.parcing_table
WHERE soft_skills_1 != ''
GROUP BY soft_skills_1
ORDER BY COUNT(id) DESC
LIMIT 5;

SELECT soft_skills_2, COUNT(id)
FROM public.parcing_table
WHERE soft_skills_2 != ''
GROUP BY soft_skills_2
ORDER BY COUNT(id) DESC
LIMIT 5;

SELECT soft_skills_3, COUNT(id)
FROM public.parcing_table
WHERE soft_skills_3 != ''
GROUP BY soft_skills_3
ORDER BY COUNT(id) DESC
LIMIT 5;

SELECT soft_skills_4, COUNT(id)
FROM public.parcing_table
WHERE soft_skills_4 != ''
GROUP BY soft_skills_4
ORDER BY COUNT(id) DESC
LIMIT 5;
-- Посмотрели, какие жесткие и мягкие навыки в топе на каждой позиции требований.