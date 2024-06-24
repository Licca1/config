#! /bin/python3

import subprocess
from functools import reduce 

DEVICE_PATH="/org/freedesktop/UPower/devices/DisplayDevice"

res = subprocess.run(["upower", "-i", DEVICE_PATH], capture_output=True)

lines = res.stdout.decode('ascii').split("\n")

def parse_line(s):
    s = s.strip()
    a = ' '.join(s.split()).split(": ")
    if len(a) != 2:
        return None

    k, v = a
    return {k: v} 

def combine_dict(acc, v):
    if not v:
        return acc
    return {**acc, **v}

a = reduce(combine_dict, list(map(parse_line, lines)))


# lol crutch
value_percent = int(a["percentage"].split(".")[0].split("%")[0])
value_time = a.get("time to empty", None)

if value_time != None:
    value_time = f" {value_time}"
else:
    value_time = ""
color = "green"

if value_percent < 20:
    color = "orange"
elif value_percent < 10:
    color = "red"

if a["state"] == "charging":
    color = "white"

print(f"<fc={color}>{value_percent}%{value_time}</fc>")
