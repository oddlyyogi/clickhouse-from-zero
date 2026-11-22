import csv, sqlite3, time

db = sqlite3.connect("data/shop.db")
db.execute("DROP TABLE IF EXISTS events")
db.execute("CREATE TABLE events (event_time TEXT, event_type TEXT,"
           " user_id INT, session_id TEXT, url TEXT, country TEXT,"
           " device TEXT, browser TEXT, product_id INT, price REAL)")
with open("data/events.csv") as f:
    rows = csv.reader(f)
    next(rows)
    db.executemany("INSERT INTO events VALUES (?,?,?,?,?,?,?,?,?,?)", rows)
db.commit()

QUERY = """
SELECT country, count(*) AS views
FROM events
WHERE event_type = 'page_view'
GROUP BY country
ORDER BY views DESC
"""
start = time.perf_counter()
for row in db.execute(QUERY):
    print(row)
print(f"query took {time.perf_counter() - start:.2f} s")
