"""
We use the aircrack-ng tool for the following purposes:

1. Start & stop wireless interface in monitor mode.
2. Find networks protected by WEP.
3. Capture packets from these networks.
4. Crack the WEP Key
"""
import subprocess

def start_monitor_mode(interface_name):
    subprocess.call(['airmon-ng', 'start', interface_name])

def stop_monitor_mode(interface_name):
    subprocess.call(['airmon-ng', 'stop', interface_name])



