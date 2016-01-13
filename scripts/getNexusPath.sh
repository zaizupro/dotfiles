#/bin/bash

# Find the path to MTP/PTP connected device by USB ID
find_path_by_usbid () {
        lsusboutput="$(lsusb -d $1 | head -n1)"
        usbbus="${lsusboutput% Device*}"
        usbbus="${usbbus#Bus }"
        usbdevice="${lsusboutput%%:*}"
        usbdevice="${usbdevice#*Device }"

        # Media Transfer Protocol
        if [ -d "$XDG_RUNTIME_DIR" ]; then
            runtimedir="$XDG_RUNTIME_DIR"
        else
            runtimedir="/run/user/$USER"
        fi
        MtpPath="$runtimedir/gvfs/mtp:host=%5Busb%3A${usbbus}%2C${usbdevice}%5D"
        # Picture Transfer Protocol
        PtpPath="$runtimedir/gvfs/gphoto2:host=%5Busb%3A${usbbus}%2C${usbdevice}%5D"

        if [ -d "$MtpPath" ]; then
                echo "$MtpPath"
        elif [ -d "$PtpPath" ]; then
                echo "$PtpPath"
        else
                echo "Error: File or directory was not found." 
        fi
}

# USB ID for Nexus 4
Id="18d1:4ee1"
DevicePath="$(find_path_by_usbid $Id)"



# Backup pictures if device is connected
if [ "$DevicePath" == "Error: File or directory was not found." ]; then
        echo "."
        exit
else
	echo "$DevicePath"
#        rsync -av --progress $DevicePath/DCIM/Camera/ ~/Pictures/Backup_Nexus4/

fi
