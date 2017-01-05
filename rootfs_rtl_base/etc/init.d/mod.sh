#!/bin/sh
### BEGIN INIT INFO
# Provides:          module-init-tools
# Required-Start:    
# Required-Stop:     
# Should-Start:      checkroot
# Should-stop:
# Default-Start:     S
# Default-Stop:
### END INIT INFO

WIFI_DRIVER="rtl"

BCM_MODULE="/lib/modules/bcmdhd.ko" 
RTL_MODULE="/lib/modules/8723bs.ko"

echo "$BCM_MODULE"

if [ "$WIFI_DRIVER"x = "rtl"x ]; then 
    if [ -f $RTL_MODULE ]; then
        insmod $RTL_MODULE
    fi
else
    if [ -f $BCM_MODULE ]; then 
        insmod $BCM_MODULE "firmware_path=/lib/firmware/fw_bcm43438a.bin nvram_path=/lib/firmware/nvram.txt"
    fi
fi

exit 0
