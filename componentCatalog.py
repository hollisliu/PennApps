#!/usr/bin/env python
# Copyright (c) 2015, Intel Corporation
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
#    * Redistributions of source code must retain the above copyright notice,
#      this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright notice,
#      this list of conditions and the following disclaimer in the documentation
#      and/or other materials provided with the distribution.
#    * Neither the name of Intel Corporation nor the names of its contributors
#      may be used to endorse or promote products derived from this software
#      without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import iotkitclient
import config
import random

# Connect and login to the IoT cloud
iot = iotkitclient.Request(host=config.hostname)
iot.login(config.username, config.password)
print "*** Connected. User ID: %s ..." % iot.user_id

# Get account object for test account
acct = iot.account()
acct.get_account(config.account_name)
print "*** Using Account: %s (%s)" % (acct.id, config.account_name)

# Get component type catalog object for test account
catalog = acct.component_catalog()
print "*** Listing existing Component Catalog"

# Add dust component
sensor_version_dust = "1.3"
sensor_type_dust = "dust"
for type in catalog.get_comp_types():
    print type["id"]
    if (type["dimension"] == sensor_type_dust and
       type["version"] is not None):
        if type["version"] >= sensor_version_dust:
            sensor_version_dust = type["version"]
# increment sensor version
sensor_version_dust = float(sensor_version_dust) + 0.1

# Define new component type properties
comp_type_id_dust = sensor_type_dust + ".v" + str(sensor_version_dust)
comp_type_info_dust = {
                    "dimension": sensor_type_dust,
                    "version": str(sensor_version_dust),
                    "type": "sensor",
                    "dataType":"Number",
                    "format": "float",
                    "min": 0,
                    "max": 8000,
                    "measureunit": "0.01 cf",
                    "display": "timeSeries"
                 }

print "*** Adding new component type (%s) to Component Catalog" % comp_type_id_dust
# Create new accel component type
info_dust = catalog.add_comp_type(comp_type_info_dust)
iotkitclient.prettyprint(info_dust)
##
### Add sound Component
##sensor_version_sound = "1.4"
##sensor_type_sound = "sound"
##for type in catalog.get_comp_types():
##    print type["id"]
##    if (type["dimension"] == sensor_type_sound and
##       type["version"] is not None):
##        if type["version"] >= sensor_version_sound:
##            sensor_version_sound = type["version"]
### increment sensor version
##sensor_version_sound = float(sensor_version_sound) + 0.1
##
### Define new component type properties
##comp_type_id_sound = sensor_type_sound + ".v" + str(sensor_version_sound)
##comp_type_info_sound = {
##                    "dimension": sensor_type_sound,
##                    "version": str(sensor_version_sound),
##                    "type": "sensor",
##                    "dataType":"Number",
##                    "format": "float",
##                    "min": 0,
##                    "max": 1203,
##                    "measureunit": "Unit",
##                    "display": "timeSeries"
##                 }
##
##print "*** Adding new component type (%s) to Component Catalog" % comp_type_id_sound
### Create new accel component type
##info_sound = catalog.add_comp_type(comp_type_info_sound)
##iotkitclient.prettyprint(info_sound)
##
### Add Airgas Component
##sensor_version_gas = "1.4"
##sensor_type_gas = "airGas"
##for type in catalog.get_comp_types():
##    print type["id"]
##    if (type["dimension"] == sensor_type_gas and
##       type["version"] is not None):
##        if type["version"] >= sensor_version_gas:
##            sensor_version_gas = type["version"]
### increment sensor version
##sensor_version_gas = float(sensor_version_gas) + 0.1
##
### Define new component type properties
##comp_type_id_gas = sensor_type_gas + ".v" + str(sensor_version_gas)
##comp_type_info_gas = {
##                    "dimension": sensor_type_gas,
##                    "version": str(sensor_version_gas),
##                    "type": "sensor",
##                    "dataType":"Number",
##                    "format": "float",
##                    "min": 0,
##                    "max": 1203,
##                    "measureunit": "Unit gas",
##                    "display": "timeSeries"
##                 }
##
##print "*** Adding new component type (%s) to Component Catalog" % comp_type_id_gas
### Create new accel component type
##info_gas = catalog.add_comp_type(comp_type_info_gas)
##iotkitclient.prettyprint(info_gas)

### Add light Component
##sensor_version_light = "1.1"
##sensor_type_light = "light"
##for type in catalog.get_comp_types():
##    print type["id"]
##    if (type["dimension"] == sensor_type_light and
##       type["version"] is not None):
##        if type["version"] >= sensor_version_light:
##            sensor_version_light = type["version"]
### increment sensor version
##sensor_version_light = float(sensor_version_light) + 0.1
##
### Define new component type properties
##comp_type_id_light = sensor_type_light + ".v" + str(sensor_version_light)
##comp_type_info_light = {
##                    "dimension": sensor_type_light,
##                    "version": str(sensor_version_light),
##                    "type": "sensor",
##                    "dataType":"Number",
##                    "format": "float",
##                    "min": 0,
##                    "max": 1203,
##                    "measureunit": "Lux",
##                    "display": "timeSeries"
##                 }
##
##print "*** Adding new component type (%s) to Component Catalog" % comp_type_id_light
### Create new accel component type
##info_light = catalog.add_comp_type(comp_type_info_light)
##iotkitclient.prettyprint(info_light)
##
