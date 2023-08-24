/* Temporary table used to store the phenotypic data of CIP strains
It makes the creation of group 3 subgroups easier as the phenotypic data is readily available */
DROP TABLE IF EXISTS groupe3;

SELECT t_souche.xxx_id, 
ARRAY_AGG(cpy_numero ORDER BY cpy_numero) AS array_nums,
ARRAY_AGG(don_lib ORDER BY cpy_numero) AS array_noms,
ARRAY_AGG(cpr_resultat ORDER BY cpy_numero) AS array_ress, 
ARRAY_AGG(cpr_com ORDER BY cpy_numero) AS array_coms
INTO groupe3 FROM t_souche

JOIN (SELECT cpr_sch_id, cpy_numero, don_lib, cpr_resultat, cpr_com FROM t_carac_phenotypique_resultat
LEFT JOIN t_carac_phenotypique
ON t_carac_phenotypique.xxx_id = cpr_cpy_id
LEFT JOIN t_donneedico
ON t_donneedico.xxx_id = cpy_id
WHERE cpr_resultat LIKE '%+%' OR ((cpr_resultat IS NULL OR cpr_resultat NOT LIKE '%-%') AND cpr_com != '')) AS cp
ON t_souche.xxx_id = cpr_sch_id

JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
GROUP BY t_souche.xxx_id;
