header() {
    clear
    echo "========================================\n"
    echo "WEP encrypted Wi-Fi Access Point Cracker\n"
    echo "========================================\n"    
}


select_options() {
    echo "[!] Please select an option below to get started.\n\n"
    echo "1) Scan access points nearby and crack"
    echo "2) Crack access point with BSSID"
    echo "\nEnter your option: "
    read user_option

    find_wifi_interface
    start_interface_in_monitor_mode $interface

    if [[ "$user_option" = "1" ]];
        then
        header
        echo "[+] Scanning nearby access points..."
        # This makes the user select an access point and sets its BSSID in
        # $required_bssid
        scan_access_point
        crack_access_point $required_bssid
    elif [[ "$user_option" = "2" ]];
        then
        header
        echo "[!] Enter BSSID of the access point:"
        read $required_bssid
        crack_access_point $required_bssid
    fi
}


find_wifi_interface() {
    echo "[+] Looking for interfaces.."
    interface_count=`ifconfig | awk '/wlan.*/ {print $1}' | wc -w`

    if [[ $interface_count -le 0 ]];
        then
        echo "[!] No interfaces found. Manually enter name of interface:"
        read interface
    elif [[ $interface_count -ge 2 ]];
        then
        echo "[!] Select an interface from:"
        echo "`ifconfig | awk '/wlan.*/ {print \" \" $1}'`"
        read interface
    else
        interface=`ifconfig | awk '/wlan.*/ {print $1}'`
        echo "[+] Found interface '$interface'"
        echo "[+] Proceeding with '$interface'..."
}


start_interface_in_monitor_mode() {
    echo "$1"
}


scan_access_point() {
    echo "Displaying access points"
}


crack_access_point() {
    # TODO
    echo "$1"
}


# Display header and options
header
select_options

# Let user select an interface

# Let user select access point

# Crack the WEP-encrypted access point

# 

