<?php
/*
 *  FOG  is a computer imaging solution.
 *  Copyright (C) 2007  Chuck Syperski & Jian Zhang
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *   config.php location: /var/www/fog/commons
 */

define( "IS_INCLUDED", true );
define( "TFTP_HOST", "192.168.1.102" );
define( "TFTP_FTP_USERNAME", "fog" );
define( "TFTP_FTP_PASSWORD", "6f9c760697d2cbec277668ef98a4480a" );
define( "TFTP_PXE_CONFIG_DIR", "/tftpboot/pxelinux.cfg/" );
define( "TFTP_PXE_KERNEL_DIR", "/tftpboot/fog/kernel/" );
define( "PXE_KERNEL", "fog/kernel/bzImage" );
define( "PXE_KERNEL_RAMDISK", 127000 ); 
define( "USE_SLOPPY_NAME_LOOKUPS", "1");
define( "MEMTEST_KERNEL", "fog/memtest/memtest" );
define( "PXE_IMAGE",  "fog/images/init.gz" );
define( "PXE_IMAGE_DNSADDRESS",  "192.168.1.1" );
define( "STORAGE_HOST", "192.168.1.102" );
define( "STORAGE_FTP_USERNAME", "fog" );
define( "STORAGE_FTP_PASSWORD", "6f9c760697d2cbec277668ef98a4480a" );
define( "STORAGE_DATADIR", "/images/" );
define( "STORAGE_DATADIR_UPLOAD", "/images/dev/" );
define( "STORAGE_BANDWIDTHPATH", "/fog/status/bandwidth.php" );
define( "CLONEMETHOD", "ntfsclone" );  // valid values partimage, ntfsclone
define( "UPLOADRESIZEPCT", 5 ); 
define( "WEB_HOST", "192.168.1.102" );
define( "WEB_ROOT", "/fog/" );
define( "WOL_HOST", "192.168.1.102" ); 	
define( "WOL_PATH", "/fog/wol/wol.php" );   
define( "WOL_INTERFACE", "eth0" );
define( "SNAPINDIR", "/opt/fog/snapins/" );
define( "QUEUESIZE", "10" );
define( "CHECKIN_TIMEOUT", 600 );
define( "MYSQL_HOST", "localhost" );
define( "MYSQL_DATABASE", "fog" );
define( "MYSQL_USERNAME", "fog-usr" );
define( "MYSQL_PASSWORD", "random-mysql-password" );
define( "DB_TYPE", "mysql" );
define( "DB_HOST", MYSQL_HOST );
define( "DB_NAME", MYSQL_DATABASE );
define( "DB_USERNAME", MYSQL_USERNAME );
define( "DB_PASSWORD", MYSQL_PASSWORD );
define( "DB_PORT", null );
define( "USER_MINPASSLENGTH", 4 );
define( "USER_VALIDPASSCHARS", "1234567890ABCDEFGHIJKLMNOPQRSTUVWZXYabcdefghijklmnopqrstuvwxyz_hB()^!" );
define( "NFS_ETH_MONITOR", "eth0" );
define("UDPCAST_INTERFACE","eth0");
define("UDPCAST_STARTINGPORT", 63100 ); 					// Must be an even number! recommended between 49152 to 65535
define("FOG_MULTICAST_MAX_SESSIONS", 64 );
define( "FOG_JPGRAPH_VERSION", "2.3" );
define( "FOG_REPORT_DIR", "./reports/" );
define( "FOG_THEME", "blackeye/blackeye.css" );
define( "FOG_UPLOADIGNOREPAGEHIBER", "1" );
define( "FOG_VERSION", "0.32" );
define( "FOG_SCHEMA", 23);
DEFINE('BASEPATH', rtrim($_SERVER['DOCUMENT_ROOT'], '/') . rtrim(WEB_ROOT, '/'));
?>
