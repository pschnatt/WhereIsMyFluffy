from datetime import datetime, timezone
from app.model.advertisementModel import AdClick

class advertisementService:
      def __init__(self, dbCollection):
            self.advertisement_collection = dbCollection["ad_click"]

      def record_ad_click(self, data : dict):
            for key, value in data.items():
                  ad = self.advertisement_collection.find_one({"ad_unit_id": key})
                  if ad:
                        new_count = ad["counter"] + value
                        self.advertisement_collection.update_one(
                              {"ad_unit_id": data.ad_unit_id},
                              {"$set": {"count": new_count}},
                              {"timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%d")},
                        )
                  else:
                        self.advertisement_collection.insert_one(
                              {"ad_unit_id": data.ad_unit},
                              {"counter": data.counter},
                              {"timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%d")},
                        )
            return {"message": "Ad click recorded."}
      
      def process(self, data):
            self.record_ad_click(data)

      