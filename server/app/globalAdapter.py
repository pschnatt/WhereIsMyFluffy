class GlobalAdapter:
    def adapt_request(self, endpoint: str, data: dict):
        if endpoint == "notification":
            return data
        return data

    def adapt_response(self, endpoint: str, response_data: dict):
        return response_data