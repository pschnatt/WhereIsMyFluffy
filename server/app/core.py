class Core:
    def __init__(self):
        self.plugins = {
            "external_service": [],
            "internal_service": [],
            "adapter": [],
        }

    def register_plugin(self, plugin_type, plugin):
        if plugin_type in self.plugins:
            self.plugins[plugin_type].append(plugin)
        else:
            raise ValueError(f"Unknown plugin type: {plugin_type}")

    def handle_request(self, plugin_type, data):
        if plugin_type in self.plugins:
            for plugin in self.plugins[plugin_type]:
                return plugin.process(data)
        else:
            raise ValueError(f"No plugins registered for type: {plugin_type}")