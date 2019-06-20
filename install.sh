#!/bin/bash
# https://www.othermod.com
if [ $(id -u) -ne 0 ]; then
	echo "Installer must be run as root."
	echo "Try 'sudo bash $0'"
	exit 1
fi

echo "Switcher video out AV and HDMI with GPIO21 button..."

#boot script should have the necessary lines(Battery, poweroff, backlight, buttons), then new ones should be added after a y/n question(joystick)
# Insert battery script into rc.local before final 'exit 0'
if ! grep -Fxq "python /home/pi/video_switch/test_gpio.py &" /etc/rc.local
then
sed -i "s/^exit 0/python /home/pi/video_switch/test_gpio.py \&\\nexit 0/g" /etc/rc.local >/dev/null
fi

read -rsp $'Press any key to reboot...\n' -n1 key
reboot

