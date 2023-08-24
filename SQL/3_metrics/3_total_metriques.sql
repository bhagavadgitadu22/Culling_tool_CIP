/* Calculation of the global score of a group based on the scores of each strain calculated before */
SELECT COUNT(*), 

CASE WHEN (COUNT(1) FILTER (WHERE historical_value<1950))*100/COUNT(*) > 35 THEN 6 ELSE 0 END AS before_1950,
CASE WHEN (COUNT(1) FILTER (WHERE historical_value>2014))*100/COUNT(*) > 35 THEN 9 ELSE 0 END AS after_2014,
ROUND(SUM(status_wgs)/COUNT(*)::numeric,2) AS status_wgs,
CASE 
	WHEN COUNT(*)<10 THEN 5 
	WHEN COUNT(*)<100 THEN 2
	ELSE 0
END AS number_of_strains,
ROUND(SUM(exclusivity)/COUNT(*)::numeric,2) AS exclusivity,
ROUND(SUM(stock_distrib)/COUNT(*)::numeric,2) AS number_lots_distribution,
ROUND(SUM(last_distrib)/COUNT(*)::numeric,2) AS last_distribution_produced,
ROUND((SUM(minus_80)+SUM(LN)+SUM(RT))/COUNT(*)::numeric,2) AS type_storage,
ROUND(SUM(year)/COUNT(*)::numeric,2) AS year_present,
ROUND(SUM(country)/COUNT(*)::numeric,2) AS country_present,
ROUND(SUM(source)/COUNT(*)::numeric,2) AS source_present,
CASE 
	WHEN (COUNT(1) FILTER (WHERE 2022-year_last_commande<5))*100/COUNT(*) > 50 THEN 3
	WHEN (COUNT(1) FILTER (WHERE 2022-year_last_commande<5))*100/COUNT(*) >= 10 THEN 2
	WHEN (COUNT(1) FILTER (WHERE 2022-year_last_commande<5))*100/COUNT(*) >= 1 THEN 1
	ELSE 0
END AS year_last_commande,
ROUND(SUM(viability)/COUNT(*)::numeric,2) AS viability,
ROUND(SUM(easiness_replenishment)/COUNT(*)::numeric,2) AS easiness_replenishment,
ROUND(SUM(wdcm)/COUNT(*)::numeric,2) AS wdcm,

ROUND(SUM(api)/COUNT(*)::numeric,2) AS api,
ROUND(SUM(wgs)/COUNT(*)::numeric,2) AS wgs,
ROUND(SUM(seq)/COUNT(*)::numeric,2) AS sequences,
ROUND(SUM(ant)/COUNT(*)::numeric,2) AS antibiograms,
ROUND(SUM(maldi)/COUNT(*)::numeric,2) AS maldi

FROM t_souche
JOIN metrique_generale
ON t_souche.xxx_id = metrique_generale.xxx_id
JOIN metrique_scientifique
ON t_souche.xxx_id = metrique_scientifique.xxx_id
