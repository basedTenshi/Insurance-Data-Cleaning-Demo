/*
This script supports Travel Assured's sales team in preparing for a new promotion on upgrades.
The queries within this script are designed to ensure the data is clean, accurate, and ready for use in targeting customers and monitoring the promotion's success.
You may check the png file for the schema.
*/
-- This query cleans the 'customers' table for the sales team's new promotion by matching data types and formats, and identifying and cleaning invalid values as per their requirements.
SELECT customer_id, CAST(age AS VARCHAR(3)), LOWER(location) AS location, CONCAT(CAST(registration_date AS VARCHAR(9)), CAST(registration_date AS VARCHAR(1))) AS registration_date
FROM public.customers
-- This query identifies customers eligible for the international travel insurance promotion. It selects the customer_id and start_date for customers who have an active, US policy.
SELECT c.customer_id, p.start_date
FROM public.customers AS c
INNER JOIN sales AS s
ON s.customer_id = c.customer_id
INNER JOIN policy as p
on p.policy_id = s.policy_id
WHERE p.active = True AND p.policy_type = 'US'
-- This query provides data for the sales team to monitor the number of active policy holders who purchased an upgrade, broken down by policy_type and showing the number_active.
SELECT p.policy_type, COUNT(p.active) AS number_active
FROM public.policy AS p
INNER JOIN sales AS s
ON s.policy_id = p.policy_id
INNER JOIN purchase AS ps
ON s.purchase_id = ps.purchase_id
WHERE purchase_type IS NOT NULL AND purchase_type = 'Upgrade' AND p.active = True
GROUP BY p.policy_type

