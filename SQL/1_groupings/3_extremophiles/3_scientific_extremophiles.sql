/* Extraction of the pH and NaCl values in the medium of each strain */
DROP TABLE IF EXISTS scientific_extremophiles;

SELECT t_souche.xxx_id, 
pH_bool, nacl_bool, ph_std::numeric, nacl_std::numeric, 
mediums.nums_milieux AS medium_std, other_mediums.nums_milieux AS other_mediums
INTO scientific_extremophiles
FROM t_souche

LEFT JOIN (SELECT msc_sch_id, 
t_milieu.mil_numero AS nums_milieux,
phs_milieux.pH_medium AS ph_std,
CASE WHEN phs_milieux.pH_medium::numeric<=5 OR phs_milieux.pH_medium::numeric>=9 THEN True ELSE False END AS pH_bool,
halo_milieux.perc_salt AS nacl_std,
CASE WHEN halo_milieux.perc_salt::numeric>8.8 THEN True ELSE False END AS nacl_bool
FROM t_milieu_souche
LEFT JOIN t_milieu
ON msc_mil_id = t_milieu.xxx_id
LEFT JOIN phs_milieux
ON phs_milieux.mil_numero = t_milieu.mil_numero
LEFT JOIN halo_milieux
ON halo_milieux.mil_numero = t_milieu.mil_numero
WHERE msc_standard IS True) AS mediums
ON t_souche.xxx_id = mediums.msc_sch_id

LEFT JOIN (SELECT msc_sch_id, 
array_to_string(ARRAY_AGG(DISTINCT t_milieu.mil_numero), ';') AS nums_milieux
FROM t_milieu_souche
LEFT JOIN t_milieu
ON msc_mil_id = t_milieu.xxx_id
WHERE msc_standard IS NOT True
GROUP BY msc_sch_id) AS other_mediums
ON t_souche.xxx_id = other_mediums.msc_sch_id

WHERE t_souche.xxx_id IN (SELECT xxx_id FROM last_version_souches_cip)
AND LOWER(sch_denomination) NOT LIKE '%pas de souche%'
AND LOWER(sch_denomination) NOT LIKE '%doublon%'
AND LOWER(sch_denomination) NOT LIKE '%distribuer%';
