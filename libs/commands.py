"""
We use the aircrack-ng tool for the following purposes:

1. Start & stop wireless interface in monitor mode.
2. Find networks protected by WEP.
3. Capture packets from these networks.
4. Crack the WEP Key
"""
import subprocess
from ..settings import PACKET_DUMP_PATH


def start_monitor_mode(interface_name):
    subprocess.call(['airmon-ng', 'start', interface_name])

def stop_monitor_mode(interface_name):
    subprocess.call(['airmon-ng', 'stop', interface_name])

def list_access_points(monitor_interface_name):
    return subprocess.check_output(['airodump-ng', monitor_interface_name])

def capture_and_dump_packets(monitor_interface_name, bssid, channel,
                             filename=PACKET_DUMP_PATH, required_packets=20000):
    p = subprocess.Popen(
        'airodump-ng', monitor_interface_name,
         '--bssid {}'.format(str(bssid)),
         '-c {}'.format(int(channel)),
         '-w {}'.format(str(filename)),
        shell=True
    )
    return p.pid

