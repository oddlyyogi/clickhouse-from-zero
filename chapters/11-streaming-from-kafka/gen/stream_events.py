import json, random, sys, uuid
from datetime import datetime, timezone

count = int(sys.argv[1])
seed = int(sys.argv[2]) if len(sys.argv) > 2 else 7
rng = random.Random(seed)

COUNTRIES = ["US", "GB", "DE", "IN", "FR", "BR", "CA", "JP", "AU", "NL"]
DEVICES = ["mobile", "desktop", "tablet"]
BROWSERS = ["Chrome", "Safari", "Firefox", "Edge"]
PAGES = ["/", "/search", "/category", "/offers"]
KINDS = ["page_view", "product_view", "add_to_cart", "purchase"]
WEIGHTS = [60, 30, 7, 3]

def event():
    user = rng.randrange(1, 200_001)
    kind = rng.choices(KINDS, WEIGHTS)[0]
    product = rng.randrange(1, 2001) if kind != "page_view" else 0
    url = {"page_view": rng.choice(PAGES),
           "product_view": f"/product/{product}",
           "add_to_cart": "/cart", "purchase": "/checkout"}[kind]
    price = round(rng.uniform(5, 500), 2) if kind == "purchase" else 0
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")
    return {"event_time": now, "event_type": kind,
            "user_id": user, "url": url,
            "session_id": str(uuid.UUID(int=rng.getrandbits(128))),
            "country": rng.choice(COUNTRIES),
            "device": rng.choice(DEVICES),
            "browser": rng.choice(BROWSERS),
            "product_id": product, "price": price}

for _ in range(count):
    print(json.dumps(event()))
