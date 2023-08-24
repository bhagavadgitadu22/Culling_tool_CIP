/* List of terms associated to extremophily to catch potential extremophilic species not identified by literature or analytic data */
DROP TABLE IF EXISTS lexic_extremes;

CREATE TABLE lexic_extremes (
	word varchar(75) NOT NULL DEFAULT '',
	likeliness varchar(10) NOT NULL DEFAULT ''
);

INSERT INTO lexic_extremes (word, likeliness) VALUES
('acid','yes'),
('acidic','yes'),
('alkaline','yes'),
('altitude','no'),
('anaerobic','no'),
('anoxic','yes'),
('antarctic','yes'),
('antarctica','yes'),
('arctic','yes'),
('arid','yes'),
('atacama','yes'),
('biofilm','no'),
('biofilms','no'),
('brine','no'),
('cave','yes'),
('cold','no'),
('deep','yes'),
('dehydrated','yes'),
('depth','no'),
('desert','yes'),
('desiccation','yes'),
('dry','no'),
('dry-heated','yes'),
('etuve','yes'),
('frozen','yes'),
('fumarole','yes'),
('geothermal','yes'),
('glacier','yes'),
('high','no'),
('highly','no'),
('hot','no'),
('hotspring','yes'),
('hydrothermal','yes'),
('hypermagnesian','yes'),
('hypersaline','yes'),
('ice','yes'),
('irradiated','yes'),
('light','no'),
('manure','no'),
('mariana','no'),
('mine','yes'),
('nuclear','yes'),
('ophiolite','yes'),
('permafrost','yes'),
('ph','no'),
('polar','yes'),
('radiotion','yes'),
('saline','no'),
('salinity','no'),
('salt','no'),
('salted','no'),
('salty','no'),
('serpentinite','yes'),
('soda','yes'),
('space','yes'),
('subantarctic','yes'),
('temperature','no'),
('trench','no'),
('vent','no'),
('volcan','yes'),
('volcano','yes'),
('warm','no'),
('yellowstone','no');
