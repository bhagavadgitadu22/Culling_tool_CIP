/* Creation of one temporary table per group/subgroup
Here is the list of natural producers according to the list of species compiled in 2_natural_producers */
DROP TABLE IF EXISTS groupe3_npatlas;

SELECT t_souche.xxx_id, sch_identifiant, sch_denomination, sch_synonymes, svl_valeur 
INTO groupe3_npatlas FROM t_souche
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
LEFT JOIN (SELECT * FROM t_string_val AS t_basonyme
JOIN t_attribut AS t_att_basonyme
ON t_basonyme.svl_att_id = t_att_basonyme.xxx_id
AND t_att_basonyme.att_nom = 'Basonyme') AS t_basonyme
ON t_basonyme.svl_entite_id = t_souche.xxx_id
JOIN natural_producers_npatlas
ON t_souche.sch_denomination LIKE CONCAT('%', npatlas_species, '%')
OR t_souche.sch_synonymes LIKE CONCAT('%', npatlas_species, '%')
OR t_basonyme.svl_valeur LIKE CONCAT('%', npatlas_species, '%')
GROUP BY t_souche.xxx_id, sch_identifiant, sch_denomination, sch_synonymes, svl_valeur;
