/* Joining of all the temporary tables created before to decide the extremophilic status of each strain */
DROP TABLE IF EXISTS crossing_extremophiles;

SELECT t_souche.xxx_id, t_souche.sch_identifiant,
CASE WHEN ph_bool IS True 
	 OR nacl_bool IS True
	 OR halophiles.species IS NOT NULL
	 OR piezophiles.species IS NOT NULL
	 OR psychrophiles.species IS NOT NULL
	 OR extremophiles_atcc.species IS NOT NULL
	 OR ph_bool IS True
	 OR nacl_bool IS True
	 OR (sch_temperature_incubation != '0' AND sch_temperature_incubation SIMILAR TO '[0-9 ]+'
			AND (REPLACE(REPLACE(sch_temperature_incubation, ' ', ''), '°C', '')::integer<20 OR REPLACE(REPLACE(sch_temperature_incubation, ' ', ''), '°C', '')::integer>45))
	 THEN TRUE ELSE FALSE
END AS certainty,
t_souche.sch_denomination, t_souche.sch_synonymes, t_basonyme.svl_valeur,

ph_bool, nacl_bool, medium_std, ph_std, nacl_std, other_mediums,

ARRAY_TO_STRING(ARRAY_AGG(lexic_extremes.word), ', ') AS extremophile_lexic, 
CASE 
	WHEN 'yes'=ANY(ARRAY_AGG(lexic_extremes.likeliness)) THEN 'yes'
	ELSE 'no'
END AS extremophile_likeliness,
piezophiles.species AS piezophiles_literature, piezophiles.reason AS reason_piezo,
halophiles.species AS halophiles_literature, psychrophiles.species AS psychrophiles_literature, 

t_souche.sch_historique,
LEAST(EXTRACT(YEAR FROM t_souche.sch_dat_isolement), EXTRACT(YEAR FROM sch_dat_prelevement), an_historique) AS historical_value,
t_lieu.don_lib AS lieu, t_souche.sch_lieu_precis,
t_origine.don_lib AS origine, t_souche.sch_isole_a_partir_de,

t_souche.sch_temps_culture, t_atmosphere_incubation.don_lib AS sch_atmosphere_incubation, t_souche.sch_temperature_incubation,
(CASE WHEN t_souche.sch_temps_culture IN ('30 D','1 M','21 D','15 D','10 D','8 jours','8 D','10-15 D','15 jours','5-10 D',
								'10 jours','7-10 D','20 jours','14 D','8-10 D','11 D','6-8 D','12 D','2 W','9 D',
								'2-3 W','7-8 D','12-15 D','3-4 W','20 D','1-2 M','10-12 D','3-10 D','4 W','1-2 W',
								'11 jours','21-30 D','15-20 D','18 D','4-14 D','4-10 D','5-8 D','25 D','41 D',
								'9-10 D','5-6 W','8 JOURS','19 D','16 D','7-13 D','15  jours','13 D','24-48 D',
								'24-72 D','11 Jours','20-30 D','10-17 D','14 jours','8 joursS','7-12 D','6 W')
	THEN -2 ELSE 0 END)+
(CASE WHEN t_souche.sch_atmosphere_incubation IS NOT NULL AND t_atmosphere_incubation.don_lib != 'Aerobic' THEN -2 ELSE 0 END)+
(CASE WHEN t_souche.sch_temperature_incubation != '0' AND t_souche.sch_temperature_incubation ~ '^\d+ ?'
	AND (REPLACE(t_souche.sch_temperature_incubation, ' ', '')::integer<30 OR REPLACE(t_souche.sch_temperature_incubation, ' ', '')::integer>40)
	THEN -2 ELSE 0 END)+
(CASE WHEN medium_std LIKE '%72%' OR other_mediums LIKE '%72%'THEN 0 ELSE -2 END)+8 AS easiness_replenishment
INTO crossing_extremophiles
FROM t_souche

LEFT JOIN t_donneedico AS t_lieu
ON t_lieu.xxx_id = sch_lieu
LEFT JOIN t_donneedico AS t_origine
ON t_origine.xxx_id = sch_origine
LEFT JOIN t_donneedico AS t_atmosphere_incubation
ON sch_atmosphere_incubation = t_atmosphere_incubation.xxx_id
LEFT JOIN (SELECT xxx_id, MIN(an::numeric) AS an_historique
FROM (SELECT xxx_id, 
	  (regexp_matches(sch_historique, '(<- |^)([0-9]{4}),', 'g'))[2] AS an
FROM t_souche) AS regex
GROUP BY xxx_id) AS souche_histo
ON t_souche.xxx_id = souche_histo.xxx_id
LEFT JOIN (SELECT * FROM t_string_val AS t_basonyme
JOIN t_attribut AS t_att_basonyme
ON t_basonyme.svl_att_id = t_att_basonyme.xxx_id
AND t_att_basonyme.att_nom = 'Basonyme') AS t_basonyme
ON t_basonyme.svl_entite_id = t_souche.xxx_id

LEFT JOIN scientific_extremophiles
ON t_souche.xxx_id = scientific_extremophiles.xxx_id
LEFT JOIN lexic_extremes
ON LOWER(t_souche.sch_lieu_precis) SIMILAR TO CONCAT('%[^a-zA-Z]', lexic_extremes.word, '[^a-zA-Z]%')
OR ((t_origine.don_lib IS NULL OR t_origine.don_lib = 'Environment') AND LOWER(sch_isole_a_partir_de) SIMILAR TO CONCAT('%[^a-zA-Z]', lexic_extremes.word, '[^a-zA-Z]%'))

