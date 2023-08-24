/* Creation of one temporary table per group/subgroup
Here is the list of Archaea (a small number compared to the number of bacterial strains in CIP) */
DROP TABLE IF EXISTS groupe8_archaea;

SELECT t_souche.xxx_id INTO groupe8_archaea FROM t_souche
JOIN groupe0
ON groupe0.xxx_id = t_souche.xxx_id
WHERE sch_denomination ~* 'Staphylothermus hellenicus|Halorubrum distributum|Halorubrum coriense|Natrialba magadii|Natrinema pallidum|Natrialba asiatica|Ignicoccus pacificus|Halomicrobium mukohataei|Natronomonas pharaonis|Halorubrum saccharovorum|Natronococcus amylolyticus|Haloarcula argentinensis|Natrinema pellirubrum|Halorubrum trapanicum|Natronococcus occultus|Pyrobaculum aerophilum|Halobacterium salinarum|Haloferax alexandrinus|Halorubrum terrestre|Halococcus hamelinensis|Thermococcus thioreducens|Natronorubrum bangense|Halorubrum lacusprofundi|Haloarcula sebkhae|Halococcus morrhuae|Halosimplex carlsbadense|Methanocaldococcus jannaschii|Thermococcus atlanticus|Halorubrum sodomense|Halococcus saccharolyticus|Halorubrum xinjiangense|Haloterrigena turkmenica|Natronobacterium gregoryi|Haloferax sulfurifontis|Natronorubrum tibetense|Haloferax lucentense|Thermococcus fumicolans|Halorubrum vacuolatum|Ignicoccus islandicus|Thermococcus aegaeus|Halococcus dombrowskii';
