# Script generating an Excel file with the detailed scores of each group, parameter by parameter
import psycopg2
from openpyxl.workbook.workbook import Workbook
from openpyxl.styles import Alignment, Font

### 0 - functions to style the Excel file
def redimension_cell_width(ws):
    dims = {}
    i = 0
    for row in ws.rows:
        if i == 0:
            i += 1
            for cell in row:
                cell.alignment = Alignment(textRotation=90)
        else:
            for cell in row:
                if cell.value:
                    line_max = len(str(cell.value))
                    max_ = max((dims.get(cell.column_letter, 0), line_max))
                    dims[cell.column_letter] = max_
    for col, value in dims.items():
        ws.column_dimensions[col].width = value+2

def basic_redimension_cell_width(ws):
    dims = {}
    i = 0
    for row in ws.rows:
        for cell in row:
            if cell.value:
                line_max = len(str(cell.value))
                max_ = max((dims.get(cell.column_letter, 0), line_max))
                dims[cell.column_letter] = max_
    for col, value in dims.items():
        ws.column_dimensions[col].width = value+2

def style_sheet(sheet):
    header = list(sheet.rows)[0]
    for cell in header:
        cell.font = Font(bold=True)

def iebc(type_s):
    if type_s == "iebc":
        return " AND t_souche.sch_col_id = 415"
    else:
        return " AND t_souche.sch_col_id != 415"

def complement(time, type):
    if time == "global":
        return "" 
    if time == "before_1950":
        if type == "compte":
            return " AND LEAST(EXTRACT(YEAR FROM sch_dat_isolement), EXTRACT(YEAR FROM sch_dat_prelevement), an_historique)<1950" 
        else:
            return " AND historical_value<1950"
    if time == "in_between_1950_2014":
        if type == "compte":
            return " AND LEAST(EXTRACT(YEAR FROM sch_dat_isolement), EXTRACT(YEAR FROM sch_dat_prelevement), an_historique)>=1950 AND LEAST(EXTRACT(YEAR FROM sch_dat_isolement), EXTRACT(YEAR FROM sch_dat_prelevement), an_historique)<=2014"
        else:
            return " AND historical_value>=1950 AND historical_value<=2014"
    if time == "after_2014":
        if type == "compte":
            return " AND LEAST(EXTRACT(YEAR FROM sch_dat_isolement), EXTRACT(YEAR FROM sch_dat_prelevement), an_historique)>2014"
        else:
            return " AND historical_value>2014"

def metric(sheet_g, cursor, g, type_s, time, line):
    restriction1 = " AND (t_cpr_1546.cpr_resultat IS NULL OR (t_cpr_1546.cpr_resultat = '' AND t_cpr_1546.cpr_com = ''))"
    restriction2 = " AND wgs = 0"
    total_metadata = 93
    total_analytic = 16

    count_sql = basecount_sql+" WHERE t_souche.xxx_id IN (SELECT xxx_id FROM groupe"+g+")"+iebc(type_s)+complement(time, "compte")+restriction1
    cursor.execute(count_sql)
    number_strains = cursor.fetchone()

    if number_strains[0] > 0:
        sql_number_all = only_count_base_sql+" WHERE t_souche.xxx_id IN (SELECT xxx_id FROM groupe"+g+")"+iebc(type_s)+complement(time, "detail")
        cursor.execute(sql_number_all)
        number_all_strains = cursor.fetchone()

        sql_number_unsequenced = base_sql+" WHERE t_souche.xxx_id IN (SELECT xxx_id FROM groupe"+g+")"+iebc(type_s)+complement(time, "detail")+restriction2
        cursor.execute(sql_number_unsequenced)
        record = cursor.fetchone()
        colnames = [desc[0] for desc in cursor.description]

        sql_number_unsequenced_even_on_ncbi = only_count_base_sql+" LEFT JOIN strains_sequenced_ncbi ON t_souche.sch_identifiant = strains_sequenced_ncbi.id_brclims WHERE t_souche.xxx_id IN (SELECT xxx_id FROM groupe"+g+")"+iebc(type_s)+complement(time, "detail")+restriction2+" AND strains_sequenced_ncbi.id_brclims IS NULL"
        cursor.execute(sql_number_unsequenced_even_on_ncbi)
        number_strains_unsequenced_even_on_ncbi = cursor.fetchone()

        if len(legend_g) == 2:
            for col in colnames:
                legend_g.append(col)
            legend_g.append("sum_metadata")
            legend_g.append("sum_analytic")
            legend_g.append("sum_global")
            sheet_g.append(legend_g)
        
        line.append(number_all_strains[0])
        line.append(round((number_all_strains[0]-record[0])*100/number_all_strains[0],2))
        line.append(record[0])
        line.append(round(sum(record[1:15])*100/total_metadata,2))
        line.append(round(sum(record[15:])*100/total_analytic,2))
        line.append(round(sum(record[1:])*100/(total_metadata+total_analytic),2))
        line.append(round((number_strains_unsequenced_even_on_ncbi[0]*100)/record[0],2))

        line_g = [type_s, time]
        for elmt in record:
            line_g.append(elmt)
        line_g.append(sum(record[1:15]))
        line_g.append(sum(record[15:]))
        line_g.append(sum(record[1:]))
        sheet_g.append(line_g)
    else:
        line.append("xxx")
        line.append("xxx")
        line.append("xxx")
        line.append("xxx")
        line.append("xxx")
        line.append("xxx")
        line.append("xxx")

    return line

