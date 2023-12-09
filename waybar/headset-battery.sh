
#!/bin/bash

headset_mac_address="23:07:14:21:02:B6"  # Replace with your headset's MAC address
battery_info=$(bluetoothctl info "$headset_mac_address" | grep "Battery Percentage:")
headset_name=$(bluetoothctl info "$headset_mac_address" | grep "Name: " | cut -d ' ' -f 2)
if [ -n "$battery_info" ]; then
   hex_battery_percentage=$(echo "$battery_info" | awk '{print $3}')
   decimal_battery_percentage=$(($hex_battery_percentage))
   echo "{\"text\": \" $headset_name: $decimal_battery_percentage%\"}"
else
   echo "{\"text\": \" Headset not connected\"}"
fi

