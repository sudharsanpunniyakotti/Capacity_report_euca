#!/bin/sh
ansible nc-a -m fetch -a "src=/etc/eucalyptus/eucalyptus.conf dest=/root/capacity-a/{{ inventory_hostname }}   flat=yes"
ansible nc-b -m fetch -a "src=/etc/eucalyptus/eucalyptus.conf dest=/root/capacity-b/{{ inventory_hostname }}   flat=yes"
ansible nc-c -m fetch -a "src=/etc/eucalyptus/eucalyptus.conf dest=/root/capacity-c/{{ inventory_hostname }}   flat=yes"
ansible nc-d -m fetch -a "src=/etc/eucalyptus/eucalyptus.conf dest=/root/capacity-d/{{ inventory_hostname }}   flat=yes"

cat /root/capacity-a/ustlsaime* | grep MAX_CORES | sed 's/MAX_CORES=//g' | sed 's/"//g'| while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/core.a
cat /root/capacity-b/ustlsaime* | grep MAX_CORES | sed 's/MAX_CORES=//g' | sed 's/"//g'| while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/core.b
cat /root/capacity-c/ustlsaime* | grep MAX_CORES | sed 's/MAX_CORES=//g' | sed 's/"//g'| while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/core.c
cat /root/capacity-d/ustlsaime* | grep MAX_CORES | sed 's/MAX_CORES=//g' | sed 's/"//g'| while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/core.d


ansible nc-a -m shell  -a " free -m | grep Mem " | grep -v success | awk '{print$2}'  | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/mem.a
ansible nc-b -m shell  -a " free -m | grep Mem " | grep -v success | awk '{print$2}'  | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/mem.b
ansible nc-c -m shell  -a " free -m | grep Mem " | grep -v success | awk '{print$2}'  | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/mem.c
ansible nc-d -m shell  -a " free -m | grep Mem " | grep -v success | awk '{print$2}'  | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/mem.d


ansible nc-a -m shell -a "nproc " | grep -v success | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/hardware.a
ansible nc-b -m shell -a "nproc " | grep -v success | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/hardware.b
ansible nc-c -m shell -a "nproc " | grep -v success | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/hardware.c
ansible nc-d -m shell -a "nproc " | grep -v success | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1 > /root/capacity/hardware.d


ansible clc -m synchronize  -a " src=/root/capacity  dest=/tmp/ "
