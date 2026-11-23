"""Print Cloud state, backups and spend, without IDs or keys."""
import base64
import json
import os
import urllib.request
from datetime import date

API = "https://api.clickhouse.cloud/v1"
key = f"{os.environ['CH_CLOUD_KEY_ID']}:{os.environ['CH_CLOUD_KEY_SECRET']}"
auth = "Basic " + base64.b64encode(key.encode()).decode()


def get(path):
    request = urllib.request.Request(
        API + path, headers={"Authorization": auth})
    return json.load(urllib.request.urlopen(request))["result"]


org = get("/organizations")[0]["id"]
for svc in get(f"/organizations/{org}/services"):
    base = f"/organizations/{org}/services/{svc['id']}"
    print(f"service '{svc['name']}': {svc['state']}, "
          f"{svc['numReplicas']} replica, "
          f"{svc['minReplicaMemoryGb']} to {svc['maxReplicaMemoryGb']} GiB")
    cfg = get(base + "/backupConfiguration")
    print(f"  backups every {cfg['backupPeriodInHours']} h, "
          f"kept for {cfg['backupRetentionPeriodInHours']} h")
    for b in get(base + "/backups"):
        print(f"  {b['type']} backup at {b['startedAt'][:16]}: "
              f"{b['sizeInBytes'] / 1e6:.0f} MB, {b['status']}")
period = f"from_date=2026-11-20&to_date={date.today()}"
cost = get(f"/organizations/{org}/usageCost?{period}")
print(f"spent since the trial began: {cost['grandTotalCHC']:.2f} credits")
