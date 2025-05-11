/* Проект «Секреты Тёмнолесья»
 * Цель проекта: изучить влияние характеристик игроков и их игровых персонажей 
 * на покупку внутриигровой валюты «райские лепестки», а также оценить 
 * активность игроков при совершении внутриигровых покупок
 * 
 * Автор: Шуплецов Алекандр
 * Дата: 08.01.2025
*/

-- Часть 1. Исследовательский анализ данных
-- Задача 1. Исследование доли платящих игроков
-- 1.1. Доля платящих пользователей по всем данным:
SELECT
	COUNT(id) AS count_of_all_players,
	SUM(payer) AS count_of_paying_players,
	ROUND(AVG(payer)::NUMERIC, 3) AS share_of_paying_players
FROM
	fantasy.users;	
-- 1.2. Доля платящих пользователей в разрезе расы персонажа:
SELECT
	race,
	SUM(payer) AS count_of_paying_players,
	COUNT(id) AS count_of_all_players,
	ROUND(SUM(payer)::NUMERIC / COUNT(id), 3) AS share_of_paying_players
FROM
	fantasy.users
LEFT JOIN
	fantasy.race USING (race_id)
GROUP BY
	race;
-- Задача 2. Исследование внутриигровых покупок
-- 2.1. Статистические показатели по полю amount:
SELECT
	COUNT(amount) AS count_of_amounts,
	SUM(amount) AS sum_of_amounts,
	MIN(amount) AS min_amount,
	MAX(amount) AS max_amount,
	ROUND(AVG(amount)::NUMERIC, 2) AS avg_of_amounts,
	PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY amount) AS median_of_amounts,
	ROUND(STDDEV(amount)::NUMERIC, 2) AS stand_dev_of_amounts
FROM
	fantasy.events;
-- 2.2: Аномальные нулевые покупки:
WITH count_of_various_amounts AS 
(
	SELECT
		(SELECT
			COUNT(amount) AS count_of_amounts
		FROM
			fantasy.events),
		COUNT(amount) AS count_of_zero_amounts
	FROM
		fantasy.events
	WHERE
		amount = 0
)
SELECT
	count_of_zero_amounts,
	ROUND(count_of_zero_amounts::NUMERIC / count_of_amounts, 4) AS share_of_zero_amounts
FROM
	count_of_various_amounts;
-- 2.3: Сравнительный анализ активности платящих и неплатящих игроков:
WITH total_transactions_and_total_amount AS 
(
	SELECT
		payer,
		id,
		COUNT(transaction_id) AS total_transactions,
		SUM(amount) AS total_amount
	FROM
		fantasy.users
	LEFT JOIN
		fantasy.events USING (id)
	WHERE
		amount > 0
	GROUP BY
		payer,
		id
)
SELECT
	CASE payer
	WHEN 0
		THEN 'неплатящий игрок'
	WHEN 1
		THEN 'платящий игрок'
	END AS player_type,
	COUNT(id) AS total_players,
	ROUND(AVG(total_transactions)::NUMERIC, 2) AS avg_transactions_per_player,
	ROUND(AVG(total_amount)::NUMERIC, 2) AS avg_amount_per_player
FROM
	total_transactions_and_total_amount
GROUP BY
	payer;
-- 2.4: Популярные эпические предметы:
WITH totals AS 
(
	SELECT
		COUNT(DISTINCT id) AS total_players,
		COUNT(DISTINCT transaction_id) AS total_transactions
	FROM
		fantasy.events
	WHERE
		amount > 0
),		
transactions AS 
(
	SELECT
		game_items AS item_name,
		COUNT(DISTINCT transaction_id) AS total_transactions_per_item,
		COUNT(DISTINCT id) AS item_total_players
	FROM 
		fantasy.events
	LEFT JOIN
		fantasy.items USING (item_code)
	WHERE 
		amount > 0
	GROUP BY
		game_items
)
SELECT 
	item_name,
	total_transactions_per_item,
	total_transactions_per_item::NUMERIC / (SELECT total_transactions FROM totals) AS share_of_transactions_per_item,
	item_total_players::NUMERIC / (SELECT total_players FROM totals) AS share_of_item_total_players
FROM
	transactions
ORDER BY
	total_transactions_per_item DESC;
-- Часть 2. Решение ad hoc-задач
-- Задача 1. Зависимость активности игроков от расы персонажа:
WITH total_race_players AS
(
	SELECT
		race,
		COUNT(DISTINCT id) AS total_race_players
	FROM
		fantasy.users
	LEFT JOIN
		fantasy.race USING (race_id)
	GROUP BY
		race
),
total_race_players_w_transactions AS
(
	SELECT
		race,
		COUNT(DISTINCT id) AS total_race_players_w_transactions
	FROM
		fantasy.users 
	LEFT JOIN
		fantasy.race USING (race_id)
	LEFT JOIN
		fantasy.events USING (id)
	WHERE
		amount > 0
	GROUP BY
		race
),
players_w_transactions_share AS 
(
	SELECT
		race,
		ROUND(total_race_players_w_transactions::NUMERIC / total_race_players, 3) AS players_w_transactions_share
	FROM
		total_race_players
	LEFT JOIN
		total_race_players_w_transactions USING (race)
),
user_data AS
(
	SELECT
		DISTINCT id,
		race,
		payer
	FROM
		fantasy.users
	LEFT JOIN
		fantasy.race USING (race_id)
	LEFT JOIN
		fantasy.events USING (id)
	WHERE
		amount > 0
),
payers_among_races AS
(
	SELECT
		race,
		SUM(payer) AS payers_among_races
	FROM
		user_data
	GROUP BY
		race
),
players_w_transactions_share_to_payers AS
(
	SELECT
		race,
		ROUND(payers_among_races::NUMERIC / total_race_players_w_transactions, 3) AS players_w_transactions_share_to_payers 
	FROM 
		total_race_players_w_transactions
	LEFT JOIN
		payers_among_races USING (race)
),
total_transactions_per_player AS 
(
	SELECT
		DISTINCT id AS user_id,
		race,
		COUNT(DISTINCT transaction_id) AS total_transactions_per_player,
		SUM(amount) AS total_amount_per_player,
		COUNT(transaction_id) AS count_of_transactions_per_player
	FROM
		fantasy.users
	LEFT JOIN
		fantasy.events USING (id)
	LEFT JOIN
		fantasy.race USING (race_id)
	WHERE
		amount > 0
	GROUP BY 
		user_id,
		race
),
avg_transactions_per_player AS 
(
	SELECT
		race,
		ROUND(AVG(total_transactions_per_player)::NUMERIC, 2) AS avg_transactions_per_player,
		ROUND(AVG(total_amount_per_player)::NUMERIC, 2) AS avg_total_amount_per_player,
		ROUND(AVG(total_amount_per_player)::NUMERIC / AVG(total_transactions_per_player), 2) AS avg_amount_per_player
	FROM
		total_transactions_per_player
	GROUP BY
		race
)
SELECT
	race,
	total_race_players,
	total_race_players_w_transactions,
	players_w_transactions_share,
	players_w_transactions_share_to_payers,
	avg_transactions_per_player,
	avg_total_amount_per_player,
	avg_amount_per_player
FROM
	total_race_players
LEFT JOIN
	total_race_players_w_transactions USING (race)
LEFT JOIN
	players_w_transactions_share USING (race)
LEFT JOIN
	players_w_transactions_share_to_payers USING (race)
LEFT JOIN
	avg_transactions_per_player USING (race)
ORDER BY
	race;
-- Задача 2: Частота покупок
-- Напишите ваш запрос здесь
