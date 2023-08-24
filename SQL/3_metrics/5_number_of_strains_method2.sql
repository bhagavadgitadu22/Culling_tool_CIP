/* Number of strains in the group considered (method 2) */
SELECT COUNT(*)
FROM t_souche
JOIN metrique_generale
ON t_souche.xxx_id = metrique_generale.xxx_id
JOIN metrique_scientifique
ON t_souche.xxx_id = metrique_scientifique.xxx_id