# on récupère la liste des identifiants valides
connection = psycopg2.connect(user="postgres",
                                password="postgres",
                                host="localhost",
                                port="5432",
                                database="brc_db")
connection.autocommit = True

# Create a cursor to perform database operations
cursor = connection.cursor()

generale_sql = open("./SQL/3_metrics/1_metrique_generale.sql", "r").read()
cursor.execute(generale_sql)
scientifique_sql = open("./SQL/3_metrics/2_metrique_scientifique.sql", "r").read()
cursor.execute(scientifique_sql)

groupes = ['1_who','2_zoonotic','3_pigment','3_indole','3_npatlas','4_type','4_type_unsequenced','5_quality','6_gmo','7_extremophiles_certain','7_extremophiles_uncertain', '8_archaea', '9_origines_eucaryotes','9_origines_soil', '0_other']

basecount_sql = open("./SQL/3_metrics/4_number_of_strains_method1.sql", "r").read()
base_sql = open("./SQL/3_metrics/3_total_metriques.sql", "r").read()
only_count_base_sql = open("./SQL/3_metrics/5_number_of_strains_method2.sql", "r").read()

times = ["global", "before_1950", "in_between_1950_2014", "after_2014"]

wb = Workbook()
sheet = wb["Sheet"]
legend = ["group", "bacillus_or_normal"]
for time in times:
    for small in ("number_of_strains", "%_of_sequencing", "unsequenced_number_of_strains", "metadata_sequencing_(/100)", "analytic_sequencing_(/100)", "global_sequencing_(/100)", "%_unsequenced_of_strains_on_NCBI"):
        legend.append(time+"_"+small)
sheet.append(legend)
legend_g = ["bacillus_or_normal", "years"]

for g in groupes:
    print(g)
    sheet_g = wb.create_sheet(g)
    if len(legend_g) != 2:
        sheet_g.append(legend_g)

    for type_s in ["without_iebc", "iebc"]:
        line = [g]
        if type_s == "iebc":
            line.append('bacillus')
        else:
            line.append('normal')

        count_sql = basecount_sql+" WHERE t_souche.xxx_id IN (SELECT xxx_id FROM groupe"+g+")"+iebc(type_s)
        cursor.execute(count_sql)
        number_strains_line = cursor.fetchone()[0]

        if number_strains_line > 0:
            for time in times:
                line = metric(sheet_g, cursor, g, type_s, time, line)
            
            sheet.append(line)
        else:
            print("no_data for "+g+" "+type_s)

    basic_redimension_cell_width(sheet_g)
    style_sheet(sheet_g)

redimension_cell_width(sheet)
style_sheet(sheet)
wb.save(str("../../integration_souches_08_2023/general.xlsx"))