LEFT JOIN halophiles
ON t_souche.sch_denomination LIKE CONCAT('%', halophiles.species, '%')
OR t_souche.sch_synonymes LIKE CONCAT('%', halophiles.species, '%')
OR t_basonyme.svl_valeur LIKE CONCAT('%', halophiles.species, '%')
LEFT JOIN piezophiles
ON t_souche.sch_denomination LIKE CONCAT('%', piezophiles.species, '%')
OR t_souche.sch_synonymes LIKE CONCAT('%', piezophiles.species, '%')
OR t_basonyme.svl_valeur LIKE CONCAT('%', piezophiles.species, '%')
LEFT JOIN psychrophiles
ON t_souche.sch_denomination LIKE CONCAT('%', psychrophiles.species, '%')
OR t_souche.sch_synonymes LIKE CONCAT('%', psychrophiles.species, '%')
OR t_basonyme.svl_valeur LIKE CONCAT('%', psychrophiles.species, '%')

WHERE t_souche.xxx_id IN (SELECT xxx_id FROM last_version_souches_cip)
AND LOWER(t_souche.sch_denomination) NOT LIKE '%pas de souche%'
AND LOWER(t_souche.sch_denomination) NOT LIKE '%doublon%'
AND LOWER(t_souche.sch_denomination) NOT LIKE '%distribuer%'

AND (ph_bool IS True 
	 OR nacl_bool IS True
	 OR halophiles.species IS NOT NULL
	 OR piezophiles.species IS NOT NULL
	 OR psychrophiles.species IS NOT NULL
	 OR (sch_temperature_incubation != '0' AND sch_temperature_incubation SIMILAR TO '[0-9 ]+'
			AND (REPLACE(REPLACE(sch_temperature_incubation, ' ', ''), '°C', '')::integer<20 OR REPLACE(REPLACE(sch_temperature_incubation, ' ', ''), '°C', '')::integer>45))
	 OR t_lieu.don_lib IN ('Antarctica', 'Arctic', 'Space') 
	 OR lexic_extremes.word IS NOT NULL
)
GROUP BY t_souche.xxx_id, t_souche.sch_identifiant,
CASE WHEN ph_bool IS True 
	 OR nacl_bool IS True
	 OR halophiles.species IS NOT NULL
	 OR piezophiles.species IS NOT NULL
	 OR psychrophiles.species IS NOT NULL
	 OR ph_bool IS True
	 OR nacl_bool IS True
	 OR (sch_temperature_incubation != '0' AND sch_temperature_incubation SIMILAR TO '[0-9 ]+'
			AND (REPLACE(REPLACE(sch_temperature_incubation, ' ', ''), '°C', '')::integer<20 OR REPLACE(REPLACE(sch_temperature_incubation, ' ', ''), '°C', '')::integer>45))
	 THEN TRUE ELSE FALSE
END,
t_souche.sch_denomination, t_souche.sch_synonymes, t_basonyme.svl_valeur,
ph_bool, nacl_bool, medium_std, ph_std, nacl_std, other_mediums,
piezophiles.species, piezophiles.reason,
halophiles.species, psychrophiles.species, 
t_souche.sch_historique,
LEAST(EXTRACT(YEAR FROM t_souche.sch_dat_isolement), EXTRACT(YEAR FROM sch_dat_prelevement), an_historique),
t_lieu.don_lib, t_souche.sch_lieu_precis, t_origine.don_lib, t_souche.sch_isole_a_partir_de,
t_souche.sch_temps_culture, t_atmosphere_incubation.don_lib, t_souche.sch_temperature_incubation,
(CASE WHEN t_souche.sch_temps_culture IN ('30 D','1 M','21 D','15 D','10 D','8 jours','8 D','10-15 D','15 jours','5-10 D',
								'10 jours','7-10 D','20 jours','14 D','8-10 D','11 D','6-8 D','12 D','2 W','9 D',
								'2-3 W','7-8 D','12-15 D','3-4 W','20 D','1-2 M','10-12 D','3-10 D','4 W','1-2 W',
								'11 jours','21-30 D','15-20 D','18 D','4-14 D','4-10 D','5-8 D','25 D','41 D',
								'9-10 D','5-6 W','8 JOURS','19 D','16 D','7-13 D','15  jours','13 D','24-48 D',
								'24-72 D','11 Jours','20-30 D','10-17 D','14 jours','8 joursS','7-12 D','6 W')
	THEN -2 ELSE 0 END)+
(CASE WHEN t_souche.sch_atmosphere_incubation IS NOT NULL AND t_atmosphere_incubation.don_lib != 'Aerobic' THEN -2 ELSE 0 END)+
(CASE WHEN t_souche.sch_temperature_incubation != '0' AND t_souche.sch_temperature_incubation ~ '^\d+ ?'
	AND (REPLACE(t_souche.sch_temperature_incubation, ' ', '')::integer<30 OR REPLACE(t_souche.sch_temperature_incubation, ' ', '')::integer>40)
	THEN -2 ELSE 0 END)+
(CASE WHEN medium_std LIKE '%72%' OR other_mediums LIKE '%72%'THEN 0 ELSE -2 END)+8;
