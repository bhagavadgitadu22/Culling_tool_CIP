/* Creation of one temporary table per group/subgroup
Here is the list of pigment producers according to our phenotypic data */
DROP TABLE IF EXISTS groupe3_pigment;

SELECT groupe3.xxx_id
INTO groupe3_pigment FROM groupe3
JOIN t_souche ON t_souche.xxx_id = groupe3.xxx_id
WHERE ARRAY[62,63,67,68,325,330,332,1244,1266] && array_nums
OR LOWER(sch_proprietes) LIKE '%luminescent%'
OR (LOWER(sch_proprietes) LIKE '%pigment%'
AND LOWER(sch_proprietes) NOT LIKE '%non pigmented%');
