/* Extraction of the pH value from the free text associated to each medium used in CIP */
DROP TABLE IF EXISTS phs_milieux;

SELECT t_milieu.xxx_id, mil_numero, 
REPLACE(REPLACE((regexp_match(LOWER(mil_commentaire), 'ph ?(to|final)?[ :]*([0-9. ,]{1,5})'))[2], ' ', ''), ',', '.')::numeric AS pH_medium
INTO phs_milieux
FROM t_milieu

WHERE mil_clg_id = 401
AND t_milieu.xxx_sup_dat IS NULL
AND LOWER(mil_commentaire) LIKE '%ph%';
