SELECT customer_id, CAST(age AS VARCHAR(3)), LOWER(location) AS location, CONCAT(CAST(registration_date AS VARCHAR(9)), CAST(registration_date AS VARCHAR(1))) AS registration_date
FROM public.customers

SELECT c.customer_id, p.start_date
FROM public.customers AS c
INNER JOIN sales AS s
ON s.customer_id = c.customer_id
INNER JOIN policy as p
on p.policy_id = s.policy_id
WHERE p.active = True AND p.policy_type = 'US'

SELECT p.policy_type, COUNT(p.active) AS number_active
FROM public.policy AS p
INNER JOIN sales AS s
ON s.policy_id = p.policy_id
INNER JOIN purchase AS ps
ON s.purchase_id = ps.purchase_id
WHERE purchase_type IS NOT NULL AND purchase_type = 'Upgrade' AND p.active = True
GROUP BY p.policy_type
