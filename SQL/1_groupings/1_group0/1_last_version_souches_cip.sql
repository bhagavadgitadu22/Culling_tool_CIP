/* Only latest version of each CIP strain kept in table last_version_souches_cip */
DROP TABLE IF EXISTS last_version_souches_cip;

SELECT DISTINCT ON (sch_cpt_id) 
t_souche.xxx_id, sch_identifiant, sch_version, 
sch_dat_acquisition, sch_dat_pheno, sch_qualite_dat_approbation,
sch_type, sch_catalogue, sch_col_id,
trim(sch_denomination) AS sch_denomination,
sch_temperature_incubation, sch_temps_culture,
t_basonyme.svl_valeur AS basonyme, sch_synonymes,
sch_proprietes, sch_bibliographie,
t_lieu.don_lib AS lieu_origine, sch_lieu_precis, 
t_origine.don_lib AS source_origine, sch_isole_a_partir_de,
sch_dat_prelevement, sch_dat_isolement, sch_taxonomie, 
sch_references_equi, t_straindesignation.svl_valeur AS straindesignation,
sch_historique, sch_autres_coll, sch_depositaire, sch_pto_id
INTO TABLE last_version_souches_cip
FROM t_souche

LEFT JOIN (SELECT att_col_id, svl_entite_id, svl_valeur FROM t_attribut 
		   LEFT JOIN t_string_val ON t_string_val.svl_att_id = t_attribut.xxx_id
		   WHERE att_nom = 'Basonyme') AS t_basonyme
ON t_basonyme.att_col_id = t_souche.sch_col_id
AND t_basonyme.svl_entite_id = t_souche.xxx_id

LEFT JOIN (SELECT att_col_id, svl_entite_id, svl_valeur FROM t_attribut 
		   LEFT JOIN t_string_val ON t_string_val.svl_att_id = t_attribut.xxx_id
		   WHERE att_nom = 'Strain Designation') AS t_straindesignation
ON t_straindesignation.att_col_id = t_souche.sch_col_id
AND t_straindesignation.svl_entite_id = t_souche.xxx_id

LEFT JOIN t_donneedico AS t_lieu
ON t_lieu.xxx_id = sch_lieu
LEFT JOIN t_donneedico AS t_origine
ON t_origine.xxx_id = sch_origine

WHERE sch_col_id IN
(SELECT xxx_id
FROM t_collection
WHERE col_clg_id = 401)
AND t_souche.xxx_sup_dat IS NULL
ORDER BY sch_cpt_id, sch_version DESC;
