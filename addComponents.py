import iotkitclient
import config

# Connect to IoT Analytics site and authenticate
print "Connecting to %s ..." % config.hostname
iot = iotkitclient.Request(host=config.hostname, proxies=config.proxies)
iot.login(config.username, config.password)
print "Connected. User ID: %s ..." % iot.user_id

# Link to a specific IoT Analytics account
acct = iot.account()
try:
    acct.get_account(config.account_name)
except:
    acct.create_account(config.account_name)
    iot.reinit(config.username, config.password)
print "Using Account: %s ..." % config.account_name

# Link to a specific device in the account
device = acct.device()
device_id = iot.user_id + "_01"
try:
    device.get_device(device_id)
except Exception, ex:
    raise RuntimeError(str(ex))
device.load_config("device.json")
print "Using Device: %s ..." % device_id

# Create a component object
comp = device.component()

# Create dictionary to hold id
iden = {}

for element in config.component_info.keys():
    iden[element] = comp.id
    if not comp.get_component(element):
        comp.add_component(element,config.component_info[element])
        iden[element] = comp.id

# save latest device-info
device.get_device(device_id)
device.save_config("device.json", True)
##
### Delete extra temp components
#comp.delete_component("14125453-fba7-454d-ad6a-df7c9410b918")
#comp.delete_component("857e5c81-1c9f-460e-a438-a64924f80c99")
#comp.delete_component("9cb526b8-2c51-43df-b7d6-9d314cf4e6da")
