from sqlalchemy import create_engine
import urllib
import os

server = os.getenv("DB_SERVER", "localhost")
database = os.getenv("DB_NAME", "FireArc")

connection = urllib.parse.quote_plus(
    f"Driver={{ODBC Driver 17 for SQL Server}};"
    f"Server={server};"
    f"Database={database};"
    "Trusted_Connection=yes;"
)

con_eng = create_engine(
    f"mssql+pyodbc:///?odbc_connect={connection}"
)