/* Creation of one temporary table per group/subgroup
Here is the list of critical pathogens according to WHO (World Health Organization) */
DROP TABLE IF EXISTS groupe1_who;

SELECT t_souche.xxx_id INTO groupe1_who FROM t_souche
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE sch_denomination SIMILAR TO '%(Acinetobacter baumannii|Pseudomonas aeruginosa|Enterococcus faecium|Staphylococcus aureus|Helicobacter pylori|Campylobacter|Salmonella|Neisseria gonorrhoeae|Streptococcus pneumoniae|Haemophilus influenzae|Shigella|Biostraticola|Budvicia|Leminorella|Pragia|Buttiauxella|Cedecea|Citrobacter|Cronobacter|Enterobacter|Escherichia|Franconibacter|Klebsiella|Kluyvera|Kosakonia|Leclercia|Lelliottia|Metakosakonia|Plesiomonas|Pluralibacter|Pseudescherichia|Pseudocitrobacter|Raoultella|Salmonella|Shigella|Shimwellia|Trabulsiella|Yokenella|Erwinia|Pantoea|Tatumella|Edwardsiella|Hafnia|Obesumbacterium|Arsenophonus|Cosenzaea|Moellerella|Morganella|Photorhabdus|Proteus|Providencia|Xenorhabdus|Brenneria|Dickeya|Pectobacterium|Samsonia|Coetzeea|Thorsellia|Ewingella|Rahnella|Rouxiella|Serratia|Yersinia)%';
