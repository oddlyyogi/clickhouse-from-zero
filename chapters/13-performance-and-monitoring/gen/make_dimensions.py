import csv, random
from datetime import date, timedelta

rng = random.Random(7)
CATEGORIES = ["Books", "Garden", "Kitchen", "Toys",
              "Sports", "Electronics", "Beauty", "Pets"]
ADJECTIVES = ["Classic", "Compact", "Deluxe", "Eco",
              "Smart", "Travel", "Pro", "Mini"]
NOUNS = {"Books": "Novel", "Garden": "Planter", "Kitchen": "Pan",
         "Toys": "Puzzle", "Sports": "Ball", "Electronics": "Speaker",
         "Beauty": "Serum", "Pets": "Bed"}

with open("data/products.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["product_id", "name", "category", "list_price"])
    for pid in range(1, 2001):
        cat = rng.choice(CATEGORIES)
        name = f"{rng.choice(ADJECTIVES)} {NOUNS[cat]} {pid}"
        w.writerow([pid, name, cat, round(rng.uniform(5, 500), 2)])

PLANS = ["free", "plus", "pro"]
with open("data/customers.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["user_id", "signup_date", "plan"])
    for uid in range(1, 200001):
        signup = date(2024, 1, 1) + timedelta(days=rng.randrange(900))
        plan = rng.choices(PLANS, [70, 20, 10])[0]
        w.writerow([uid, signup.isoformat(), plan])
print("wrote 2,000 products and 200,000 customers")
