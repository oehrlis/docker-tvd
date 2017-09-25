# Docker Base Image for Trivadis Engineering
Docker base image for Orace Database, Unified Directory, WebLogic and more

## Content

This docker image is based on the official Oracle Linux slim image ([oraclelinux](https://hub.docker.com/r/_/oraclelinux/)). It has been extended with the following Linux packages and configuration:

* Upgrade of all installed packages to the latest release (yum upgrade)
* Install the following additional packages including there dependencies:
    * *util-linux* A collection of basic system utilities
    * *libaio* Linux-native asynchronous I/O access library
    * *hostname* Utility to set/show the host name or domain name
    * *which* Displays where a particular program in your path is located
    * *unzip* A utility for unpacking zip files
    * *zip* A file compression and packaging utility compatible with PKZIP
    * *tar* A GNU file archiving program
    * *sudo* Allows restricted root access for specified users
    * *perl* Practical Extraction and Report Language
    * *perl-core* Base perl metapackage
    * *perl-IO-Socket-SSL* Perl library for transparent SSL
    * *oracle-database-server-12cR2-preinstall* Sets the system for Oracle Database single instance and Real Application Cluster install for Oracle Linux 7
* Dedicated groups for user *oracle*, oinstall (gid 1000), osdba (gid 1010), osoper (gid 1020), osbackupdba (gid 1030), oskmdba (gid 1040), osdgdba (gid 1050)
* Operating system user *oracle* (uid 1000)
* Add oracle to the sudoers *ALL=(ALL)*
* Oracle Inventory file *oraInst.loc* in *$ORACLE_BASE/etc/oraInst.loc*
* Generic ResponseFile *install.rsp* in *$ORACLE_BASE/etc/install.rsp* used for OUD and FMW installations.
* Create of Oracle OFA Directories see below.

The purpose of this image is provide common base image for any kind of engineering with Oracle Database, Oracle Unified Directory and Oracle Fusion Middleware. The following docker images are based on this images or build with similar structures.

   * [oehrlis/docker-oud](https://github.com/oehrlis/docker-oud)
   * [oehrlis/docker-oudsm](https://github.com/oehrlis/docker-oudm)

## Environment Variable and Directories

The following environment variable have been used for the installation:

Environment variable | Value / Directories         | Comment
-------------------- | --------------------------- | ---------------
ORACLE_ROOT          | ```/u00```                  | Root directory for all the Oracle software
ORACLE_BASE          | ```/u00/app/oracle```       | Oracle base directory
n/a                  | ```$ORACLE_BASE/product```  | Oracle product base directory
ORACLE_BASE          | ```$ORACLE_BASE/local```    | Oracle base directory
ORACLE_DATA          | ```/u01```                  | Root directory for the persistent data eg. database, OUD instances etc. A docker volumes must be defined for /u01

## Installation and build
The docker image can be build manually based on [oehrlis/docker-tvd](https://github.com/oehrlis/docker-tvd) from GitHub or pull from the public repository [oehrlis/tvd](https://hub.docker.com/r/oehrlis/tvd/) on DockerHub.

* Manual build the image based on the source from GitHub ([oehrlis/docker-tvd](https://github.com/oehrlis/docker-tvd)).

		docker build -t oehrlis/tvd .

* Pull the image from Docker hub.

		docker pull oehrlis/tvd

* Create a new named container and run it interactive (-i -t)

		docker run -v [<host mount point>:]/u01 --name TVD-engineering oehrlis/tvd
		docker start -ai TVD-engineering

## Issues

Please file your bug reports, enhancement requests, questions and other support requests within [Github's issue tracker](https://help.github.com/articles/about-issues/):

* [Existing issues](https://github.com/oehrlis/docker-tvd/issues)
* [submit new issue](https://github.com/oehrlis/docker-tvd/issues/new)

## License

docker-tvd is licensed under the Apache License, Version 2.0. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>.

See [OTN Developer License Terms](http://www.oracle.com/technetwork/licenses/standard-license-152015.html) and [Oracle Database Licensing Information User Manual](https://docs.oracle.com/database/122/DBLIC/Licensing-Information.htm#DBLIC-GUID-B6113390-9586-46D7-9008-DCC9EDA45AB4) regarding Oracle Database licenses.
