#!/bin/bash
chrt -f -p 54 $(pgrep ksoftirqd/0)
chrt -f -p 54 $(pgrep ksoftirqd/1)
chrt -f -p 54 $(pgrep ksoftirqd/2)
chrt -f -p 54 $(pgrep ksoftirqd/3)

echo 1000000 > /proc/sys/kernel/sched_latency_ns
echo 100000 > /proc/sys/kernel/sched_min_granularity_ns
echo 25000 > /proc/sys/kernel/sched_wakeup_granularity_ns

echo '@audio - rtprio 99' >> /etc/security/limits.conf
echo '@audio - memlock 512000' >> /etc/security/limits.conf
echo '@audio - nice -20' >> /etc/security/limits.conf

echo 'net.core.rmem_max = 16777216' >> /etc/sysctl.d/network-latency.conf
echo 'net.core.wmem_max = 16777216' >> /etc/sysctl.d/network-latency.conf

exit
