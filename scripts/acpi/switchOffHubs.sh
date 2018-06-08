#!/bin/sh

tee /sys/bus/pci/devices/0000\:0*/power/wakeup <<EOF
disabled
EOF

echo $(grep enabled /proc/acpi/wakeup | cut -f 1) > /proc/acpi/wakeup

