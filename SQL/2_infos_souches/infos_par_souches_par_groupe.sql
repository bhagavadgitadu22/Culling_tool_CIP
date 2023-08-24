/* Reunion of the main information concerning each strain in a single temporary table for easiness of use */
SELECT t_souche.xxx_id AS id_bdd, sch_identifiant AS identifiant_cip, 
sch_version AS numero_version, sch_denomination AS denomination, 
sch_catalogue AS au_catalogue, sch_dat_isolement AS date_isolement, 
sch_dat_prelevement AS date_prelevement, sch_historique AS historique,
LEAST(EXTRACT(YEAR FROM sch_dat_isolement), EXTRACT(YEAR FROM sch_dat_prelevement), an_historique) AS historical_value,
t_origine.don_lib AS origine, sch_isole_a_partir_de AS isole_de, 
t_country.don_lib AS pays, sch_references_equi AS references_equivalentes, 
substring(sch_references_equi, 'WDCM ?([0-9]+)') AS wdcm,
sch_temps_culture AS temps_culture, t_atmosphere_incubation.don_lib AS atmosphere_incubation, 
sch_temperature_incubation AS temperature_incubation, nums_milieux, sch_proprietes AS proprietes,

CASE WHEN gal_sch_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS api, 
CASE WHEN t_cpr_1546.cpr_resultat IS NOT NULL THEN 'Yes' ELSE 'No' END AS wgs,
CASE WHEN strains_sequenced_ncbi.id_brclims IS NOT NULL THEN 'Yes' ELSE 'No' END AS sequence_on_ncbi, reason,
CASE WHEN seq_sch_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS sequences, 
CASE WHEN ant_sch_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS antibiograms,
CASE WHEN t_cpr_1531.cpr_resultat IS NOT NULL THEN 'Yes' ELSE 'No' END AS maldi,

t_stockage.don_lib AS type_distrib, t_stockage.sum AS stock_distrib, 
CASE 
	WHEN EXTRACT(YEAR FROM recent_distrib) != 1 THEN EXTRACT(YEAR FROM recent_distrib) 
	ELSE NULL
END AS last_creation_distrib,
CASE 
	WHEN EXTRACT(YEAR FROM recent_prod) != 1 THEN EXTRACT(YEAR FROM recent_prod) 
	ELSE NULL 
END AS last_creation_prod

FROM t_souche

LEFT JOIN t_donneedico AS t_origine
ON t_origine.xxx_id = sch_origine
LEFT JOIN t_donneedico AS t_country
ON t_country.xxx_id = sch_lieu

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
LEFT JOIN strains_sequenced_ncbi 
ON t_souche.sch_identifiant = strains_sequenced_ncbi.id_brclims

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

LEFT JOIN (SELECT lot_sch_id, SUM(lot_qte_stock) AS sum, MAX(t_lot.xxx_cre_dat) AS recent_distrib,
ARRAY_TO_STRING(ARRAY_AGG(DISTINCT t_type_stockage.don_lib), ';') AS don_lib
FROM t_lot
JOIN t_donneedico AS t_type
ON t_type.xxx_id = lot_type
JOIN t_donneedico AS t_type_stockage
ON t_type_stockage.xxx_id = lot_type_stockage
WHERE t_type.don_lib = 'Lot de distribution'
AND t_type_stockage.don_lib NOT IN ('-', 'Document')
AND t_lot.xxx_sup_dat IS NULL
GROUP BY lot_sch_id) AS t_stockage
ON t_souche.xxx_id = t_stockage.lot_sch_id
LEFT JOIN (SELECT lot_sch_id, MAX(t_lot.xxx_cre_dat) AS recent_prod
FROM t_lot
JOIN t_donneedico AS t_type
ON t_type.xxx_id = lot_type
JOIN t_donneedico AS t_type_stockage
ON t_type_stockage.xxx_id = lot_type_stockage
WHERE t_type_stockage.don_lib NOT IN ('-', 'Document')
AND t_lot.xxx_sup_dat IS NULL
GROUP BY lot_sch_id) AS t_last_prod
ON t_souche.xxx_id = t_last_prod.lot_sch_id

LEFT JOIN (SELECT msc_sch_id, 
array_to_string(ARRAY_AGG(mil_numero), ';') AS nums_milieux
FROM t_milieu_souche
LEFT JOIN t_milieu
ON msc_mil_id = t_milieu.xxx_id
GROUP BY msc_sch_id) AS mediums
ON t_souche.xxx_id = mediums.msc_sch_id

LEFT JOIN t_donneedico AS t_atmosphere_incubation
ON sch_atmosphere_incubation = t_atmosphere_incubation.xxx_id

LEFT JOIN (SELECT xxx_id, MIN(an::numeric) AS an_historique
FROM (SELECT xxx_id, 
	  (regexp_matches(sch_historique, '(<- |^)([0-9]{4}),', 'g'))[2] AS an
FROM t_souche) AS regex
GROUP BY xxx_id) AS souche_histo
ON t_souche.xxx_id = souche_histo.xxx_id
