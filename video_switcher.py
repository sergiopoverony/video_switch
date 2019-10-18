import RPi.GPIO as GPIO
from time import sleep
import os

GPIO.setmode(GPIO.BCM)
#Set gpio default 21
GPIO.setup(21, GPIO.IN, pull_up_down=GPIO.PUD_UP)
#status for switch
status = 0

while True:
    input_state = GPIO.input(21)
    if input_state == False:
        os.system("sudo killall emulationstation")
        if status == 0:
            print('AV')
            status = 1
            os.system("tvservice -c \"PAL 4:3\"; fbset -depth 8; fbset -depth 16")
        else:
            print('HDMI')
            status = 0
            os.system("tvservice -p; fbset -depth 8; fbset -depth 16;")
        os.system("sudo openvt -c 1 -s -f emulationstation 2>&1")
    sleep(0.4)