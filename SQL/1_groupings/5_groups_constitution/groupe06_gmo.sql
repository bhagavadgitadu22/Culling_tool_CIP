/* Creation of one temporary table per group/subgroup
Here is the list of GMO (Genetically Modified Organisms) according to the field GMO of our LIMS */
DROP TABLE IF EXISTS groupe6_gmo;

SELECT t_souche.xxx_id INTO groupe6_gmo FROM t_souche
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE sch_ogm IS True;
