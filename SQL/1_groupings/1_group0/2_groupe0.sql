/* Creation of a group containing all strains under study (all CIP strains minus strains which are under contract or E. coli) */
DROP TABLE IF EXISTS groupe0;

SELECT t_souche.xxx_id INTO groupe0 
FROM t_souche

LEFT JOIN (SELECT t_cp_1546.xxx_id, cpr_sch_id, cpr_resultat, cpr_com
FROM t_carac_phenotypique_resultat AS t_cpr_1546
JOIN t_carac_phenotypique AS t_cp_1546
ON t_cp_1546.xxx_id = t_cpr_1546.cpr_cpy_id
AND t_cp_1546.cpy_numero = 1546) AS t_cpr_1546
ON t_souche.xxx_id = t_cpr_1546.cpr_sch_id

WHERE t_souche.xxx_id IN (SELECT xxx_id FROM last_version_souches_cip)
AND LOWER(sch_denomination) NOT LIKE '%pas de souche%'
AND LOWER(sch_denomination) NOT LIKE '%doublon%'
AND LOWER(sch_denomination) NOT LIKE '%distribuer%'
AND LOWER(sch_denomination) NOT LIKE '%escherichia coli%';
/*AND (t_cpr_1546.cpr_resultat IS NULL OR (t_cpr_1546.cpr_resultat = '' AND t_cpr_1546.cpr_com = ''))*/
