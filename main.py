import requests
import pandas as pd
from sqlserver_connection import con_eng
import datetime


def main():
    # extracts the data from the web and parse it to json
    response = requests.get(
        "https://data.cityofnewyork.us/resource/8m42-w767.json?$limit=10000"
    )
    json_response = response.json()
    # creating a dataframe using pandas
    df = pd.DataFrame(json_response)
    # insert datetime
    df["insert_date"] = datetime.datetime.now()
    # print(len(df.index))
    # writing to sqlserver
    df.to_sql(
        name="Fire_Incident_Dispatch_Data",
        con=con_eng,
        schema="dbo",
        if_exists="replace",
        index=True,
    )


if __name__ == "__main__":
    main()
