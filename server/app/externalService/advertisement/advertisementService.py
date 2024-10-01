from datetime import datetime, timezone
from app.model.advertisementModel import AdClick

class advertisementService:
      def __init__(self, dbCollection):
            self.advertisement_collection = dbCollection["ad_click"]
            self.countList = []

      def ad_click(self, data: AdClick):
            self.count += 1
            return {"message": f"Ad click recorded. Total count: {self.count}"}

      def record_ad_click(self, data: AdClick):
            self.advertisement_collection.update_one(
                  {"ad_unit_id": data.ad_unit_id},
                  {"$inc": {"count": 1}},
                  {"timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%d")},
                  upsert=True
            )
            return {"message": "Ad click recorded."}