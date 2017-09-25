#!/bin/bash
# ----------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ----------------------------------------------------------------------
# Name.......: setup_tvd.sh 
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2017.09.22
# Revision...: 
# Purpose....: Setup script for docker base image 
# Notes......: --
# Reference..: --
# License....: CDDL 1.0 + GPL 2.0
# ----------------------------------------------------------------------
# Modified...: 
# see git revision history for more information on changes/updates
# TODO.......: 
# ----------------------------------------------------------------------

# ignore secure linux (not available on slim linux
#setenforce Permissive

# define environment variables
export ORACLE_ROOT=/u00             # oracle root directory
export ORACLE_DATA=/u01             # oracle data directory
export ORACLE_BASE=/u00/app/oracle  # oracle base directory

# create oracle groups
groupadd --gid 1000 oinstall
groupadd --gid 1010 osdba
groupadd --gid 1020 osoper
groupadd --gid 1030 osbackupdba
groupadd --gid 1040 oskmdba
groupadd --gid 1050 osdgdba

# create oracle user
useradd --create-home --gid oinstall --shell /bin/bash \
    --groups oinstall,osdba,osoper,osbackupdba,osdgdba,oskmdba \
    oracle

# create oracle directories
mkdir -p $ORACLE_ROOT
mkdir -p $ORACLE_DATA
mkdir -p $ORACLE_BASE
mkdir -p $ORACLE_BASE/admin         # softlink to volume
mkdir -p $ORACLE_BASE/audit         # softlink to volume
mkdir -p $ORACLE_BASE/cfgtoollogs
mkdir -p $ORACLE_BASE/diag          # softlink to volume
mkdir -p $ORACLE_BASE/etc           # softlink to volume
mkdir -p $ORACLE_BASE/local
mkdir -p $ORACLE_BASE/network       # softlink to volume
mkdir -p $ORACLE_BASE/product

# create an oraInst.loc file
echo "inventory_loc=$ORACLE_BASE/oraInventory" > $ORACLE_BASE/etc/oraInst.loc
echo "inst_group=oinstall" >> $ORACLE_BASE/etc/oraInst.loc

# create a generic response file for OUD/WLS
echo "[ENGINE]" > $ORACLE_BASE/etc/install.rsp
echo "Response File Version=1.0.0.0.0" >> $ORACLE_BASE/etc/install.rsp
echo "[GENERIC]" >> $ORACLE_BASE/etc/install.rsp
echo "DECLINE_SECURITY_UPDATES=true" $ORACLE_BASE/etc/install.rsp
echo "SECURITY_UPDATES_VIA_MYORACLESUPPORT=false" >> $ORACLE_BASE/etc/install.rsp

# change permissions and ownership
chmod a+xr $ORACLE_ROOT $ORACLE_DATA
chown oracle:oinstall -R $ORACLE_ROOT $ORACLE_DATA

# update existing packages
yum upgrade -y

# install basic packages util-linux, libaio 
yum install -y libaio util-linux hostname which tar sudo

# intall oracle preinstall package
#yum install -y oracle-database-server-12cR2-preinstall

# install perl packages
#yum install -y perl perl-core perl-IO-Socket-SSL \

# clean up
yum clean all
rm -rf /var/cache/yum