/* Creation of one temporary table per group/subgroup
Here is the list of extremophiles determined either based on literature or on analytic data in 3_extremophiles */
DROP TABLE IF EXISTS groupe7_extremophiles_certain;

SELECT t_souche.xxx_id INTO groupe7_extremophiles_certain FROM t_souche

LEFT JOIN crossing_extremophiles
ON t_souche.xxx_id = crossing_extremophiles.xxx_id

JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE crossing_extremophiles.xxx_id IS NOT NULL
AND certainty IS TRUE