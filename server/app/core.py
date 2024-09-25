def singleton(cls):
    instances = {}
    
    def get_instance(*args, **kwargs):
        if cls not in instances:
            instances[cls] = cls(*args, **kwargs)
        return instances[cls]
    
    return get_instance

@singleton
class Core:
    def __init__(self):
        self.plugins = {
            "external_service": {},
            "internal_service": {},
        }

    def register_plugin(self, plugin_type, service_name, plugin):
        if plugin_type in self.plugins:
            self.plugins[plugin_type][service_name] = plugin
        else:
            raise ValueError(f"Unknown plugin type: {plugin_type}")

    def handle_request(self, plugin_type, service_name, data):
        if plugin_type in self.plugins and service_name in self.plugins[plugin_type]:
            plugin = self.plugins[plugin_type][service_name]
            return plugin.process(data)
        else:
            raise ValueError(f"No plugins registered for {plugin_type}/{service_name}")
