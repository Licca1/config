#! /bin/python3

import subprocess

def get_pia_value(key):
    res = subprocess.run(["piactl", "get", key], capture_output=True)
    lines = res.stdout.decode('ascii').split("\n")
    return lines[0]

is_connected = True if get_pia_value("connectionstate") == "Connected" else False

if not is_connected:
    print(f"")
else:
    ip = get_pia_value("vpnip")
    region = get_pia_value("region")
    if ip == "Unknown":
        ip = "N/A"
    print(f"{ip}")
