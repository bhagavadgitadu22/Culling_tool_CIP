# Script to create one Excel file per group with one line per strain containing the main information known about the strain
import psycopg2
from openpyxl.workbook.workbook import Workbook
from openpyxl.styles import Font

### 0 - functions to style the Excel file
def redimension_cell_width(ws):
    dims = {}
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

# on récupère la liste des identifiants valides
connection = psycopg2.connect(user="postgres",
                                password="postgres",
                                host="localhost",
                                port="5432",
                                database="brc_db")
connection.autocommit = True

# Create a cursor to perform database operations
cursor = connection.cursor()

groupes = ['1_who','2_zoonotic','3_pigment','3_indole','3_npatlas','4_type','4_type_unsequenced','5_quality','6_gmo','7_extremophiles_certain','7_extremophiles_uncertain', '8_archaea', '9_origines_eucaryotes','9_origines_soil', '0_other']
specific_sql = open("./SQL/2_infos_souches/infos_par_souches_par_groupe.sql", "r").read()
legend = []

wb_bacdive = Workbook()

for g in groupes:
    print(g)

    wb = Workbook()
    sheet = wb["Sheet"]
    sql_g = specific_sql + " WHERE t_souche.xxx_id IN (SELECT xxx_id FROM groupe"+g+")"

    cursor.execute(sql_g)
    colnames = [desc[0] for desc in cursor.description]
    if len(legend) == 0:
        for col in colnames:
            legend.append(col)
    sheet.append(legend)

    records = cursor.fetchall()
    for record in records:
        sheet.append(record)

    redimension_cell_width(sheet)
    style_sheet(sheet)
    wb.save(str("../../integration_souches_08_2023/infos_souches/"+g+".xlsx"))
