/* Calculation of the analytic score of each strain in a temporary tables */
DROP TABLE IF EXISTS metrique_scientifique;

SELECT t_souche.xxx_id, sch_identifiant, sch_denomination,

CASE WHEN gal_sch_id IS NOT NULL THEN 2 ELSE 0 END AS api, 
CASE WHEN t_cpr_1546.cpr_resultat IS NOT NULL THEN 10 ELSE 0 END AS wgs,
CASE WHEN seq_sch_id IS NOT NULL THEN 5 ELSE 0 END AS seq, 
CASE WHEN ant_sch_id IS NOT NULL THEN 5 ELSE 0 END AS ant,
CASE WHEN t_cpr_1531.cpr_resultat IS NOT NULL THEN 4 ELSE 0 END AS maldi

INTO metrique_scientifique
FROM t_souche
LEFT JOIN (SELECT t_cp_1531.xxx_id, cpr_sch_id, cpr_resultat, cpr_com
FROM t_carac_phenotypique_resultat AS t_cpr_1531
JOIN t_carac_phenotypique AS t_cp_1531
ON t_cp_1531.xxx_id = t_cpr_1531.cpr_cpy_id
AND t_cp_1531.cpy_numero = 1531) AS t_cpr_1531
ON t_souche.xxx_id = t_cpr_1531.cpr_sch_id

LEFT JOIN (SELECT t_cp_1546.xxx_id, cpr_sch_id, cpr_resultat, cpr_com
FROM t_carac_phenotypique_resultat AS t_cpr_1546
JOIN t_carac_phenotypique AS t_cp_1546
ON t_cp_1546.xxx_id = t_cpr_1546.cpr_cpy_id
AND t_cp_1546.cpy_numero = 1546) AS t_cpr_1546
ON t_souche.xxx_id = t_cpr_1546.cpr_sch_id

LEFT JOIN (SELECT seq_sch_id
FROM t_sequence
LEFT JOIN t_donneedico AS t_seq
ON seq_type = t_seq.xxx_id
WHERE seq_sequence != '' AND don_lib = 'ARN16S'
AND t_sequence.xxx_sup_dat IS NULL) AS t_16S
ON t_16S.seq_sch_id = t_souche.xxx_id

LEFT JOIN (SELECT gal_sch_id
FROM t_galerie
JOIN t_galerieresultat
ON t_galerie.xxx_id = gar_gal_id
WHERE gar_resultat IS NOT NULL
AND t_galerie.xxx_sup_dat IS NULL
GROUP BY gal_sch_id) AS t_api
ON t_souche.xxx_id = gal_sch_id

LEFT JOIN (SELECT ant_sch_id
FROM t_antibiogramme
JOIN t_antibiogrammeresultat
ON t_antibiogramme.xxx_id = anr_ant_id
WHERE anr_resultat IS NOT NULL
AND t_antibiogramme.xxx_sup_dat IS NULL
GROUP BY ant_sch_id) AS t_antibiogramme
ON t_souche.xxx_id = ant_sch_id

WHERE t_souche.xxx_id IN (SELECT xxx_id FROM last_version_souches_cip)
AND LOWER(sch_denomination) NOT LIKE '%pas de souche%'
AND LOWER(sch_denomination) NOT LIKE '%doublon%'
AND LOWER(sch_denomination) NOT LIKE '%distribuer%';
