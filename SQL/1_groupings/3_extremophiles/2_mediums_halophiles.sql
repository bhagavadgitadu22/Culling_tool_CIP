/* Extraction of the NaCl concentration from the composition of CIP media */
DROP TABLE IF EXISTS halo_milieux;

SELECT mil_numero, 
CASE 
	WHEN LOWER(cp_B.don_lib)='l' THEN (cp_A.lmc_qte*100/(cp_B.lmc_qte*1000))::integer 
	WHEN LOWER(cp_B.don_lib)='ml' THEN (cp_A.lmc_qte*100/cp_B.lmc_qte)::integer 
	ELSE (cp_A.lmc_qte/10)::integer
END AS perc_salt,
cp_A.cmp_designation_en AS name_nacl, cp_A.lmc_qte AS pds_nacl, 
cp_A.don_lib As unite_nacl, cp_A.cmp_com AS com_nacl,
cp_B.cmp_designation_en AS name_eau, cp_B.lmc_qte AS pds_eau, 
cp_B.don_lib As unite_eau, cp_B.cmp_com AS com_eau,
mil_designation_en, mil_commentaire, mil_commentaire_compo
INTO halo_milieux
FROM t_milieu

JOIN (SELECT * FROM t_milieu_composition
LEFT JOIN t_donneedico
ON t_donneedico.xxx_id = lmc_unite
LEFT JOIN t_composition
ON lmc_cmp_id = t_composition.xxx_id
WHERE cmp_designation_en = 'Sodium chloride') AS cp_A
ON cp_A.lmc_mil_id = t_milieu.xxx_id

LEFT JOIN (SELECT * FROM t_milieu_composition
LEFT JOIN t_donneedico
ON t_donneedico.xxx_id = lmc_unite
LEFT JOIN t_composition
ON lmc_cmp_id = t_composition.xxx_id
WHERE cmp_designation_en = 'Ultra pure water make up to') AS cp_B
ON cp_B.lmc_mil_id = t_milieu.xxx_id

WHERE mil_clg_id = 401
AND t_milieu.xxx_sup_dat IS NULL
AND cp_A.don_lib = 'g'
ORDER BY cp_A.lmc_qte DESC;
