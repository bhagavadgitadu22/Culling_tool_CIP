# Script generating a concatenated version of the general Excel file created previously
import pandas as pd
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

xls = pd.ExcelFile("../../integration_souches_08_2023/general.xlsx")

lines = []
begin = True
for name in xls.sheet_names:
    if name != "Sheet":
        print(name)
        df = pd.read_excel(xls, name)

        if begin:
            legend = ["Group"]
            for col in df.columns:
                legend.append(col)
            lines.append(legend)
            begin = False

        df = df.reset_index(drop=True)  # make sure indexes pair with number of rows
        
        for index, row in df.iterrows():
            line = [name]
            for elmt in row:
                line.append(elmt)
            lines.append(line)

wb = Workbook()
sheet = wb["Sheet"]
for line in lines:
    sheet.append(line)
redimension_cell_width(sheet)
style_sheet(sheet)
wb.save(str("../../integration_souches_08_2023/concat_details_general.xlsx"))
