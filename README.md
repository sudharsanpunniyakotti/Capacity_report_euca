# Capacity_report_euca
Capacity Report For Eucalyptus 

Ansible in Needed for this Script .

Run the collect_data.sh in ansible Master 
Run the capacity_final.sh on CLC 

Output Will look like this .

IP DETAILS							
TOTAL_IP	USED_IP	IP_UNSED	RESERVED_IP				
1722	1518	85	119				
CORES AND MEMORY DETAILS							
ZONES	PHYSICAL_CORES	TOTAL_CORES	USED_CORES	FREE_CORES	TOTAL_MEM	USED_MEM	FREE_MEM
Zone-A	280	270	270	0	838564	586959	251605
Zone-B	280	270	201	69	838576	535677	302899
Zone-C	1456	1404	1328	76	4677292	3673502	1003790
Zone-D	1456	1404	1224	180	4677292	3239756	1437536


Output will be in CSV 


