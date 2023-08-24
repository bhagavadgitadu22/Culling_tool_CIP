/* List of strains already sequenced by CIP */
DROP TABLE IF EXISTS strains_sequenced_cip;

CREATE TABLE strains_sequenced_cip (
	id_brclims varchar(255)
);

INSERT INTO strains_sequenced_cip (id_brclims) VALUES
('CIP 109753'), 
('CIP 108840'), 
('CIP 107217'), 
('CIP 110838'), 
('CIP 110848'), 
('CIP 110849'), 
('CIP 110857'), 
('CIP 110952'), 
('CIP 111187'), 
('CIP 78.42');
