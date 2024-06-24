#! /bin/bash

actual=/sys/class/backlight/intel_backlight/actual_brightness;

add_value=$1;

current=$(cat $actual)

echo $(($current + $add_value)) > /sys/class/backlight/intel_backlight/brightness;
