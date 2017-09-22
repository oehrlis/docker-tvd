# ----------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ----------------------------------------------------------------------
# Name.......: Dockerfile 
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2017.09.22
# Revision...: 
# Purpose....: Dockerfile to build a base image for oud, wls and oudsm
# Notes......: --
# Reference..: --
# License....: Apache License, Version 2.
# ----------------------------------------------------------------------
# Modified...:
# see git revision history for more information on changes/updates
# TODO.......:
# - add oud or base env
# ----------------------------------------------------------------------

# Pull base image
# ----------------------------------------------------------------------
FROM oraclelinux:7-slim

# Maintainer
# ----------------------------------------------------------------------
MAINTAINER Stefan Oehrli <stefan.oehrli@trivadis.com>

#Common ENV
# ----------------------------------------------------------------------
ENV ORACLE_ROOT=/u00 \
    ORACLE_DATA=/u01 \
    ORACLE_BASE=/u00/app/oracle

# Setup user, directory and update yum packages
# ----------------------------------------------------------------------
RUN mkdir -p $ORACLE_ROOT $ORACLE_DATA $ORACLE_BASE && \ 
    chmod a+xr $ORACLE_ROOT $ORACLE_DATA && \

# create oracle groups
    groupadd --gid 1000 oinstall && \
    groupadd --gid 1010 osdba && \
    groupadd --gid 1020 osoper && \
    groupadd --gid 1030 osbackupdba && \
    groupadd --gid 1040 oskmdba && \
    groupadd --gid 1050 osdgdba && \

# create oracle user
    useradd --create-home --gid oinstall --shell /bin/bash \
        --groups oinstall,osdba,osoper,osbackupdba,osdgdba,oskmdba \
        oracle && \

# create oracle directories
    mkdir -p $ORACLE_BASE/etc $ORACLE_BASE/local && \
    chown oracle:oinstall -R $ORACLE_ROOT $ORACLE_DATA && \

# create an oraInst.loc file
    echo "inventory_loc=$ORACLE_BASE/oraInventory" > $ORACLE_BASE/etc/oraInst.loc && \
    echo "inst_group=oinstall" >> $ORACLE_BASE/etc/oraInst.loc && \

# update existing packages
    yum upgrade -y && \
# install util-linux, libaio, perl and Oracle 12.2 PreInstall 
    yum install -y oracle-database-server-12cR2-preinstall \
        libaio perl perl-core perl-IO-Socket-SSL util-linux && \
    yum clean all && \
    rm -rf /var/cache/yum

# Prepare oracle environment 
# ----------------------------------------------------------------------
USER oracle

VOLUME ["$ORACLE_DATA"]

# Define default command to start script.
# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]