import os
os.environ['PGCLIENTENCODING'] = 'utf-8'
import psycopg2

PG_HOST = "127.0.0.1"
PG_PORT = 5433
PG_DB = "postgres"
PG_USER = "postgres"
PG_PASS = "postgres"

try:
    print(f"Connecting to {PG_DB} at {PG_HOST}:{PG_PORT}...")
    conn = psycopg2.connect(
        host=PG_HOST,
        port=PG_PORT,
        dbname=PG_DB,
        user=PG_USER,
        password=PG_PASS,
        connect_timeout=5
    )
    print("✅ Connection successful!")
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM public.als_recos")
    count = cur.fetchone()[0]
    print(f"✅ Table als_recos has {count} rows.")
    cur.close()
    conn.close()
except Exception as e:
    print(f"❌ Connection failed: {e}")
