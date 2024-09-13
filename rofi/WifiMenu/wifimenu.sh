#!/bin/bash

# Function to toggle WiFi on/off
toggle_wifi() {
    wifi_status=$(nmcli radio wifi)
    if [ "$wifi_status" = "enabled" ]; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
    fi
}

# Function to list available WiFi networks
list_networks() {
    nmcli device wifi list --rescan yes | awk 'NR>1 {print $2 "  | Signal: "$8 " | Sec: "$NF}' 
}

# Function to connect to a network
connect_to_network() {
    local ssid=$1
    # Check if the network is open or requires a password
    security=$(nmcli -g SECURITY dev wifi | grep -w "$ssid")

    if [[ "$security" == "--" ]]; then
        # Open network, no password needed
        nmcli device wifi connect "$ssid"
    else
        # Secured network, prompt for password
        password=$(rofi -dmenu -password -p "Enter WiFi password for $ssid")
        nmcli device wifi connect "$ssid" password "$password"
    fi

    # Provide feedback using notify-send (optional)
    if [ $? -eq 0 ]; then
        notify-send "WiFi" "Successfully connected to $ssid"
    else
        notify-send "WiFi" "Failed to connect to $ssid"
    fi
}

# List of WiFi networks
wifi_networks=$(list_networks)

# Main menu with prompt for the toggle
chosen=$(echo "$wifi_networks" | rofi -dmenu -p "WiFi Menu")

# Detect if 'toggle' is entered in the prompt to toggle WiFi
if [[ "$chosen" == "toggle" ]]; then
    toggle_wifi
else
    ssid=$(echo $chosen | awk '{print $1}')  # Extract SSID
    if [ -n "$ssid" ]; then
        connect_to_network "$ssid"
    fi
fi
