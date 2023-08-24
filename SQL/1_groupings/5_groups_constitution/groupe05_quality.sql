/* Creation of one temporary table per group/subgroup
Here is the list of strains belonging to WDCM list according to the equivalent references of our LIMS */
DROP TABLE IF EXISTS groupe5_quality;

SELECT t_souche.xxx_id INTO groupe5_quality FROM t_souche
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE substring(sch_references_equi, 'WDCM ?([0-9]+)') != '';
