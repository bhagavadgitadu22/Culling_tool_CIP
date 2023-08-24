/* Creation of one temporary table per group/subgroup
Here is the list of zoonotic pathogens */
DROP TABLE IF EXISTS groupe2_zoonotic;

SELECT t_souche.xxx_id INTO groupe2_zoonotic FROM t_souche
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE sch_denomination SIMILAR TO '%(Enterococcus faecalis|Pseudomonas|Aeromonas|Vibrio)%' AND sch_denomination NOT LIKE '%Pseudomonas aeruginosa%'
