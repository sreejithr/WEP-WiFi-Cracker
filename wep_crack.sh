header() {
    clear
    echo "========================================\n"
    echo "WEP encrypted Wi-Fi Access Point Cracker\n"
    echo "========================================\n"    
}


select_options() {
    echo "[!] Please select an option below to get started.\n\n"
    echo "1) Scan access points nearby and crack\n"
    echo "2) Crack access point with BSSID\n"
    read user_option
    
    # Do according to user's selection
    if [[ "$user_option" = "1" ]];
        then
        header
        scan_and_crack
    elif [[ "$user_option" = "2" ]];
        then
        header
        crack_access_point
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

