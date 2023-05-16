from sqlalchemy import create_engine
import urllib

connection = urllib.parse.quote_plus(
    'Data Source Name=DESKTOP-7VT8EU7;'
    'Driver={SQL Server};'
    'Server=DESKTOP-7VT8EU7;'
    'Database=FireArc;'
    'Trusted_connection=yes'
)

con_eng = create_engine('mssql+pyodbc:///?odbc_connect={}'.format(connection))
