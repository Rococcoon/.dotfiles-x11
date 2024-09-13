#!/bin/bash

# Start temporary Rofi menu with loading icon
rofi -dmenu -p "loading" - theme ~/.config/rofi/HelloWorld/helloworld.rasi &

# Start Bluetooth scanning in the background
bluetoothctl scan on &
scan_pid=$!

# Function to stop scanning and cleanup
cleanup() {
  bluetoothctl discoverable off
  bluetoothctl scan off
  kill $scan_pid 2>/dev/null
}

# Trap EXIT to ensure cleanup happens on script exit
trap cleanup EXIT

# Allow some time for the scan to start
sleep 5

# Capture the output of 'bluetoothctl devices' into a variable
devices=$(bluetoothctl devices)

# Kill Loading Rofi menu
pkill rofi

# Print the captured devices to the terminal with a test message
printf "Bluetooth Devices List:\n%s\n" "$devices"

# Print the captured devices to rofi
printf "%s\n" "$devices" | rofi -dmenu -p "Select a Bluetooth device:" -theme ~/.config/rofi/HelloWorld/helloworld.rasi

# No need to explicitly stop scan here; cleanup function will handle it
