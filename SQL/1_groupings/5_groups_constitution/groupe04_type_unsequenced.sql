/* Creation of one temporary table per group/subgroup
Here is the list of unsequenced type strains */
DROP TABLE IF EXISTS groupe4_type_unsequenced;

SELECT t_souche.xxx_id INTO groupe4_type_unsequenced FROM t_souche

LEFT JOIN (SELECT * FROM t_string_val AS t_basonyme
JOIN t_attribut AS t_att_basonyme
ON t_basonyme.svl_att_id = t_att_basonyme.xxx_id
AND t_att_basonyme.att_nom = 'Basonyme') AS t_basonyme
ON t_basonyme.svl_entite_id = t_souche.xxx_id
LEFT JOIN types_unsequenced
ON t_souche.sch_denomination LIKE CONCAT('%', types_unsequenced.species, '%')
OR t_souche.sch_synonymes LIKE CONCAT('%', types_unsequenced.species, '%')
OR t_basonyme.svl_valeur LIKE CONCAT('%', types_unsequenced.species, '%')
LEFT JOIN (SELECT t_cp_1546.xxx_id, cpr_sch_id, cpr_resultat, cpr_com
FROM t_carac_phenotypique_resultat AS t_cpr_1546
JOIN t_carac_phenotypique AS t_cp_1546
ON t_cp_1546.xxx_id = t_cpr_1546.cpr_cpy_id
AND t_cp_1546.cpy_numero = 1546) AS t_cpr_1546
ON t_souche.xxx_id = t_cpr_1546.cpr_sch_id

JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE sch_identifiant LIKE '%T%'
AND types_unsequenced.species IS NOT NULL
AND t_cpr_1546.cpr_resultat IS NULL