#!/bin/bash

FTP_SUNET=ftp.sunet.se
GW_GU=gu151a-gw.net.gu.se
WWW_COMHEM=www.comhem.se
WWW_CHALMERS=www.chalmers.se
NS1_CHALMERS=ns1.chalmers.se
HOSTS_TO_CHECK="ftp.sunet.se gu151a-gw.net.gu.se www.comhem.se www.chalmers.se ns1.chalmers.se "

ONLY_ETH=true
INTERFACE="cable eth"
WAIT=20

# Your interface name will vary
WLAN_DEVICE="wlan0"
# On ubuntu, this is needed too:
RESTART_NETWORK_DRIVERS='rmmod iwlmvm iwlwifi && modprobe iwlmvm iwlwifi'
# Your interface name will vary
ETH_DEVICE="enx00e112000cee"

LOG_FILE="/tmp/network-stats.log"

wait_for_network(){
    while ! host $NS1_CHALMERS &> /dev/null
    do
        sleep 1;
    done
}

bring_if(){
    IF=$1
    DIRECTION=$2
    ip link set dev $IF $DIRECTION
    # Needed on ubuntu for some reason
    rmmod iwlmvm iwlwifi &> /dev/null
    modprobe iwlmvm iwlwifi &> /dev/null
}

check_host(){
    host=$1
    echo "================="
    echo "Pinging $host using $INTERFACE"
    ping -c 1 $host 2>&1
    echo "================="
    echo "mtr $host using $INTERFACE"
    mtr -c 3 -r $host 2>&1
}

modprobe iwlmvm iwlwifi
wait_for_network
bring_if $ETH_DEVICE up
wait_for_network
bring_if $WLAN_DEVICE up
while true
do
    if $ONLY_ETH
    then
        echo "===Only cable==="
        bring_if $WLAN_DEVICE down
        echo -n "bringing up eth..."
        bring_if $ETH_DEVICE up
        wait_for_network
        echo "eth up."
        INTERFACE="cable eth"
        ONLY_ETH=false
    else
        echo "===Only wlan==="
        bring_if $ETH_DEVICE down
        echo -n "bringing up wlan0..."
        bring_if $WLAN_DEVICE up
        wait_for_network
        echo "wlan0 up."        
        INTERFACE="wireless wlan"
        ONLY_ETH=true
    fi
    echo
    echo "Running diagnostics using $INTERFACE"
    echo

    for host in $HOSTS_TO_CHECK
    do
        check_host $host
    done
    echo
    echo "Waiting $WAIT seconds until next round"
    sleep $WAIT
done >> $LOG_FILE

