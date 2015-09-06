#Import libraries
import time, sys, signal, atexit
import pyupm_groveloudness as upmGroveloudness
import pyupm_grove as grove
import pyupm_gas as upmGas
import pyupm_ppd42ns as upmPpd42ns
import threading
import iotkitclient
import config
import time
import addComponents

# Create sensor objects
light = grove.GroveLight(2)
button = grove.GroveButton(3)
temp = grove.GroveTemp(0)
myLoudness = upmGroveloudness.GroveLoudness(1)
myDustSensor = upmPpd42ns.PPD42NS(8)
# Gas Sensor
myMQ5 = upmGas.MQ5(3)
threshContext = upmGas.thresholdContext()
threshContext.averageReading = 0
threshContext.runningAverage = 0
threshContext.averagedOver = 2
mybuffer = upmGas.uint16Array(128)

## Exit handlers ##
# This stops python from printing a stacktrace when you hit control-C
def SIGINTHandler(signum, frame):
	raise SystemExit

# This lets you run code on exit, including functions from myLoudness
def exitHandler():
	print "Exiting"
	sys.exit(0)

# Register exit handlers
atexit.register(exitHandler)
signal.signal(signal.SIGINT, SIGINTHandler)


def dataAcquisitionMinor():
    while(1):
        lightD = light.value()
        tempD = temp.value()
        soundD = myLoudness.value()
        print "Light :  :",  str(lightD)
        print "Temp :  :" , str(tempD)
        print "Sound :  :",  str(soundD)
        lightL = addComponents.device.package_data_series([(int(time.time() * 1000), str(lightD))], addComponents.iden["light"])
        tempL = addComponents.device.package_data_series([(int(time.time() * 1000), str(tempD))], addComponents.iden["temp"])
        loudL = addComponents.device.package_data_series([(int(time.time() * 1000), str(soundD))], addComponents.iden["sound"])
        addComponents.device.send_data(lightL)
        addComponents.device.send_data(tempL)
        addComponents.device.send_data(loudL)
        delay(120)

def dataAcquisitionMajor():
    while(1):
        samplelen = myMQ5.getSampledWindow(2, 128, mybuffer)
        if samplelen:
            thresh = myMQ5.findThreshold(threshContext, 30, mybuffer, samplelen)
            myMQ5.printGraph(threshContext, 5)
            if(thresh):
                thresh = addComponents.device.package_data_series([(int(time.time() * 1000), str(thresh))], addComponents.iden["airgas"])
                addComponents.device.send_data(thresh)
        dustD = addComponents.device.package_data_series([(int(time.time() * 1000), str(myDustSensor.getData().concentration))],"9cef3ca3-6f18-4426-bae3-89d286e2cb43")
        addComponents.device.send_data(dustD)
        time.sleep(240)
    
# Initialize threads
minorThread = threading.Thread(name = 'Minor', target = dataAcquisitionMinor, args = ())
majorThread = threading.Thread(name = 'Major', target = dataAcquisitionMajor, args = ())

#Start threads
minorThread.start()
majorThread.start()

# Start main script
while (1):
    #Get data functions
    butt = button.value()
    if butt == 1:
        lightD = light.value()
        tempD = temp.value()
        soundD = myLoudness.value()
        print "Light : %5.2f :" % lightD
        print "Temp : %5.2f :" % tempD
        print "Sound : %5.2f :" % soundD
        lightL = addComponents.device.package_data_series([(int(time.time() * 1000), str(lightD))], addComponents.iden["light"])
        tempL = addComponents.device.package_data_series([(int(time.time() * 1000), str(tempD))], addComponents.iden["temp"])
        loudL = addComponents.device.package_data_series([(int(time.time() * 1000), str(soundD))], "9cef3ca3-6f18-4426-bae3-89d286e2cb43")
        addComponents.device.send_data(lightL)
        addComponents.device.send_data(tempL)
        addComponents.device.send_data(loudL)
