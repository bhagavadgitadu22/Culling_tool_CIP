/* Creation of one last panel containing strains belonging to none of the previous panels */
DROP TABLE IF EXISTS groupe0_other;

SELECT t_souche.xxx_id INTO groupe0_other FROM t_souche
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe1_who)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe2_zoonotic)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe3_indole)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe3_pigment)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe3_npatlas)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe4_type)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe4_type_unsequenced)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe5_quality)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe6_gmo)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe7_extremophiles_certain)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe7_extremophiles_uncertain)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe8_archaea)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe9_origines_eucaryotes)
AND t_souche.xxx_id NOT IN (SELECT xxx_id FROM groupe9_origines_soil);
