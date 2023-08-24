/* List of piezophiles according to the literature */
DROP TABLE IF EXISTS piezophiles;

CREATE TABLE piezophiles (
	species varchar(75) NOT NULL DEFAULT '',
	reason varchar(200) NOT NULL DEFAULT ''
);

INSERT INTO piezophiles (species, reason) VALUES
('Moritella japonica','Psychro-piezophilic bacteria (10-50 MPa, <15°C)'),
('Colwellia hadaliensis','Psychro-hyperpiezophilic bacteria (>50 MPa, <15°C)'),
('Colwellia piezophila','Psychro-hyperpiezophilic bacteria (>50 MPa, <15°C)'),
('Demacoccus abyssi','Meso-piezophilic bacteria (10-50 MPa, <15°C)'),
('Desulfovibrio hydrothermalis','Meso-piezophilic bacteria (10-50 MPa, <15°C)'),
('Desulfovibrio profundus','Meso-piezophilic bacteria (10-50 MPa, <15°C)'),
('Marinitoga piezophila','Thermo-piezophilic bacteria (10-50 MPa, 45-80°C)'),
('Moritella abyssi','Psychro-piezophilic bacteria (10-50 MPa, <15°C)'),
('Moritella profunda','Psychro-piezophilic bacteria (10-50 MPa, <15°C)'),
('Photobacterium profundum','Psychro-piezophilic bacteria (10-50 MPa, <15°C)'),
('Piezobacter thermophilus','Thermo-piezophilic bacteria (10-50 MPa, 45-80°C)'),
('Psychromonas hadalis','Psychro-hyperpiezophilic bacteria (>50 MPa, <15°C)'),
('Psychromonas kaikoae','Psychro-piezophilic bacteria (10-50 MPa, <15°C)'),
('Psychromonas profunda','Psychro-piezophilic bacteria (10-50 MPa, <15°C)'),
('Shewanella benthica','Psychro-piezophilic bacteria (10-50 MPa, <15°C), Psychro-hyperpiezophilic bacteria (>50 MPa, <15°C)'),
('Thioprofundum lithotrophica','Thermo-piezophilic bacteria (10-50 MPa, 45-80°C)'),
('Moritella yayanosii','Psychro-piezophilic bacteria (10-50 MPa, <15°C)')
