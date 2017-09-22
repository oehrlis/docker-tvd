# Docker Base Image for Trivadis Engineering
Docker base image for Orace Database, Unified Directory and WebLogic

## Content

This docker image is based on the official Oracle Linux slim image ([oraclelinux](https://hub.docker.com/r/_/oraclelinux/)). It has been extended with the following Linux packages and configuration:

* Update of Oracle Linux from the 
* Additional Packages including there dependencies installed:
    * *oracle-database-server-12cR2-preinstall* Sets the system for Oracle Database single instance and Real Application Cluster install for Oracle Linux 7
    * *util-linux* A collection of basic system utilities
    * *libaio* Linux-native asynchronous I/O access library
    * *perl* Practical Extraction and Report Language
    * *perl-core* Base perl metapackage
    * *perl-IO-Socket-SSL* Perl library for transparent SSL
* Operating system user *oracle* (uid 1000)
* Dedicated groups for user *oracle*, oinstall (gid 1000), osdba (gid 1010), osoper (gid 1020), osbackupdba (gid 1030), oskmdba (gid 1040), osdgdba (gid 1050)
* Oracle OFA Directories see below.
* Oracle Inventory file *oraInst.loc* in *$ORACLE_BASE/etc/oraInst.loc*

The purpose of this image is provide common base image for any kind of engineering with Oracle Database, Oracle Unified Directory and Oracle Fusion Middleware. The intended use is for other images such as

   * [oehrlis/docker-oud](https://github.com/oehrlis/docker-oud)

## Environment Variable and Directories

The following environment variable have been used for the installation:

Environment variable | Value / Directories | Comment
-------------------- | ------------------- | ---------------
ORACLE_ROOT | ```/u00``` | Root directory for all the Oracle software
ORACLE_DATA | ```/u01``` | Root directory for the persistent data eg. database, OUD instances etc. A docker volumes is defined for /u01
ORACLE_BASE | ```/u00/app/oracle``` | Oracle base directory

## Issues

Please file your bug reports, enhancement requests, questions and other support requests within [Github's issue tracker](https://help.github.com/articles/about-issues/): 

* [Existing issues](https://github.com/oehrlis/docker-tvd/issues)
* [submit new issue](https://github.com/oehrlis/docker-tvd/issues/new)

## License

docker-tvd is licensed under the Apache License, Version 2.0. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>. 

See [OTN Developer License Terms](http://www.oracle.com/technetwork/licenses/standard-license-152015.html) and [Oracle Database Licensing Information User Manual](https://docs.oracle.com/database/122/DBLIC/Licensing-Information.htm#DBLIC-GUID-B6113390-9586-46D7-9008-DCC9EDA45AB4) regarding Oracle Database licenses.
