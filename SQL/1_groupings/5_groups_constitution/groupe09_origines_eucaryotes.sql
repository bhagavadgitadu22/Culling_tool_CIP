/* Creation of one temporary table per group/subgroup
Here is the list of strains isolated from an eukaryote based on the field origine of our LIMS */
DROP TABLE IF EXISTS groupe9_origines_eucaryotes;

SELECT t_souche.xxx_id INTO groupe9_origines_eucaryotes FROM t_souche
JOIN t_donneedico
ON sch_origine = t_donneedico.xxx_id
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE don_lib IN ('Animal', 'Human');
