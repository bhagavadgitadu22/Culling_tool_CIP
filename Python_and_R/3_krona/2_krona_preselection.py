# Builds a csv Krona input file from the SQL script in 5_krona
from ete3 import NCBITaxa
import csv
import psycopg2

# TO MODIFY: les références à ma bdd locale
def get_cursor(db_name):
    conn = psycopg2.connect(user="postgres",
                                  password="postgres",
                                  host="localhost",
                                  port="5432",
                                  database=db_name)
    conn.autocommit = True

    return conn.cursor()

def place(name):
    if name == 'superkingdom':
        return 1
    elif name == 'phylum':
        return 2
    elif name == 'class':
        return 3
    elif name == 'order':
        return 4
    elif name == 'family':
        return 5
    elif name == 'genus':
        return 6

def replaceGenus(genus):
    genus = genus.strip('"')
    if genus == 'Mycoplasmoides':
        return 'Mycoplasma'
    elif genus == 'Branhamella':
        return 'Moraxella'
    elif genus == 'Streptoverticillium':
        return 'Streptomyces'
    elif genus == 'Lactosphaera':
        return 'Trichococcus'
    return genus

ncbi = NCBITaxa()
#ncbi.update_taxonomy_database()

# TO MODIFY: référence à mon fichier SQL que tu devras modifier pour aller chercher les taxonomies de ta base OWEY
#str_sql = open("../SQL/5_krona/separation_taxos_pour_krona.sql", "r").read()
str_sql = open("../SQL/5_krona/separation_taxos_pour_krona_preselection.sql", "r").read()

# TO MODIFY: référence à ma base de données locale
cursor = get_cursor("brc_db")
cursor.execute(str_sql)
records_cip = cursor.fetchall()

taxosBRC = [record for record in records_cip]

all_genus = []
for taxoBRC in taxosBRC:
    if replaceGenus(taxoBRC[2]) not in all_genus:
        all_genus.append(replaceGenus(taxoBRC[2]))
taxIds = ncbi.get_name_translator(all_genus)
print(taxIds)

lines = []
legend = ['Type', 'Not_Type', 'Domain', 'Phylum', 'Class', 'Order', 'Family', 'Genus', 'Species', 'Subspecies']
lines.append(legend)
for taxoBRC in taxosBRC:
    type = taxoBRC[0]
    not_type = taxoBRC[1]
    genus = replaceGenus(taxoBRC[2])
    species = taxoBRC[3]
    subspecies = taxoBRC[4]

    if genus not in taxIds:
        if genus.lower() in taxIds:
            genus = genus.lower()
        else:
            print(genus, ' ', type, ' ', not_type)
    else:
        #if len(taxIds[genus]) > 1:
            #print("too many entries in ncbi:", genus)
        
        taxId = taxIds[genus][0]
        lineage = ncbi.get_lineage(taxId)

        result = []
        for i in range(10):
            result.append('')
        for parentId in lineage:
            if ncbi.get_rank([parentId])[parentId] in ['superkingdom', 'phylum', 'class', 'order', 'family', 'genus']:
                idx = place(ncbi.get_rank([parentId])[parentId])+1
                result[idx] = ncbi.get_taxid_translator([parentId])[parentId]
        result[8] = species
        result[9] = subspecies

        result[0] = type
        result[1] = not_type

        lines.append(result)

f = open('../../../integration_souches_08_2023/krona_cip_preselection.csv', 'w', newline='')
writer = csv.writer(f, delimiter=';')
writer.writerows(lines)
f.close()
