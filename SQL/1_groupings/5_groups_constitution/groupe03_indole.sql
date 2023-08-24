/* Creation of one temporary table per group/subgroup
Here is the list of indole producers according to our phenotypic data */
DROP TABLE IF EXISTS groupe3_indole;

SELECT groupe3.xxx_id
INTO groupe3_indole FROM groupe3 
JOIN t_souche ON t_souche.xxx_id = groupe3.xxx_id
WHERE ARRAY[441,444,1019,1222] && array_nums;
