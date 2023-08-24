/* Creation of one temporary table per group/subgroup
Here is the list of unsequenced type strains in CIP (potentially sequenced elsewhere though) */
DROP TABLE IF EXISTS groupe4_type;

SELECT t_souche.xxx_id INTO groupe4_type FROM t_souche
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE sch_identifiant LIKE '%T%';
