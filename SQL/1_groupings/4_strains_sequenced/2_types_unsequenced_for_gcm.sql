/* List of type strains never sequenced anywhere according to gcType (January 2023) */
DROP TABLE IF EXISTS types_unsequenced;

CREATE TABLE types_unsequenced (
	species varchar(75) NOT NULL DEFAULT ''
);

INSERT INTO types_unsequenced (species) VALUES
('Abrizicola oligotrophica'),
('Absiella argi'),
('Abyssivirga alkaniphila'),
('Acetivibrio ethanolgignens'),
('Acetobacter musti'),
('Acetobacter suratthaniensis'),
('Acetobacter thailandicus'),
('Acetobacterium carbinolicum'),
('Acetobacterium fimetarium'),
('Acetobacterium malicum'),
('Acetofilamentum rigidum'),
('Acetothermus paucivorans'),
('Acholeplasma brassicae'),
('Acholeplasma cavigenitalium'),
('Acholeplasma parvum'),
('Acholeplasma pleciae'),
('Acholeplasma vituli'),
('Achromobacter sp.'),
('Acidibacter ferrireducens'),
('Acidicaldus organivorans'),
('Acidicapsa acidiphila'),
('Acidicapsa borealis'),
('Acidicapsa ferrireducens'),
('Acidilobus aceticus'),
('Acidiphilium cryptum'),
('Acidiphilium organovorum'),
('Acidipropionibacterium damnosum'),
('Acidipropionibacterium microaerophilum'),
('Acidipropionibacterium olivae'),
('Acidisoma sibiricum'),
('Acidisoma tundrae'),
('Acidocella aluminiidurans'),
('Acinetobacter nectaris'),
('Acinetobacter septicus'),
('Actibacter haliotis'),
('Actibacter sediminis'),
('Actinoallomurus acaciae'),
('Actinoallomurus acanthiterrae'),
('Actinoallomurus amamiensis'),
('Actinoallomurus caesius'),
('Actinoallomurus coprocola'),
('Actinoallomurus fulvus'),
('Actinoallomurus iriomotensis'),
('Actinoallomurus luridus'),
('Actinoallomurus yoronensis'),
('Actinobacillus arthritidis'),
('Actinobacillus delphinicola'),
('Actinobacillus equuli subsp. haemolyticus'),
('Actinobacillus hominis'),
('Actinobacillus scotiae'),
('Actinobaculum massiliense'),
('Actinocorallia lasiicapitis'),
('Actinokineospora acnipugnans'),
('Actinokineospora cibodasensis'),
('Actinokineospora riparia'),
('Actinomadura adrarensis'),
('Actinomadura alkaliterrae'),
('Actinomadura apis'),
('Actinomadura hankyongensis'),
('Actinomadura jiaoheensis'),
('Actinomadura lepetitiana'),
('Actinomadura rhizosphaerae'),
('Actinomadura scrupuli'),
('Actinomadura sediminis'),
('Actinomadura xylanilytica'),
('Actinomyces catuli'),
('Actinomyces europaeus'),
('Actinomyces graevenitzii'),
('Actinomyces hominis'),
('Actinomycetospora callitridis'),
('Actinomycetospora iriomotensis'),
('Actinomycetospora rishiriensis'),
('Actinophytocola burenkhanensis'),
('Actinophytocola corallina'),
('Actinophytocola gilvus'),
('Actinophytocola sediminis'),
('Actinophytocola timorensis'),
('Adhaeribacter aerophilus'),
('Aeromonas hydrophila subsp. ranae'),
('Aeromonas rivipollensis'),
('Agromyces archimandritae'),
('Algibacter psychrophilus'),
('Algicola bacteriolytica'),
('Alicyclobacillus tolerans'),
('Alkalilactibacillus ikkensis'),
('Alkalilimnicola halodurans'),
('Alkalimonas collagenimarina'),
('Alkalimonas delamerensis'),
('Alkalinema pantanalense'),
('Alkaliphilus crotonatoxidans'),
('Alkaliphilus serpentinus'),
('Altererythrobacter rubellus'),
('Amniculibacterium aquaticum'),
('Amorphus orientalis'),
('Amorphus suaedae'),
('Amphibacillus tropicus'),
('Amycolatopsis thermophila'),
('Amycolatopsis xuchangensis'),
('Amylibacter lutimaris'),
('Ancylobacter plantiphilus'),
('Aquamicrobium aestuarii'),
('Aquamicrobium terrae'),
('Aquaspirillum arcticum'),
('Aquaspirillum putridiconchylium'),
('Aquaspirillum soli'),
('Arcanobacterium wilhelmae'),
('Archaeoglobus infectus'),
('Archangium disciforme'),
('Archangium minus'),
('Archangium violaceum'),
('Arcicella aquatica'),
('Arcicella rigui'),
('Arthrobacter alkaliphilus'),
('Ascidiimonas aurantiaca'),
('Asinibacterium lactis'),
('Asprobacter aquaticus'),
('Asteroleplasma anaerobium'),
('Asticcacaulis solisilvae'),
('Atopobium deltae'),
('Azospirillum largimobile'),
('Bacillus composti'),
('Bacillus crescens'),
('Bacillus dakarensis'),
('Bacillus decisifrondis'),
('Bacillus luteus'),
('Bacillus malikii'),
('Bacillus maritimus'),
('Bacillus spongiae'),
('Bacillus stamsii'),
('Bacillus stratosphericus'),
('Bacteroides polypragmatus'),
('Belnapia soli'),
('Blautia stercoris'),
('Bombilactobacillus folatiphilus'),
('Bombilactobacillus thymidiniphilus'),
('Bradyrhizobium americanum'),
('Brevibacillus ginsengisoli'),
('Brevibacillus halotolerans'),
('Brevibacillus levickii'),
('Brevibacillus limnophilus'),
('Breznakia pachnodae'),
('Brochothrix campestris'),
('Brucella ceti'),
('Bythopirellula goksoeyrii'),
('Caloramator viterbiensis'),
('Caloribacterium cisternae'),
('Calorithrix insularis'),
('Caminibacter hydrogeniphilus'),
('Caminibacter profundus'),
('Carboxylicivirga taeanensis'),
('Celeribacter naphthalenivorans'),
('Cellulomonas citrea'),
('Chioneia algoris'),
('Chioneia brumae'),
('Chioneia frigida'),
('Chioneia hiemis'),
('Chitinibacter alvei'),
('Chlorobium clathratiforme'),
('Chlorobium phaeovibrioides'),
('Chondromyces apiculatus'),
('Chondromyces catenulatus'),
('Chondromyces crocatus'),
('Chondromyces lanuginosus'),
('Chondromyces pediculatus'),
('Chondromyces robustus'),
('Chromatium weissei'),
('Chryseobacterium lecithinasegens'),
('Chryseobacterium marinum'),
('Citreitalea marina'),
('Citricoccus lacusdiani'),
('Citrobacter bitternis'),
('Citrobacter cronae'),
('Citrobacter farmeri'),
('Citrobacter gillenii'),
('Clostridium composti'),
('Clostridium facile'),
('Clostridium quinii'),
('Clostridium schirmacherense'),
('Cohnella phaseoli'),
('Cohnella rhizosphaerae'),
('Cohnella saccharovorans'),
('Cohnella terrae'),
('Collimonas silvisoli'),
('Constrictibacter antarcticus'),
('Corynebacterium guangdongense'),
('Cribrihabitans neustonicus'),
('Cribrihabitans pelagius'),
('Crinalium epipsammum'),
('Deinococcus altitudinis'),
('Deinococcus aluminii'),
('Deinococcus carri'),
('Deinococcus citri'),
('Deinococcus claudionis'),
('Dermabacter jinjuensis'),
('Desulfofundulus thermobenzoicus'),
('Desulfogranum aggregans'),
('Desulfoluna butyratoxydans'),
('Desulfomonile limimaris'),
('Desulfotomaculum sapomandens'),
('Desulfotomaculum solfataricum'),
('Desulfotomaculum thermoacetoxidans'),
('Desulfotomaculum varum'),
('Desulfovibrio biadhensis'),
('Desulfovibrio burkinensis'),
('Desulfuromonas palmitatis'),
('Desulfuromonas svalbardensis'),
('Desulfuromusa bakii'),
('Desulfuromusa ferrireducens'),
('Desulfuromusa succinoxidans'),
('Dokdonella kunshanensis'),
('Dokdonia aurantiaca'),
('Dokdonia diaphoros'),
('Dokdonia eikasta'),
('Dokdonia flava'),
('Dyella agri'),
('Dyella ginsengisoli'),
('Dyella jejuensis'),
('Eionea flava'),
('Eionea nigra'),
('Enterobacter quasihormaechei'),
('Enterobacter siamensis'),
('Enterobacter wuhouensis'),
('Enterococcus alishanensis'),
('Ercella succinigenes'),
('Erwinia billingiae'),
('Erwinia carnegieana'),
('Erwinia endophytica'),
('Erwinia papayae'),
('Eubacterium tortuosum'),
('Eubacterium yurii subsp. schtitka'),
('Euzebyella algicola'),
('Ferrovibrio denitrificans'),
('Ferrovibrio soli'),
('Ferruginibacter alkalilentus'),
('Ferruginibacter lapsinanis'),
('Ferruginibacter profundus'),
('Flavisolibacter metallilatus'),
('Flavisolibacter rigui'),
('Flavivirga aquimarina'),
('Flavobacteriaceae bacterium'),
('Flavobacterium acidificum'),
('Flavobacterium dispersum'),
('Flavobacterium eburneum'),
('Flavobacterium edaphi'),
('Flavobacterium effusum'),
('Flavobacterium flaviflagrans'),
('Flavobacterium fluminis'),
('Flavobacterium oryzae'),
('Flavobacterium pedocola'),
('Flectobacillus lacus'),
('Flectobacillus pallidus'),
('Flectobacillus roseus'),
('Flexibacter polymorphus'),
('Flexivirga lutea'),
('Flindersiella endophytica'),
('Flintibacter butyricus'),
('Fretibacter rubidus'),
('Friedmanniella aerolata'),
('Friedmanniella lucida'),
('Friedmanniella okinawensis'),
('Frigoribacterium endophyticum'),
('Frigoribacterium salinisoli'),
('Galenea microaerophila'),
('Gallicola barnesae'),
('Geobacter psychrophilus'),
('Geobacter sulfurreducens subsp. ethanolicus'),
('Geodermatophilus marinus'),
('Gillisia myxillae'),
('Gillisia sandarakina'),
('Gilvibacter sediminis'),
('Glycomyces phytohabitans'),
('Glycomyces sediminimaris'),
('Gramella marina'),
('Gramella oceani'),
('Gramella planctonica'),
('Gramella sediminilitoris'),
('Granulicella acidiphila'),
('Granulicella sapmiensis'),
('Halanaerobium acetethylicum'),
('Halanaerobium alcaliphilum'),
('Halanaerobium congolense'),
('Halanaerobium fermentans'),
('Halanaerobium lacusrosei'),
('Halanaerobium saccharolyticum subsp. senegalense'),
('Halanaerobium sehlinense'),
('Halapricum desulfuricans'),
('Halomicrococcus hydrotolerans'),
('Halomonas salina'),
('Halomonas sediminicola'),
('Halomonas shantousis'),
('Halomonas tabrizica'),
('Halorubrum luteum'),
('Halorubrum orientale'),
('Helcococcus ovis'),
('Helicobacter apri'),
('Helicobacter aurati'),
('Helicobacter canicola'),
('Herbidospora daliensis'),
('Herbidospora soli'),
('Herbidospora yilanensis'),
('Herpetosiphon gulosus'),
('Hydrogenophaga caeni'),
('Hydrogenophaga laconesensis'),
('Hydrogenophaga soli'),
('Hydrogenophilus hirschii'),
('Hydrogenophilus islandicus'),
('Hymenobacter rivuli'),
('Hymenobacter roseus'),
('Hymenobacter ruber'),
('Hymenobacter rufus'),
('Hymenobacter segetis'),
('Hymenobacter seoulensis'),
('Hymenobacter siberiensis'),
('Hymenobacter soli'),
('Ilyobacter delafieldii'),
('Janthinobacterium aquaticum'),
('Janthinobacterium rivuli'),
('Jatrophihabitans fulvus'),
('Jatrophihabitans huperziae'),
('Jatrophihabitans soli'),
('Jejuia marina'),
('Kerstersia similis'),
('Ketobacter nezhaii'),
('Ketogulonicigenium robustum'),
('Ketogulonicigenium vulgare'),
('Kibdelosporangium kanagawaense'),
('Kibdelosporangium lantanae'),
('Kibdelosporangium metalli'),
('Kibdelosporangium rhizosphaerae'),
('Kibdelosporangium rhizovicinum'),
('Klebsiella variicola subsp. tropica'),
('Kribbella endophytica'),
('Kribbella mirabilis'),
('Kribbella podocarpi'),
('Lachnospira pectinoschiza'),
('Lacibacter daechungensis'),
('Lacibacter nakdongensis'),
('Lacinutrix chionocetis'),
('Lacinutrix cladophorae'),
('Lacinutrix copepodicola'),
('Lactobacillus curtus'),
('Lactobacillus faecis'),
('Lactobacillus panisapium'),
('Lamprobacter modestohalophilus'),
('Lamprocystis roseopersicina'),
('Legionella thermalis'),
('Leptospira andrefontaineae'),
('Leptospira bandrabouensis'),
('Leptospira bourretii'),
('Leptospira bouyouniensis'),
('Leptospira congkakensis'),
('Leptospira dzianensis'),
('Leptospira dzoumogneensis'),
('Leucobacter holotrichiae'),
('Leucobacter populi'),
('Limnothrix redekei'),
('Limosilactobacillus alvi'),
('Limosilactobacillus reuteri subsp. porcinus'),
('Lishizhenia caseinilytica'),
('Longimonas haloalkaliphila'),
('Longivirga aurantiaca'),
('Lutibaculum pontilimi'),
('Lutimonas saemankumensis'),
('Lutimonas vermicola'),
('Lysinibacillus alkaliphilus'),
('Lysobacter pocheonensis'),
('Lysobacter rhizophilus'),
('Lysobacter rhizosphaerae'),
('Lysobacter sediminicola'),
('Lysobacter solanacearum'),
('Lysobacter terrae'),
('Maribacter chungangensis'),
('Maribacter litorisediminis'),
('Maribacter lutimaris'),
('Maribacter maritimus'),
('Maribacter pelagius'),
('Marinitoga camini'),
('Marinitoga okinawensis'),
('Marinobacter alexandrii'),
('Marinobacter excellens'),
('Marinomonas dokdonensis'),
('Marinomonas epiphytica'),
('Marinomonas mangrovi'),
('Massilia arvi'),
('Massilia brevitalea'),
('Massilia cavernae'),
('Massilia chloroacetimidivorans'),
('Meniscus glaucopis'),
('Meridianimaribacter flavus'),
('Mesonia aquimarina'),
('Mesonia hitae'),
('Mesotoga infera'),
('Metalysinibacillus jejuensis'),
('Methanobacterium aarhusense'),
('Methanogenium frigidum'),
('Methanogenium marinum'),
('Methanogenium organophilum'),
('Methylomonas aurantiaca'),
('Methylomonas fodinarum'),
('Methylomonas lenta'),
('Methylomonas paludis'),
('Methylomonas scandinavica'),
('Methyloparacoccus murrellii'),
('Methylophaga muralis'),
('Microbacterium deserti'),
('Microbacterium diaminobutyricum'),
('Microbacterium tumbae'),
('Microbispora oryzae'),
('Micromonospora equina'),
('Micromonospora fluminis'),
('Micromonospora fulva'),
('Micromonospora gallica'),
('Micromonospora halotolerans'),
('Microvirga indica'),
('Microvirgula curvata'),
('Morganella morganii subsp. sibonii'),
('Moritella abyssi'),
('Moritella japonica'),
('Moritella profunda'),
('Moritella viscosa'),
('Moritella yayanosii'),
('Moryella indoligenes'),
('Mucispirillum schaedleri'),
('Murdochiella asaccharolytica'),
('Muricauda flavescens'),
('Mycoplasma canadense'),
('Mycoplasma cavipharyngis'),
('Mycoplasma ciconiae'),
('Mycoplasma corogypsi'),
('Mycoplasma sualvi'),
('Mycoplasma tullyi'),
('Mycoplasma yeatsii'),
('Myroides anatoliensis'),
('Myroides gitamensis'),
('Natronococcus roseus'),
('Neptunitalea chrysea'),
('Neptunomonas acidivorans'),
('Nesterenkonia endophytica'),
('Nitrobacter alkalicus'),
('Nitrococcus mobilis'),
('Nitrogeniibacter aestuarii'),
('Nocardia heshunensis'),
('Nocardia kroppenstedtii'),
('Nocardioides dilutus'),
('Nocardioides dongxiaopingii'),
('Nocardioides echinoideorum'),
('Nocardioides tritolerans'),
('Nocardioides ultimimeridianus'),
('Nocardiopsis akesuensis'),
('Nocardiopsis ansamitocini'),
('Nonomuraea lycopersici'),
('Novosphingobium lotistagni'),
('Novosphingobium naphthae'),
('Novosphingobium oryzae'),
('Oceanobacillus oncorhynchi subsp. incaldanensis'),
('Oceanobacillus pacificus'),
('Oceanobacillus picturae'),
('Oceanobacillus sojae'),
('Oceanospirillum beijerinckii subsp. pelagicum'),
('Oceanospirillum maris subsp. hiroshimense'),
('Orenia chitinitropha'),
('Orenia salinaria'),
('Orenia sivashensis'),
('Paenibacillus agarexedens'),
('Paenibacillus agaridevorans'),
('Paenibacillus apis'),
('Paenibacillus hispanicus'),
('Paenibacillus hordei'),
('Paenibacillus intestini'),
('Paenibacillus jamilae'),
('Paenibacillus konkukensis'),
('Paenibacillus konsidensis'),
('Paenibacillus koreensis'),
('Paenibacillus kyungheensis'),
('Paenibacillus relictisesami'),
('Paenibacillus residui'),
('Paenibacillus rhizoryzae'),
('Paenibacillus ripae'),
('Paenibacillus salinicaeni'),
('Paenibacillus selenii'),
('Paenisporosarcina cavernae'),
('Paenochrobactrum pullorum'),
('Palaeococcus helgesonii'),
('Palleronia soli'),
('Paraburkholderia caseinilytica'),
('Paraburkholderia dioscoreae'),
('Paracoccus alimentarius'),
('Paracoccus carotinifaciens'),
('Paralcaligenes ginsengisoli'),
('Paralkalibacillus indicireducens'),
('Paramesonia marina'),
('Paramoritella alkaliphila'),
('Paramoritella sediminis'),
('Pasteurella stomatis'),
('Patulibacter brassicae'),
('Patulibacter ginsengiterrae'),
('Pedobacter jejuensis'),
('Pedobacter koreensis'),
('Pedobacter lentus'),
('Pedobacter lignilitoris'),
('Pedobacter lotistagni'),
('Pedobacter lycopersici'),
('Pelobacter venetianus'),
('Pelodictyon phaeum'),
('Pelomonas aquatica'),
('Pelosinus defluvii'),
('Pelospora glutarica'),
('Pelotomaculum isophthalicicum'),
('Phascolarctobacterium wakonense'),
('Phaselicystis flava'),
('Phenylobacterium conjunctum'),
('Phenylobacterium falsum'),
('Phenylobacterium koreense'),
('Phenylobacterium lituiforme'),
('Phenylobacterium muchangponense'),
('Phenylobacterium panacis'),
('Phycicoccus avicenniae'),
('Phycicoccus ginsengisoli'),
('Phycicoccus soli'),
('Phyllobacterium catacumbae'),
('Phyllobacterium ifriqiyense'),
('Planococcus columbae'),
('Planomicrobium alkanoclasticum'),
('Planomicrobium flavidum'),
('Polaromonas vacuolata'),
('Polyangium minor'),
('Polyangium rugiseptum'),
('Polyangium sorediatum'),
('Polyangium vitellinum'),
('Polycladomyces subterraneus'),
('Polygonibacillus indicireducens'),
('Proteinivorax hydrogeniformans'),
('Proteinivorax tanatarense'),
('Pseudoalteromonas xishaensis'),
('Pseudomonas glareae'),
('Pseudomonas oleovorans subsp. lubricantis'),
('Pusillimonas faecipullorum'),
('Puzihella rosea'),
('Raoultibacter massiliensis'),
('Raoultibacter timonensis'),
('Rapidithrix thailandica'),
('Rarimicrobium hominis'),
('Rathayibacter agropyri'),
('Rectinema cohabitans'),
('Rhizobium endophyticum'),
('Rhizobium gei'),
('Rhodanobacter humi'),
('Rhodanobacter hydrolyticus'),
('Rhodanobacter koreensis'),
('Rhodanobacter lindaniclasticus'),
('Rhodanobacter rhizosphaerae'),
('Rhodobacter alkalitolerans'),
('Rhodobacter azollae'),
('Rhodoferax sediminis'),
('Rhodoligotrophos jinshengii'),
('Rickettsia conorii subsp. indica'),
('Rickettsia helvetica'),
('Rickettsia massiliae'),
('Rickettsia montanensis'),
('Rickettsia parkeri'),
('Rickettsia peacockii'),
('Rickettsia rhipicephali'),
('Rickettsia rickettsii'),
('Roseivirga marina'),
('Roseivirga maritima'),
('Roseovarius scapharcae'),
('Rufibacter soli'),
('Saccharopolyspora deserti'),
('Saccharopolyspora halotolerans'),
('Saccharopolyspora hattusasensis'),
('Saccharopolyspora indica'),
('Salimesophilobacter vulgaris'),
('Salimicrobium luteum'),
('Salinarchaeum chitinilyticum'),
('Salinibacter luteus'),
('Salinispora goodfellowii'),
('Salinovum rubellum'),
('Sedimentibacter hongkongensis'),
('Sedimentitalea todarodis'),
('Serratia vespertilionis'),
('Shimia aquaeponti'),
('Skermanella xinjiangensis'),
('Smithella propionica'),
('Sneathia vaginalis'),
('Sphingobacterium bovistauri'),
('Sphingobacterium caeni'),
('Sphingobacterium canadense'),
('Sphingobacterium cibi'),
('Sphingobacterium daejeonense'),
('Sphingobium vulgare'),
('Sphingomonas agri'),
('Sphingomonas montanisoli'),
('Sphingomonas montis'),
('Sphingomonas naphthae'),
('Sphingomonas olei'),
('Sphingomonas oryziterrae'),
('Sphingorhabdus pacifica'),
('Sphingorhabdus planktonica'),
('Sphingosinicella xenopeptidilytica'),
('Spirabiliibacterium mucosae'),
('Spirosoma harenae'),
('Spirosoma horti'),
('Spirosoma humi'),
('Spirosoma jeollabukense'),
('Spirosoma knui'),
('Spirosoma koreense'),
('Spirosoma litoris'),
('Spirosoma lituiforme'),
('Spirosoma luteolum'),
('Spirosoma metallicum'),
('Spirosoma metallilatum'),
('Spirosoma migulaei'),
('Spirosoma pollinicola'),
('Spirosoma pomorum'),
('Stackebrandtia soli'),
('Stakelama algicida'),
('Stakelama flava'),
('Steroidobacter agaridevorans'),
('Streptococcus iniae'),
('Streptomyces acrimycini'),
('Streptomyces albiflaviniger'),
('Streptomyces boninensis'),
('Streptomyces burgazadensis'),
('Streptomyces cacaoi subsp. cacaoi'),
('Streptomyces demainii'),
('Streptomyces griseobrunneus'),
('Streptomyces griseus subsp. cretosus'),
('Streptomyces limosus'),
('Streptomyces luridiscabiei'),
('Streptomyces luridus'),
('Streptomyces panacagri'),
('Streptomyces phaeoluteichromatogenes'),
('Streptomyces pharmamarensis'),
('Streptomyces sampsonii'),
('Streptomyces sasae'),
('Streptomyces scopiformis'),
('Streptomyces sediminis'),
('Streptomyces seranimatus'),
('Streptomyces variegatus'),
('Streptomyces violaceorectus'),
('Streptoverticillium griseoverticillatum'),
('Streptoverticillium hachijoense'),
('Streptoverticillium kashmirense'),
('Streptoverticillium kishiwadense'),
('Streptoverticillium luteoverticillatum'),
('Streptoverticillium olivomycini'),
('Streptoverticillium parvisporogenes'),
('Streptoverticillium rectiverticillatum'),
('Streptoverticillium reticulum subsp. protomycicum'),
('Streptoverticillium salmonis'),
('Streptoverticillium septatum'),
('Sulfurisphaera javensis'),
('Sulfurococcus mirabilis'),
('Sulfurococcus yellowstonensis'),
('Sulfurospirillum alkalitolerans'),
('Tannerella serpentiformis'),
('Tanticharoenia aidae'),
('Taonella mepensis'),
('Tateyamaria armeniaca'),
('Tepidisphaera mucosa'),
('Terasakiella salincola'),
('Thalassobius litorarius'),
('Thalassococcus lentus'),
('Thalassocola ureilytica'),
('Thalassomonas fusca'),
('Thalassomonas haliotis'),
('Thermoanaerobacter pentosaceus'),
('Thermoanaerobacter sulfurigignens'),
('Thermoanaerobacter sulfurophilus'),
('Thermoanaerobacter thermohydrosulfuricus'),
('Thermoanaerobacterium aciditolerans'),
('Thermoanaerobacterium aotearoense'),
('Thermoanaerobacterium saccharolyticum'),
('Thermoanaerobacterium thermostercoris'),
('Thermogemmatispora argillosa'),
('Thermogemmatispora onikobensis'),
('Thermogutta hypogea'),
('Thermoleophilum minutum'),
('Thermolithobacter carboxydivorans'),
('Thermolithobacter ferrireducens'),
('Thermus brockianus'),
('Thermus thermamylovorans'),
('Thioalkalibacter halophilus'),
('Thioalkalicoccus limnaeus'),
('Thioalkalispira microaerophila'),
('Thioprofundum hispidum'),
('Thioprofundum lithotrophicum'),
('Thioreductor micantisoli'),
('Thiorhodococcus alkaliphilus'),
('Thiorhodococcus kakinadensis'),
('Thiorhodococcus modestalkaliphilus'),
('Thiosocius teredinicola'),
('Thiothrix defluvii'),
('Tropicihabitans flavus'),
('Tropicimonas aquimaris'),
('Tropicimonas arenosa'),
('Trueperella abortisuis'),
('Trueperella bonasi'),
('Ureibacillus defluvii'),
('Ureibacillus terrenus'),
('Ursidibacter arcticus'),
('Uruburuella testudinis'),
('Vitreoscilla beggiatoides'),
('Vitreoscilla filiformis'),
('Vogesella lacus'),
('Vogesella oryzae'),
('Volucribacter amazonae'),
('Winogradskyella litorisediminis'),
('Winogradskyella lutea'),
('Winogradskyella multivorans'),
('Winogradskyella pacifica'),
('Winogradskyella poriferorum'),
('Winogradskyella profunda'),
('Winogradskyella rapida'),
('Zoogloea caeni');
