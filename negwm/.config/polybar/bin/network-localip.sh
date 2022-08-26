#!/bin/sh

local_interface=$(ip route | awk '/^default/{print $5}')
local_ip=$(ip addr show "$local_interface" | grep -w "inet" | awk '{ print $2; }' | sed 's/\/.*$//')

echo "$local_ip"
