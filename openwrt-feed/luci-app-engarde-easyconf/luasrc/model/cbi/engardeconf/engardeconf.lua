config = Map("engardeconf")

view = config:section(NamedSection,"Setup", "config",  translate("Engarde Easy Configuration"))
pass = view:option(Value, "pass", "Password:", "The password set in cloud-init password field."); pass.optional=false; pass.rmempty = false; pass.password=true;
remip = view:option(Value, "remip", "Server address:", "Server IP address found in provider dashboard."); pass.optional=false; pass.rmempty = false; pass.password=true;
return config
