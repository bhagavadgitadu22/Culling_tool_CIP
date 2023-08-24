/* Calculation of the number of strains per species among the CIP strains under study to make a Krona plot */
SELECT COUNT(*),
(string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[1] AS genus,
(string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[2] AS species,
CASE
	WHEN (string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[3] SIMILAR TO '[a-z]+' 
	AND (string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[3] NOT IN ('la', 'pb', 'unknown', 'pas', 'doublon', 'group', 'non')
	THEN (string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[3]
	ELSE ''
END AS subspecies
FROM t_souche
LEFT JOIN t_collection
ON t_collection.xxx_id = sch_col_id

WHERE t_souche.xxx_id IN (SELECT xxx_id FROM groupe0)
GROUP BY (string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[1], 
	(string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[2], CASE
	WHEN (string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[3] SIMILAR TO '[a-z]+' 
	AND (string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[3] NOT IN ('la', 'pb', 'unknown', 'pas', 'doublon', 'group', 'non')
	THEN (string_to_array(btrim(REPLACE(sch_denomination, 'Candidatus', ''), ' "'''), ' '))[3]
	ELSE '' END;
