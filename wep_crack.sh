header() {
    clear
    echo "========================================\n"
    echo "WEP encrypted Wi-Fi Access Point Cracker\n"
    echo "========================================\n"    
}


scan_access_point() {
    # TODO
    echo "Displaying access points"
}


crack_access_point() {
    # TODO
}


select_options() {
    echo "[!] Please select an option below to get started.\n\n"
    echo "1) Scan access points nearby and crack"
    echo "2) Crack access point with BSSID"
    echo "\nEnter your option: "
    read user_option

    if [[ "$user_option" = "1" ]];
        then
        header
        echo "Scanning nearby access points..."
        # This makes the user select an access point and sets its BSSID in
        # $required_bssid
        scan_access_point
        crack_access_point $required_bssid
    elif [[ "$user_option" = "2" ]];
        then
        header
        echo "Enter BSSID of the access point:"
        read $required_bssid
        crack_access_point $required_bssid
    fi
}


scan_and_crack() {
    echo "Scan and crack"
}


crack_access_point() {
    echo "Crack BSSID"
}

# Display header and options
header
select_options

# Let user select an interface

# Let user select access point

# Crack the WEP-encrypted access point

# 

