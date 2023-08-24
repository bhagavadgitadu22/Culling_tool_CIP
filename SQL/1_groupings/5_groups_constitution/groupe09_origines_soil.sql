/* Creation of one temporary table per group/subgroup
Here is the list of strains isolated from the soil based on the field origine of our LIMS */
DROP TABLE IF EXISTS groupe9_origines_soil;

SELECT t_souche.xxx_id INTO groupe9_origines_soil FROM t_souche
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE LOWER(sch_isole_a_partir_de) SIMILAR TO 'soils?[ ,]{1}%'
OR LOWER(sch_isole_a_partir_de) SIMILAR TO '%[ ,]{1}soils?'
 OR LOWER(sch_isole_a_partir_de) SIMILAR TO '%[ ,]{1}soils?[ ,]{1}%'
OR LOWER(sch_isole_a_partir_de) SIMILAR TO 'soils?';
