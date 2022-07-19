#!/bin/bash -e
# Author: YuriiS Updated: IsaacN
# Date: 2018-12-13
#set -x

#check if nvme-cli is installed
if ! which nvme >/dev/null ; then
	echo "ERR: install nvme-cli package" >&2
	exit 1
fi

# Create ram disks if needed
# rd_num=2 # number of disks
# rd_sz=2097152 # fixed size of 2M
# modprobe -rv brd
# modprobe brd rd_nr=$rd_num rd_size=$rd_sz

NVMEDIR=/sys/kernel/config/nvmet
NVMESUBS=${NVMEDIR}/subsystems
NVMEPORTS=${NVMEDIR}/ports

#default values
SUBSYSNAME=MySubsys
SSD_DEV=/dev/nvme0n1
NSID=1
PORTADDR=4420
PORTID=1
IFACE=ib0
OFFLOAD=""

#Functions

function usage() {
    SCRPTNAME=$0
    echo "${SCRPTNAME}"
    echo "   : Configure the server for NVMe-oF target access."
    echo "   : -s <Subsystem name>"
    echo "   : -d <Local device>"
    echo "   : -n <Namespace ID>"
    echo "   : -a <Port Address (IP port number)>"
    echo "   : -p <Port ID>"
    echo "   : -i <Interface name (e.g. ib0)>"
    echo "   : --stop,  Remove all targets"
    echo "   : -h, --help (This list)"
    echo
    echo " "
    exit 0
}


function cleanup() {
    echo "Removing active NVMe-oF subsystems ..."
    rm -f ${NVMEPORTS}/*/subsystems/* 2> /dev/null
    rmdir ${NVMEPORTS}/* 2> /dev/null
    rmdir ${NVMESUBS}/*/namespaces/* 2> /dev/null
    rmdir ${NVMESUBS}/*/ 2> /dev/null
    modprobe -r nvme_rdma nvmet_rdma nvmet nvme nvme_core
    modprobe nvme
    exit 0
}

function wait_for_file() {
   file=$1
   x=0
   while [ ! -e ${file} ]; do
     if [ $x == 0 ]; then
	echo -ne "\033[0K\r"
	echo -n "Waiting for ${file} to appear     "
	echo -ne "\033[0K\r"	
	echo -n "Waiting for ${file} to appear "	
     elif [ $x == 5 ]; then
	x=-1
     else
	echo -n "."
     fi
     x=$((x+1))
     sleep 0.5
   done
   echo
}

function configure_one_port()
{
    local subsys=$1
    local ipaddr=$2
    local port=$3
    local rdma_port=$4

    if test -z "$ipaddr" ; then
        return
    fi

    if [ ! -d ${NVMEPORTS}/$port ] ; then
       mkdir /sys/kernel/config/nvmet/ports/$port
       echo -n ipv4 >${NVMEPORTS}/$port/addr_adrfam
       echo -n $ipaddr >${NVMEPORTS}/$port/addr_traddr
       echo -n $rdma_port >${NVMEPORTS}/$port/addr_trsvcid
       echo -n rdma >${NVMEPORTS}/$port/addr_trtype
       ln -s ${NVMESUBS}/$subsys/ ${NVMEPORTS}/$port/subsystems/$subsys
    fi
}

function make_subsys()
{
  local subsys=$1
  test -d ${NVMESUBS}/$subsys || \
  	mkdir ${NVMESUBS}/$subsys
  echo 1  > ${NVMESUBS}/$subsys/attr_allow_any_host
}

function add_namespace()
{
  local subsys=$1
  local ns=$2
  local blkdev=$3
  uuid=`uuidgen`

  test -d ${NVMESUBS}/$subsys/namespaces/$ns || \
  	mkdir ${NVMESUBS}/$subsys/namespaces/$ns
  wait_for_file     ${NVMESUBS}/$subsys/namespaces/$ns/device_path
  echo -n $blkdev > ${NVMESUBS}/$subsys/namespaces/$ns/device_path
  echo -n $uuid >   ${NVMESUBS}/$subsys/namespaces/$ns/device_nguid
  if [ ! -z $OFFLOAD ]; then
    echo 1 > ${NVMESUBS}/$subsys/attr_offload
  fi
  # echo -n "$subsys/ns/$ns: "
  # ls ${NVMESUBS}/$subsys/namespaces/$ns/
  wait_for_file     ${NVMESUBS}/$subsys/namespaces/$ns/enable
  sleep 0.5
  echo -n 1  >      ${NVMESUBS}/$subsys/namespaces/$ns/enable
}

# handle args
OPTS=`getopt -o s:d:n:a:p:i:o:h --long stop,help -n "$0" -- "$@"`

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

eval set -- "$OPTS"

while true; do
    case "$1" in
	-s ) SUBSYSNAME="$2";shift;shift;;
	-d ) SSD_DEV="$2";shift;shift;;
  -n ) NSID="$2";shift;shift;;
	-a ) PORTADDR="$2"; shift;shift ;;
	-p ) PORTID="$2"; shift;shift ;;
	-i ) IFACE="$2"; shift;shift ;;
	-o ) OFFLOAD="offload_buffer_size=$2"; modprobe -r nvmet-rdma;shift;shift ;;
	--stop) cleanup;shift;;  
	-h | --help ) usage;shift;;
	-- ) shift; break ;;
	* ) break ;;
    esac
done

ipaddr=`ip a l $IFACE |awk '$1 == "inet" {print $2}'`
ipaddr=${ipaddr%/*}

printf " Subsystem name:              %s\n" $SUBSYSNAME
printf " Local device:                %s\n" $SSD_DEV
printf " Namespace ID:                %s\n" $NSID
printf " Service ID (IP port number): %s\n" $PORTADDR
printf " Port ID:                     %s\n" $PORTID
printf " IP interface:                %s\n" $IFACE
printf " IP Address:                  %s\n" $ipaddr
if [ ! -z $OFFLOAD ]; then printf $OFFLOAD; fi

if ! lsmod|grep nvmet > /dev/null ; then
#  modprobe -r nvme
  modprobe nvmet
  modprobe nvmet-rdma $OFFLOAD
fi


# Main 
make_subsys $SUBSYSNAME
configure_one_port $SUBSYSNAME $ipaddr $PORTID $PORTADDR
add_namespace $SUBSYSNAME $NSID $SSD_DEV

