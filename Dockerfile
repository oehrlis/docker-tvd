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

# copy all scripts
ADD scripts /opt/docker/bin/

# image setup via shell script to reduce layers and optimize final disk usage
RUN /opt/docker/bin/setup_tvd.sh