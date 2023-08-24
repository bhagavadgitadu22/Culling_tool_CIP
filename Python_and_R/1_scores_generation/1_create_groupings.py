# Script to create all the groupings of the directory 1_groupings at once
import psycopg2
import os

# on récupère la liste des identifiants valides
connection = psycopg2.connect(user="postgres",
                                password="postgres",
                                host="localhost",
                                port="5432",
                                database="brc_db")
connection.autocommit = True

# Create a cursor to perform database operations
cursor = connection.cursor()

for dir in os.listdir('./SQL/1_groupings'):
    str = './SQL/1_groupings/'+dir
    for dir in os.listdir(str):
            str2 = str+'/'+dir
            print(str2)
            cursor.execute(open(str2, "r").read())
