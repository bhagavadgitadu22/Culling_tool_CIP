/* Building of a presence absence file of each strain to each group
We export it in csv to use in the R program upset_plot.R to make the plot */
SELECT CASE WHEN groupe1_who.xxx_id IS NULL THEN 0 ELSE 1 END AS g1_who,
CASE WHEN groupe2_zoonotic.xxx_id IS NULL THEN 0 ELSE 1 END AS g2_zoonotic, 
CASE WHEN groupe3_indole.xxx_id IS NULL THEN 0 ELSE 1 END AS g3_indole, 
CASE WHEN groupe3_npatlas.xxx_id IS NULL THEN 0 ELSE 1 END AS g3_npatlas, 
CASE WHEN groupe3_pigment.xxx_id IS NULL THEN 0 ELSE 1 END AS g3_pigment, 
CASE WHEN groupe4_type.xxx_id IS NULL THEN 0 ELSE 1 END AS g4_type, 
CASE WHEN groupe4_type_unsequenced.xxx_id IS NULL THEN 0 ELSE 1 END AS g4_type_unsequenced, 
CASE WHEN groupe5_quality.xxx_id IS NULL THEN 0 ELSE 1 END AS g5_quality, 
CASE WHEN groupe6_gmo.xxx_id IS NULL THEN 0 ELSE 1 END AS g6_gmo,
CASE WHEN groupe7_extremophiles_certain.xxx_id IS NULL THEN 0 ELSE 1 END AS g7_extremophiles_certaino, 
CASE WHEN groupe7_extremophiles_uncertain.xxx_id IS NULL THEN 0 ELSE 1 END AS g7_extremophiles_uncertain, 
CASE WHEN groupe8_archaea.xxx_id IS NULL THEN 0 ELSE 1 END AS g8_archaea,
CASE WHEN groupe9_origines_eucaryotes.xxx_id IS NULL THEN 0 ELSE 1 END AS g9_origines_eucaryotes,
CASE WHEN groupe9_origines_soil.xxx_id IS NULL THEN 0 ELSE 1 END AS g9_origines_soil
/*CASE WHEN groupe0_other.xxx_id IS NULL THEN 0 ELSE 1 END AS g11_other*/
FROM t_souche

LEFT JOIN groupe1_who ON groupe1_who.xxx_id = t_souche.xxx_id
LEFT JOIN groupe2_zoonotic ON groupe2_zoonotic.xxx_id = t_souche.xxx_id
LEFT JOIN groupe3_pigment ON groupe3_pigment.xxx_id = t_souche.xxx_id
LEFT JOIN groupe3_indole ON groupe3_indole.xxx_id = t_souche.xxx_id
/*LEFT JOIN groupe3_AMC_bacillus ON groupe3_AMC_bacillus.xxx_id = t_souche.xxx_id*/
LEFT JOIN groupe3_npatlas ON groupe3_npatlas.xxx_id = t_souche.xxx_id
/*LEFT JOIN groupe3_degradation ON groupe3_degradation.xxx_id = t_souche.xxx_id*/
LEFT JOIN groupe4_type ON groupe4_type.xxx_id = t_souche.xxx_id
LEFT JOIN groupe4_type_unsequenced ON groupe4_type_unsequenced.xxx_id = t_souche.xxx_id
LEFT JOIN groupe5_quality ON groupe5_quality.xxx_id = t_souche.xxx_id
LEFT JOIN groupe6_gmo ON groupe6_gmo.xxx_id = t_souche.xxx_id
LEFT JOIN groupe7_extremophiles_certain ON groupe7_extremophiles_certain.xxx_id = t_souche.xxx_id
LEFT JOIN groupe7_extremophiles_uncertain ON groupe7_extremophiles_uncertain.xxx_id = t_souche.xxx_id
LEFT JOIN groupe8_archaea ON groupe8_archaea.xxx_id = t_souche.xxx_id
LEFT JOIN groupe9_origines_eucaryotes ON groupe9_origines_eucaryotes.xxx_id = t_souche.xxx_id
LEFT JOIN groupe9_origines_soil ON groupe9_origines_soil.xxx_id = t_souche.xxx_id
/*LEFT JOIN groupe0_other ON groupe0_other.xxx_id = t_souche.xxx_id*/

LEFT JOIN (SELECT t_cp_1546.xxx_id, cpr_sch_id, cpr_resultat, cpr_com
FROM t_carac_phenotypique_resultat AS t_cpr_1546
JOIN t_carac_phenotypique AS t_cp_1546
ON t_cp_1546.xxx_id = t_cpr_1546.cpr_cpy_id
AND t_cp_1546.cpy_numero = 1546) AS t_cpr_1546
ON t_souche.xxx_id = t_cpr_1546.cpr_sch_id
LEFT JOIN bacillus_sous_contrat
ON t_souche.sch_identifiant = identifiant_cip

WHERE t_souche.xxx_id IN (SELECT xxx_id FROM groupe0)
AND (t_cpr_1546.cpr_resultat IS NULL OR (t_cpr_1546.cpr_resultat = '' AND t_cpr_1546.cpr_com = ''))
AND identifiant_cip IS NULL
ORDER BY t_souche.sch_identifiant
