#!/bin/sh
export DATE=`date +%Y%m%d-%H%M-UTC`

echo "IP DETAILS" >> $DATE-Capacity-EUCA.csv

export totalip=`euca-describe-addresses verbose --region=admin@localhost | wc -l`
export ipused=`euca-describe-addresses verbose --region=admin@localhost| grep i- | wc -l`
export ipunused=`euca-describe-addresses verbose --region=admin@localhost | grep nobody  | wc -l`
export reservedip=`euca-describe-addresses verbose --region=admin@localhost | grep -v 'i-'  | grep -v nobody | wc -l`


echo "TOTAL_IP,USED_IP,IP_UNSED,RESERVED_IP" >> $DATE-Capacity-EUCA.csv
echo "$totalip,$ipused,$ipunused,$reservedip"  >> $DATE-Capacity-EUCA.csv



export usedcorea=`cat /tmp/capacity/instance.all | grep us-EUCA-1a | awk '{print$6}' | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1`
export usedcoreb=`cat /tmp/capacity/instance.all | grep us-EUCA-1b | awk '{print$6}' | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1`
export usedcorec=`cat /tmp/capacity/instance.all | grep us-EUCA-1c | awk '{print$6}' | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1`
export usedcored=`cat /tmp/capacity/instance.all | grep us-EUCA-1d | awk '{print$6}' | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1`

export totalcorea=`cat /tmp/capacity/core.a`
export totalcoreb=`cat /tmp/capacity/core.b`
export totalcorec=`cat /tmp/capacity/core.c`
export totalcored=`cat /tmp/capacity/core.d`


let freecorea=$totalcorea-$usedcorea
let freecoreb=$totalcoreb-$usedcoreb
let freecorec=$totalcorec-$usedcorec
let freecored=$totalcored-$usedcored






export usedmema=`cat /tmp/capacity/instance.all | grep us-EUCA-1a | awk '{print$7}' | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1`
export usedmemb=`cat /tmp/capacity/instance.all | grep us-EUCA-1b | awk '{print$7}' | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1`
export usedmemc=`cat /tmp/capacity/instance.all | grep us-EUCA-1c | awk '{print$7}' | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1`
export usedmemd=`cat /tmp/capacity/instance.all | grep us-EUCA-1d | awk '{print$7}' | while read a; do let y=$a+${y:-0}; echo $y;done | tail -1`

export totalmema=`cat /tmp/capacity/mem.a`
export totalmemb=`cat /tmp/capacity/mem.b`
export totalmemc=`cat /tmp/capacity/mem.c`
export totalmemd=`cat /tmp/capacity/mem.d`

let freemema=$totalmema-$usedmema
let freememb=$totalmemb-$usedmemb
let freememc=$totalmemc-$usedmemc
let freememd=$totalmemd-$usedmemd

export physicalcorea=`cat /tmp/capacity/hardware.a`
export physicalcoreb=`cat /tmp/capacity/hardware.b`
export physicalcorec=`cat /tmp/capacity/hardware.c`
export physicalcored=`cat /tmp/capacity/hardware.d`



echo "CORES AND MEMORY DETAILS" >> $DATE-Capacity-EUCA.csv

echo "ZONES,PHYSICAL_CORES,TOTAL_CORES,USED_CORES,FREE_CORES,TOTAL_MEM,USED_MEM,FREE_MEM"  >> $DATE-Capacity-EUCA.csv
echo "Zone-A,$physicalcorea,$totalcorea,$usedcorea,$freecorea,$totalmema,$usedmema,$freemema" >> $DATE-Capacity-EUCA.csv
echo "Zone-B,$physicalcoreb,$totalcoreb,$usedcoreb,$freecoreb,$totalmemb,$usedmemb,$freememb" >> $DATE-Capacity-EUCA.csv
echo "Zone-C,$physicalcorec,$totalcorec,$usedcorec,$freecorec,$totalmemc,$usedmemc,$freememc" >> $DATE-Capacity-EUCA.csv
echo "Zone-D,$physicalcored,$totalcored,$usedcored,$freecored,$totalmemd,$usedmemd,$freememd" >> $DATE-Capacity-EUCA.csv




echo "Please the attachement of Capacity  Report in EUCA for $DATE "| mailx -s " Capacity Report-EUCA " -a  $DATE-Capacity-EUCA.csv  -r sudharsanpunniyakotti@gmail.com sudharsanpunniyakotti@gmail.com
