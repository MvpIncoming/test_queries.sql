-- SQL Queries 
-- Author: [Антонов А.Е.]
-- GitHub Repository: https://github.com/MvpIncoming/sql-test-queries.git

-- Запрос 1: Получение опций с ценой выше 900
SELECT 
    o.code, 
    o.name
FROM 
    option o
JOIN 
    option_price op ON o.code = op.option_code
WHERE 
    op.price > 900
ORDER BY 
    op.price ASC;

-- Запрос 2: Количество клиентов, наименование которых начинается на ООО
SELECT 
    COUNT(*) AS client_count
FROM 
    client
WHERE 
    name LIKE 'ООО%';

-- Запрос 3: Наименование и ИНН клиентов с подключенной опцией "Маркетплейс"
SELECT 
    c.name AS client_name, 
    c.inn AS client_inn
FROM 
    client c
JOIN 
    client_option co ON c.inn = co.client_inn
WHERE 
    co.option_code = 'MARKETPLACE';

-- Запрос 4: Наименование и ИНН клиентов с форматом "Клиент (ИНН)" и суммой за обслуживание
SELECT 
    CONCAT(c.name, ' (', c.inn, ')') AS "Клиент (ИНН)",
    (t.price + COALESCE(SUM(op.price), 0)) AS "Сумма за обслуживание"
FROM 
    client c
JOIN 
    tariff t ON c.tariff_code = t.code
LEFT JOIN 
    client_option co ON c.inn = co.client_inn
LEFT JOIN 
    option_price op ON co.option_code = op.option_code
GROUP BY 
    c.name, c.inn, t.price
ORDER BY 
    c.name;

-- Запрос 5: Добавление новой записи в таблицу client
INSERT INTO client (name, inn, tariff_code)
VALUES ('ООО «Крылатые качели»', '8823710320', 'СТАРТОВЫЙ');
