import calendar, csv, json, random, sys, uuid
from datetime import datetime, timedelta

rows = int(sys.argv[1])
out = sys.argv[2]
seed = int(sys.argv[3]) if len(sys.argv) > 3 else 42
rng = random.Random(seed)
start = datetime(2026, 10, 1)
if len(sys.argv) > 4:
    start = datetime.fromisoformat(sys.argv[4])
days = calendar.monthrange(start.year, start.month)[1]

COUNTRIES = ["US", "GB", "DE", "IN", "FR", "BR", "CA", "JP", "AU", "NL"]
DEVICES = ["mobile", "desktop", "tablet"]
BROWSERS = ["Chrome", "Safari", "Firefox", "Edge"]
PAGES = ["/", "/search", "/category", "/offers"]
APP_VERSIONS = ["5.1.0", "5.2.0", "5.2.1"]

def session():
    user = rng.randrange(1, 200_001)
    sid = str(uuid.UUID(int=rng.getrandbits(128)))
    t = start + timedelta(seconds=rng.randrange(days * 24 * 3600))
    who = (rng.choice(COUNTRIES), rng.choice(DEVICES), rng.choice(BROWSERS))
    steps = [("page_view", rng.choice(PAGES), 0)] * rng.randint(1, 4)
    product = rng.randrange(1, 2001)
    steps += [("product_view", f"/product/{product}", product)]
    if rng.random() < 0.3:
        steps += [("add_to_cart", "/cart", product)]
        if rng.random() < 0.4:
            steps += [("purchase", "/checkout", product)]
    for kind, url, pid in steps:
        t += timedelta(seconds=rng.randint(2, 90))
        price = round(rng.uniform(5, 500), 2) if kind == "purchase" else 0
        yield {"event_time": t.strftime("%Y-%m-%d %H:%M:%S"),
               "event_type": kind, "user_id": user, "session_id": sid,
               "url": url, "country": who[0], "device": who[1],
               "browser": who[2], "product_id": pid, "price": price}

def events():
    n = 0
    while True:
        for e in session():
            yield e
            n += 1
            if n == rows:
                return

with open(out, "w", newline="") as f:
    if out.endswith(".csv"):
        w = csv.DictWriter(f, fieldnames=["event_time", "event_type",
            "user_id", "session_id", "url", "country", "device", "browser",
            "product_id", "price"])
        w.writeheader()
        w.writerows(events())
    else:
        for e in events():
            u = e["user_id"]
            e["props"] = {"app": {"version": APP_VERSIONS[u % 3],
                                  "os": "ios" if u % 2 else "android"},
                          "experiment": "B" if u % 10 < 3 else "A"}
            if e["event_type"] == "page_view":
                e["props"]["screen"] = {"w": 390 + u % 3 * 20, "h": 844}
            f.write(json.dumps(e) + "\n")
print(f"wrote {rows:,} events to {out}")
