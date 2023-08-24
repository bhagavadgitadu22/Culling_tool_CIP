/* Number of strains in the group considered (method 1) */
SELECT COUNT(*)
FROM t_souche

LEFT JOIN (SELECT xxx_id, MIN(an::numeric) AS an_historique 
FROM (SELECT xxx_id, 
(regexp_matches(sch_historique, '(<- |^)([0-9]{4}),', 'g'))[2] AS an 
FROM t_souche) AS regex 
GROUP BY xxx_id) AS souche_histo 
ON t_souche.xxx_id = souche_histo.xxx_id

LEFT JOIN (SELECT t_cp_1546.xxx_id, cpr_sch_id, cpr_resultat, cpr_com
FROM t_carac_phenotypique_resultat AS t_cpr_1546
JOIN t_carac_phenotypique AS t_cp_1546
ON t_cp_1546.xxx_id = t_cpr_1546.cpr_cpy_id
AND t_cp_1546.cpy_numero = 1546) AS t_cpr_1546
ON t_souche.xxx_id = t_cpr_1546.cpr_sch_id
