/* Calculation of the metadata score of each strain in a temporary tables */
DROP TABLE IF EXISTS metrique_generale;

SELECT t_souche.xxx_id, sch_identifiant, sch_denomination,
LEAST(EXTRACT(YEAR FROM sch_dat_isolement), EXTRACT(YEAR FROM sch_dat_prelevement), an_historique) AS historical_value,
CASE 
	WHEN sch_catalogue IS True THEN 10
	ELSE 5
END AS status_wgs,
1 AS number_of_strains,
CASE WHEN length(REGEXP_REPLACE(
		REGEXP_REPLACE(sch_references_equi, '(CIP|CRBIP|WDCM|CARE)[^;]+', '', 'g'),
		';[;]+', ';'))>1 THEN 0
	ELSE 8
END AS exclusivity,
CASE 
	WHEN number_lots>=1 AND number_lots<10 THEN 2
	WHEN number_lots>=10 AND number_lots<100 THEN 6
	WHEN number_lots>=100 AND number_lots<500 THEN 8
	ELSE 0
END AS stock_distrib,
CASE 
	WHEN 2022-EXTRACT(YEAR FROM last_distrib)>5 THEN 2
	WHEN 2022-EXTRACT(YEAR FROM last_distrib)<5 THEN 4
	ELSE 0
END AS last_distrib,
CASE WHEN type_stockage='Stockage à +/- 80°C' THEN 2 ELSE 0 END AS minus_80,
CASE WHEN type_stockage='Stockage Azote' THEN 3 ELSE 0 END AS LN,
CASE WHEN type_stockage LIKE '%Stockage Lyophilisat%' 
	OR type_stockage LIKE '%Stockage Dessicat%' 
	OR type_stockage LIKE '%Stokage pente%' THEN 1 ELSE 0 END AS RT,
CASE WHEN sch_dat_isolement IS NOT NULL 
	OR sch_dat_prelevement IS NOT NULL THEN 8 ELSE 0 
END AS year, 
CASE WHEN sch_lieu IS NOT NULL AND t_lieu.don_lib != 'Unknown' THEN 8 ELSE 0 END AS country, 
CASE WHEN sch_isole_a_partir_de SIMILAR TO '%[A-Za-z]+%' 
	AND LOWER(sch_isole_a_partir_de) NOT SIMILAR TO '%(unknown|nan)%' 
THEN 8 ELSE 0 END as source,
year_last_commande, 
CASE 
	WHEN 2022-EXTRACT(YEAR FROM last_prod)<10 THEN 2
	ELSE 0
END AS viability,
(CASE WHEN sch_temps_culture IN ('30 D','1 M','21 D','15 D','10 D','8 jours','8 D','10-15 D','15 jours','5-10 D',
								'10 jours','7-10 D','20 jours','14 D','8-10 D','11 D','6-8 D','12 D','2 W','9 D',
								'2-3 W','7-8 D','12-15 D','3-4 W','20 D','1-2 M','10-12 D','3-10 D','4 W','1-2 W',
								'11 jours','21-30 D','15-20 D','18 D','4-14 D','4-10 D','5-8 D','25 D','41 D',
								'9-10 D','5-6 W','8 JOURS','19 D','16 D','7-13 D','15  jours','13 D','24-48 D',
								'24-72 D','11 Jours','20-30 D','10-17 D','14 jours','8 joursS','7-12 D','6 W')
	THEN -2 ELSE 0 END)+
(CASE WHEN sch_atmosphere_incubation IS NOT NULL AND t_atmosphere_incubation.don_lib != 'Aerobic' THEN -2 ELSE 0 END)+
(CASE WHEN sch_temperature_incubation != '0' AND sch_temperature_incubation ~ '^\d+ ?'
	AND (REPLACE(sch_temperature_incubation, ' ', '')::integer<30 OR REPLACE(sch_temperature_incubation, ' ', '')::integer>40)
	THEN -2 ELSE 0 END)+
(CASE WHEN nums_milieux IS NULL OR nums_milieux LIKE '%72%' THEN 0 ELSE -2 END)+8 AS easiness_replenishment,
CASE WHEN sch_references_equi LIKE '%WDCM%' THEN 3 ELSE 0 END AS wdcm

INTO metrique_generale
FROM t_souche
LEFT JOIN (SELECT lot_sch_id, SUM(lot_qte_stock) AS number_lots, MAX(t_lot.xxx_cre_dat) AS last_distrib,
ARRAY_TO_STRING(ARRAY_AGG(DISTINCT t_type_stockage.don_lib), ';') AS type_stockage
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
LEFT JOIN (SELECT lot_sch_id, MAX(t_lot.xxx_cre_dat) AS last_prod
FROM t_lot
JOIN t_donneedico AS t_type
ON t_type.xxx_id = lot_type
JOIN t_donneedico AS t_type_stockage
ON t_type_stockage.xxx_id = lot_type_stockage
WHERE t_type_stockage.don_lib NOT IN ('-', 'Document')
AND t_lot.xxx_sup_dat IS NULL
GROUP BY lot_sch_id) AS t_last_prod
ON t_souche.xxx_id = t_last_prod.lot_sch_id

LEFT JOIN(SELECT lot_sch_id, MAX(EXTRACT(YEAR FROM cmd_dat)) AS year_last_commande
FROM t_lot
JOIN t_article_commande
ON acm_lot_id = t_lot.xxx_id
JOIN t_commande
ON t_commande.xxx_id = acm_cmd_id
GROUP BY lot_sch_id) AS commandes
ON t_souche.xxx_id = commandes.lot_sch_id

LEFT JOIN (SELECT msc_sch_id, 
array_to_string(ARRAY_AGG(mil_numero), ';') AS nums_milieux
FROM t_milieu_souche
LEFT JOIN t_milieu
ON msc_mil_id = t_milieu.xxx_id
GROUP BY msc_sch_id) AS mediums
ON t_souche.xxx_id = mediums.msc_sch_id

LEFT JOIN t_donneedico AS t_lieu
ON sch_lieu = t_lieu.xxx_id
LEFT JOIN t_donneedico AS t_atmosphere_incubation
ON sch_atmosphere_incubation = t_atmosphere_incubation.xxx_id

LEFT JOIN (SELECT xxx_id, MIN(an::numeric) AS an_historique
FROM (SELECT xxx_id, 
	  (regexp_matches(sch_historique, '(<- |^)([0-9]{4}),', 'g'))[2] AS an
FROM t_souche) AS regex
GROUP BY xxx_id) AS souche_histo
ON t_souche.xxx_id = souche_histo.xxx_id

WHERE t_souche.xxx_id IN (SELECT xxx_id FROM last_version_souches_cip)
AND LOWER(sch_denomination) NOT LIKE '%pas de souche%'
AND LOWER(sch_denomination) NOT LIKE '%doublon%'
AND LOWER(sch_denomination) NOT LIKE '%distribuer%';
	