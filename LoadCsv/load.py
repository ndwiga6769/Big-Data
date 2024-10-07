import pandas as pd
from sqlalchemy import create_engine

mypath = 'postgresql+psycopg2://postgres:Njoka123#@localhost:5433/KCB'

# Create engine to connect to PostgreSQL database
db = create_engine(mypath)
conn = db.connect()

files = ['athlete_events','noc_regions']

for file in files:
    df =pd.read_csv(f'C:/Users/Administrator/Desktop/Main/Big-Data/LoadCsv/{file}.csv')
    df.to_sql(file, conn, if_exists='replace', index=False)