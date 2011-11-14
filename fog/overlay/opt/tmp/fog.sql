-- phpMyAdmin SQL Dump
-- version 3.3.2deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 12, 2011 at 01:19 AM
-- Server version: 5.1.41
-- PHP Version: 5.3.2-1ubuntu4.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fog`
--
USE `fog`;

-- --------------------------------------------------------

--
-- Table structure for table `aloLog`
--

CREATE TABLE IF NOT EXISTS `aloLog` (
  `alID` int(11) NOT NULL AUTO_INCREMENT,
  `alUserName` varchar(254) NOT NULL,
  `alHostID` int(11) NOT NULL,
  `alDateTime` datetime NOT NULL,
  `alAnon1` varchar(254) NOT NULL,
  `alAnon2` varchar(254) NOT NULL,
  `alAnon3` varchar(254) NOT NULL,
  PRIMARY KEY (`alID`),
  KEY `new_index` (`alUserName`),
  KEY `new_index2` (`alHostID`),
  KEY `new_index3` (`alDateTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `aloLog`
--


-- --------------------------------------------------------

--
-- Table structure for table `clientUpdates`
--

CREATE TABLE IF NOT EXISTS `clientUpdates` (
  `cuID` int(11) NOT NULL AUTO_INCREMENT,
  `cuName` varchar(200) NOT NULL,
  `cuMD5` varchar(100) NOT NULL,
  `cuType` varchar(3) NOT NULL,
  `cuFile` longblob NOT NULL,
  PRIMARY KEY (`cuID`),
  KEY `new_index` (`cuName`),
  KEY `new_index1` (`cuType`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `clientUpdates`
--


-- --------------------------------------------------------

--
-- Table structure for table `dirCleaner`
--

CREATE TABLE IF NOT EXISTS `dirCleaner` (
  `dcID` int(11) NOT NULL AUTO_INCREMENT,
  `dcPath` longtext NOT NULL,
  PRIMARY KEY (`dcID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `dirCleaner`
--


-- --------------------------------------------------------

--
-- Table structure for table `globalSettings`
--

CREATE TABLE IF NOT EXISTS `globalSettings` (
  `settingID` int(11) NOT NULL AUTO_INCREMENT,
  `settingKey` varchar(254) NOT NULL,
  `settingDesc` longtext NOT NULL,
  `settingValue` longtext CHARACTER SET latin1 NOT NULL,
  `settingCategory` varchar(254) NOT NULL,
  PRIMARY KEY (`settingID`),
  KEY `new_index` (`settingKey`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=89 ;

--
-- Dumping data for table `globalSettings`
--

INSERT INTO `globalSettings` (`settingID`, `settingKey`, `settingDesc`, `settingValue`, `settingCategory`) VALUES
(1, 'FOG_TFTP_HOST', 'Hostname or IP address of the TFTP Server.', '192.168.1.102', 'TFTP Server'),
(2, 'FOG_TFTP_FTP_USERNAME', 'Username used to access the tftp server via ftp.', 'fog', 'TFTP Server'),
(3, 'FOG_TFTP_FTP_PASSWORD', 'Password used to access the tftp server via ftp.', 'ebabaa1f2e6c51d51f764fdcd8da77b0', 'TFTP Server'),
(4, 'FOG_TFTP_PXE_CONFIG_DIR', 'Location of pxe boot files on the PXE server.', '/tftpboot/pxelinux.cfg/', 'TFTP Server'),
(5, 'FOG_TFTP_PXE_KERNEL_DIR', 'Location of kernel files on the PXE server.', '/tftpboot/fog/kernel/', 'TFTP Server'),
(6, 'FOG_TFTP_PXE_KERNEL', 'Location of kernel file on the PXE server, this should point to the kernel itself.', 'fog/kernel/bzImage', 'TFTP Server'),
(7, 'FOG_KERNEL_RAMDISK_SIZE', 'This setting defines the amount of physical memory (in KB) you want to use for the boot image.  This setting needs to be larger than the boot image and smaller that the total physical memory on the client.', '127000', 'TFTP Server'),
(8, 'FOG_USE_SLOPPY_NAME_LOOKUPS', 'The settings was added to workaround a partial implementation of DHCP in the boot image.  The boot image is unable to obtain a DNS server address from the DHCP server, so what this setting will do is resolve any hostnames to IP address on the FOG server before writing the config files.', '1', 'General Settings'),
(9, 'FOG_MEMTEST_KERNEL', 'The settings defines where the memtest boot image/kernel is located.', 'fog/memtest/memtest', 'General Settings'),
(10, 'FOG_PXE_BOOT_IMAGE', 'The settings defines where the fog boot file system image is located.', 'fog/images/init.gz', 'TFTP Server'),
(11, 'FOG_PXE_IMAGE_DNSADDRESS', 'Since the fog boot image has an incomplete dhcp implementation, you can specify a dns address to be used with the boot image.  If you are going to use this settings, you should turn <b>FOG_USE_SLOPPY_NAME_LOOKUPS</b> off.', '192.168.1.1', 'TFTP Server'),
(68, 'FOG_VIEW_DEFAULT_SCREEN', 'This setting defines which page is displayed in each section, valid settings includes <b>LIST</b> and <b>SEARCH</b>.', 'SEARCH', 'FOG View Settings'),
(67, 'FOG_SSH_PORT', 'This setting defines the port to use for the ssh client.', '22', 'SSH Client'),
(66, 'FOG_SSH_USERNAME', 'This setting defines the username used for the ssh client.', 'root', 'SSH Client'),
(65, 'FOG_STORAGENODE_MYSQLPASS', 'This setting defines the password the storage nodes should use to connect to the fog server.', 'fs1824', 'FOG Storage Nodes'),
(64, 'FOG_STORAGENODE_MYSQLUSER', 'This setting defines the username the storage nodes should use to connect to the fog server.', 'fogstorage', 'FOG Storage Nodes'),
(17, 'FOG_NFS_BANDWIDTHPATH', 'This setting defines the web page used to acquire the bandwidth used by the nfs server.', '/fog/status/bandwidth.php', 'NFS Server'),
(18, 'FOG_UPLOADRESIZEPCT', 'This setting defines the amount of padding applied to a partition before attempting resize the ntfs volume and upload it.', '5', 'General Settings'),
(19, 'FOG_WEB_HOST', 'This setting defines the hostname or ip address of the web server used with fog.', '192.168.1.102', 'Web Server'),
(20, 'FOG_WEB_ROOT', 'This setting defines the path to the fog webserver''s root directory.', '/fog/', 'Web Server'),
(21, 'FOG_WOL_HOST', 'This setting defines the ip address of hostname for the server hosting the Wake-on-lan service.', '192.168.1.102', 'General Settings'),
(22, 'FOG_WOL_PATH', 'This setting defines the path to the files performing the WOL tasks.', '/fog/wol/wol.php', 'General Settings'),
(23, 'FOG_WOL_INTERFACE', 'This setting defines the network interface used in the WOL process.', 'eth0', 'General Settings'),
(24, 'FOG_SNAPINDIR', 'This setting defines the location of the snapin files.  These files must be hosted on the web server.', '/opt/fog/snapins/', 'Web Server'),
(25, 'FOG_QUEUESIZE', 'This setting defines how many unicast tasks to allow to be active at one time.', '10', 'General Settings'),
(26, 'FOG_CHECKIN_TIMEOUT', 'This setting defines the amount of time between client checks to determine if they are active clients.', '600', 'General Settings'),
(27, 'FOG_USER_MINPASSLENGTH', 'This setting defines the minimum number of characters in a user''s password.', '4', 'User Management'),
(28, 'FOG_USER_VALIDPASSCHARS', 'This setting defines the valid characters used in a password.', '1234567890ABCDEFGHIJKLMNOPQRSTUVWZXYabcdefghijklmnopqrstuvwxyz_hB()^!', 'User Management'),
(29, 'FOG_NFS_ETH_MONITOR', 'This setting defines which interface is monitored for traffic summaries.', 'eth0', 'NFS Server'),
(30, 'FOG_UDPCAST_INTERFACE', 'This setting defines the interface used in multicast communications.', 'eth0', 'Multicast Settings'),
(31, 'FOG_UDPCAST_STARTINGPORT', 'This setting defines the starting port number used in multicast communications.  This starting port number must be an even number.', '63100', 'Multicast Settings'),
(32, 'FOG_MULTICAST_MAX_SESSIONS', 'This setting defines the maximum number of multicast sessions that can be running at one time.', '64', 'Multicast Settings'),
(33, 'FOG_JPGRAPH_VERSION', 'This setting defines ', '3.0.7', 'Web Server'),
(34, 'FOG_REPORT_DIR', 'This setting defines the location on the web server of the FOG reports.', './reports/', 'Web Server'),
(35, 'FOG_THEME', 'This setting defines what css style sheet and theme to use for FOG.', 'blackeye/blackeye.css', 'Web Server'),
(36, 'FOG_UPLOADIGNOREPAGEHIBER', 'This setting defines if you would like to remove hibernate and swap files before uploading a Windows image.  ', '1', 'General Settings'),
(37, 'FOG_SERVICE_DIRECTORYCLEANER_ENABLED', 'This setting defines if the Windows Service module directory cleaner should be enabled on client computers. This service is clean out the contents of a directory on when a user logs out of the workstation. (Valid values: 0 or 1).', '1', 'FOG Service - Directory Cleaner'),
(38, 'FOG_USE_ANIMATION_EFFECTS', 'This setting defines if the FOG management portal uses animation effects on it.  Valid values are 0 or 1', '1', 'General Settings'),
(39, 'FOG_SERVICE_USERCLEANUP_ENABLED', 'This setting defines if user cleanup should be enabled.  The User Cleanup module will remove all local windows users from the workstation on log off accept for users that are whitelisted.  (Valid values are 0 or 1)', '0', 'FOG Service - User Cleanup'),
(40, 'FOG_SERVICE_GREENFOG_ENABLED', 'This setting defines if the green fog module should be enabled.  The green fog module will shutdown or restart a computer at a set time.  (Valid values are 0 or 1)', '1', 'FOG Service - Green Fog'),
(41, 'FOG_SERVICE_AUTOLOGOFF_ENABLED', 'This setting defines if the auto log off module should be enabled.  This module will log off any active user after X minutes of inactivity.  (Valid values are 0 or 1)', '1', 'FOG Service - Auto Log Off'),
(42, 'FOG_SERVICE_DISPLAYMANAGER_ENABLED', 'This setting defines if the fog display manager should be active.  The fog display manager will reset the clients screen resolution to a fixed size on log off and on computer start up.  (Valid values are 0 or 1)', '0', 'FOG Service - Display Manager'),
(43, 'FOG_SERVICE_DISPLAYMANAGER_X', 'This setting defines the default width in pixels to reset the computer display to with the fog display manager service.', '1024', 'FOG Service - Display Manager'),
(44, 'FOG_SERVICE_DISPLAYMANAGER_Y', 'This setting defines the default height in pixels to reset the computer display to with the fog display manager service.', '768', 'FOG Service - Display Manager'),
(45, 'FOG_SERVICE_DISPLAYMANAGER_R', 'This setting defines the default refresh rate to reset the computer display to with the fog display manager service.', '60', 'FOG Service - Display Manager'),
(46, 'FOG_SERVICE_AUTOLOGOFF_MIN', 'This setting defines the number of minutes to wait before logging a user off of a PC. (Value of 0 will disable this module.)', '0', 'FOG Service - Auto Log Off'),
(47, 'FOG_SERVICE_AUTOLOGOFF_BGIMAGE', 'This setting defines the location of the background image used in the auto log off module.  The image should be 300px x 300px.  This image can be located locally (such as c:\\images\\myimage.jpg) or on a web server (such as http://freeghost.sf.net/images/image.jpg)', 'c:\\program files\\fog\\images\\alo-bg.jpg', 'FOG Service - Auto Log Off'),
(48, 'FOG_KEYMAP', 'This setting defines the keymap used on the client boot image.', '', 'General Settings'),
(49, 'FOG_SERVICE_HOSTNAMECHANGER_ENABLED', 'This setting defines if the fog hostname changer should be globally active.  (Valid values are 0 or 1)', '1', 'FOG Service - Hostname Changer'),
(50, 'FOG_SERVICE_SNAPIN_ENABLED', 'This setting defines if the fog snapin installer should be globally active.  (Valid values are 0 or 1)', '1', 'FOG Service - Snapins'),
(51, 'FOG_KERNEL_ARGS', 'This setting allows you to add additional kernel arguments to the client boot image.  This setting is global for all hosts.', '', 'General Settings'),
(52, 'FOG_SERVICE_CLIENTUPDATER_ENABLED', 'This setting defines if the fog client updater should be globally active.  (Valid values are 0 or 1)', '1', 'FOG Service - Client Updater'),
(53, 'FOG_SERVICE_HOSTREGISTER_ENABLED', 'This setting defines if the fog host register should be globally active.  (Valid values are 0 or 1)', '1', 'FOG Service - Host Register'),
(54, 'FOG_SERVICE_PRINTERMANAGER_ENABLED', 'This setting defines if the fog printer maanger should be globally active.  (Valid values are 0 or 1)', '1', 'FOG Service - Printer Manager'),
(55, 'FOG_SERVICE_TASKREBOOT_ENABLED', 'This setting defines if the fog task reboot should be globally active.  (Valid values are 0 or 1)', '1', 'FOG Service - Task Reboot'),
(56, 'FOG_SERVICE_USERTRACKER_ENABLED', 'This setting defines if the fog user tracker should be globally active.  (Valid values are 0 or 1)', '1', 'FOG Service - User Tracker'),
(57, 'FOG_AD_DEFAULT_DOMAINNAME', 'This setting defines the default value to populate the host''s Active Directory domain name value.', '', 'Active Directory Defaults'),
(58, 'FOG_AD_DEFAULT_OU', 'This setting defines the default value to populate the host''s Active Directory OU value.', '', 'Active Directory Defaults'),
(59, 'FOG_AD_DEFAULT_USER', 'This setting defines the default value to populate the host''s Active Directory user name value.', '', 'Active Directory Defaults'),
(60, 'FOG_AD_DEFAULT_PASSWORD', 'This setting defines the default value to populate the host''s Active Directory password value.  This settings must be encrypted.', '', 'Active Directory Defaults'),
(61, 'FOG_UTIL_DIR', 'This setting defines the location of the fog utility directory.', '/opt/fog/utils', 'FOG Utils'),
(62, 'FOG_PLUGINSYS_ENABLED', 'This setting defines if the fog plugin system should be enabled.', '0', 'Plugin System'),
(63, 'FOG_PLUGINSYS_DIR', 'This setting defines the base location of fog plugins.', './plugins', 'Plugin System'),
(69, 'FOG_PXE_MENU_TIMEOUT', 'This setting defines the default value for the pxe menu timeout.', '3', 'FOG PXE Settings'),
(70, 'FOG_PROXY_IP', 'This setting defines the proxy ip address to use.', '', 'General Settings'),
(71, 'FOG_PROXY_PORT', 'This setting defines the proxy port address to use.', '', 'General Settings'),
(72, 'FOG_UTIL_BASE', 'This setting defines the location of util base, which is typically /opt/fog/', '/opt/fog/', 'FOG Utils'),
(73, 'FOG_PXE_MENU_HIDDEN', 'This setting defines if you would like the FOG pxe menu hidden or displayed', '0', 'FOG PXE Settings'),
(74, 'FOG_PXE_ADVANCED', 'This setting defines if you would like to append any settings to the end of your PXE default file.', '', 'FOG PXE Settings'),
(75, 'FOG_USE_LEGACY_TASKLIST', 'This setting defines if you would like to use the legacy active tasks window.  Note:  The legacy screen will no longer be updated.', '0', 'General Settings'),
(76, 'FOG_QUICKREG_AUTOPOP', 'Enable FOG Quick Registration auto population feature (0 = disabled, 1=enabled).  If this feature is enabled, FOG will auto populate the host settings and automatically image the computer without any user intervention.', '0', 'FOG Quick Registration'),
(77, 'FOG_QUICKREG_IMG_ID', 'FOG Quick Registration Image ID.', '-1', 'FOG Quick Registration'),
(78, 'FOG_QUICKREG_OS_ID', 'FOG Quick Registration OS ID.', '-1', 'FOG Quick Registration'),
(79, 'FOG_QUICKREG_SYS_NAME', 'FOG Quick Registration system name template.  Use * for the autonumber feature.', 'PC-*', 'FOG Quick Registration'),
(80, 'FOG_QUICKREG_SYS_NUMBER', 'FOG Quick Registration system name auto number.', '1', 'FOG Quick Registration'),
(81, 'FOG_DEFAULT_LOCALE', 'Default language code to use for FOG.', 'en_US.UTF-8', 'General Settings'),
(82, 'FOG_HOST_LOOKUP', 'Should FOG attempt to see if a host is active and display it as part of the UI?', '1', 'General Settings'),
(83, 'FOG_UUID', 'This is a unique ID that is used to identify your installation.  In most cases you do not want to change this value.', '4ebdb2ffd9be66.79727005', 'General Settings'),
(84, 'FOG_QUICKREG_MAX_PENDING_MACS', 'This setting defines how many mac addresses will be stored in the pending mac address table for each host.', '4', 'FOG Service - Host Register'),
(85, 'FOG_QUICKREG_PENDING_MAC_FILTER', 'This is a list of MAC address fragments that is used to filter out pending mac address requests.  For example, if you don''t want to see pending mac address requests for VMWare NICs then you could filter by 00:05:69.  This filter is comma seperated, and is used like a *starts with* filter.', '', 'FOG Service - Host Register'),
(86, 'FOG_ADVANCED_STATISTICS', 'Enable the collection and display of advanced statistics.  This information WILL be sent to a remote server!  This information is used by the FOG team to see how FOG is being used.  The information that will be sent includes the server''s UUID value, the number of hosts present in FOG, and number of images on your FOG server and well as total image space used. (0 = disabled, 1 = enabled).', '0', 'General Settings'),
(87, 'FOG_DISABLE_CHKDSK', 'This is an experimental feature that will can be used to not set the dirty flag on a NTFS partition after resizing it.  It is recommended to you run chkdsk. (0 = runs chkdsk, 1 = disables chkdsk).', '1', 'General Settings'),
(88, 'FOG_CHANGE_HOSTNAME_EARLY', 'This is an experimental feature that will can be used to change the computers hostname right after imaging the box, without the need for the FOG service.  (1 = enabled, 0 = disabled).', '1', 'General Settings');

-- --------------------------------------------------------

--
-- Table structure for table `greenFog`
--

CREATE TABLE IF NOT EXISTS `greenFog` (
  `gfID` int(11) NOT NULL AUTO_INCREMENT,
  `gfHostID` int(11) NOT NULL,
  `gfHour` int(11) NOT NULL,
  `gfMin` int(11) NOT NULL,
  `gfAction` varchar(2) NOT NULL,
  `gfDays` varchar(25) NOT NULL,
  PRIMARY KEY (`gfID`),
  KEY `new_index` (`gfHostID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `greenFog`
--


-- --------------------------------------------------------

--
-- Table structure for table `groupMembers`
--

CREATE TABLE IF NOT EXISTS `groupMembers` (
  `gmID` int(11) NOT NULL AUTO_INCREMENT,
  `gmHostID` int(11) NOT NULL,
  `gmGroupID` int(11) NOT NULL,
  PRIMARY KEY (`gmID`),
  KEY `new_index` (`gmHostID`),
  KEY `new_index1` (`gmGroupID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=1 ;

--
-- Dumping data for table `groupMembers`
--


-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `groupID` int(11) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(50) NOT NULL,
  `groupDesc` longtext NOT NULL,
  `groupDateTime` datetime NOT NULL,
  `groupCreateBy` varchar(50) NOT NULL,
  `groupBuilding` int(11) NOT NULL,
  PRIMARY KEY (`groupID`),
  KEY `new_index` (`groupName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE IF NOT EXISTS `history` (
  `hID` int(11) NOT NULL AUTO_INCREMENT,
  `hText` longtext NOT NULL,
  `hUser` varchar(200) NOT NULL,
  `hTime` datetime NOT NULL,
  `hIP` varchar(50) NOT NULL,
  PRIMARY KEY (`hID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `history`
--


-- --------------------------------------------------------

--
-- Table structure for table `hostAutoLogOut`
--

CREATE TABLE IF NOT EXISTS `hostAutoLogOut` (
  `haloID` int(11) NOT NULL AUTO_INCREMENT,
  `haloHostID` int(11) NOT NULL,
  `haloTime` varchar(10) NOT NULL,
  PRIMARY KEY (`haloID`),
  KEY `new_index` (`haloHostID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `hostAutoLogOut`
--


-- --------------------------------------------------------

--
-- Table structure for table `hostMAC`
--

CREATE TABLE IF NOT EXISTS `hostMAC` (
  `hmID` int(11) NOT NULL AUTO_INCREMENT,
  `hmHostID` int(11) NOT NULL,
  `hmMAC` varchar(18) NOT NULL,
  `hmDesc` longtext NOT NULL,
  PRIMARY KEY (`hmID`),
  KEY `idxHostID` (`hmHostID`),
  KEY `idxMac` (`hmMAC`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `hostMAC`
--


-- --------------------------------------------------------

--
-- Table structure for table `hostScreenSettings`
--

CREATE TABLE IF NOT EXISTS `hostScreenSettings` (
  `hssID` int(11) NOT NULL AUTO_INCREMENT,
  `hssHostID` int(11) NOT NULL,
  `hssWidth` int(11) NOT NULL,
  `hssHeight` int(11) NOT NULL,
  `hssRefresh` int(11) NOT NULL,
  `hssOrientation` int(11) NOT NULL,
  `hssOther1` int(11) NOT NULL,
  `hssOther2` int(11) NOT NULL,
  PRIMARY KEY (`hssID`),
  KEY `new_index` (`hssHostID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `hostScreenSettings`
--


-- --------------------------------------------------------

--
-- Table structure for table `hosts`
--

CREATE TABLE IF NOT EXISTS `hosts` (
  `hostID` int(11) NOT NULL AUTO_INCREMENT,
  `hostName` varchar(16) NOT NULL,
  `hostDesc` longtext NOT NULL,
  `hostIP` varchar(25) NOT NULL,
  `hostImage` int(11) NOT NULL,
  `hostBuilding` int(11) NOT NULL,
  `hostCreateDate` datetime NOT NULL,
  `hostCreateBy` varchar(50) NOT NULL,
  `hostMAC` varchar(20) NOT NULL,
  `hostOS` int(10) unsigned NOT NULL,
  `hostUseAD` char(1) NOT NULL,
  `hostADDomain` varchar(250) NOT NULL,
  `hostADOU` longtext NOT NULL,
  `hostADUser` varchar(250) NOT NULL,
  `hostADPass` varchar(250) NOT NULL,
  `hostPrinterLevel` varchar(2) NOT NULL,
  `hostKernelArgs` varchar(250) NOT NULL,
  `hostKernel` varchar(250) NOT NULL,
  `hostDevice` varchar(250) NOT NULL,
  PRIMARY KEY (`hostID`),
  KEY `new_index` (`hostName`),
  KEY `new_index1` (`hostIP`),
  KEY `new_index2` (`hostMAC`),
  KEY `new_index3` (`hostOS`),
  KEY `new_index4` (`hostUseAD`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `hosts`
--


-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE IF NOT EXISTS `images` (
  `imageID` int(11) NOT NULL AUTO_INCREMENT,
  `imageName` varchar(40) NOT NULL,
  `imageDesc` longtext NOT NULL,
  `imagePath` longtext NOT NULL,
  `imageDateTime` datetime NOT NULL,
  `imageCreateBy` varchar(50) NOT NULL,
  `imageBuilding` int(11) NOT NULL,
  `imageSize` varchar(200) NOT NULL,
  `imageDD` varchar(1) NOT NULL,
  `imageNFSGroupID` int(11) NOT NULL,
  PRIMARY KEY (`imageID`),
  KEY `new_index` (`imageName`),
  KEY `new_index1` (`imageBuilding`),
  KEY `new_index2` (`imageDD`),
  KEY `new_index3` (`imageNFSGroupID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `images`
--


-- --------------------------------------------------------

--
-- Table structure for table `imagingLog`
--

CREATE TABLE IF NOT EXISTS `imagingLog` (
  `ilID` int(11) NOT NULL AUTO_INCREMENT,
  `ilHostID` int(11) NOT NULL,
  `ilStartTime` datetime NOT NULL,
  `ilFinishTime` datetime NOT NULL,
  `ilImageName` varchar(64) NOT NULL,
  PRIMARY KEY (`ilID`),
  KEY `new_index` (`ilHostID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `imagingLog`
--


-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `iID` int(11) NOT NULL AUTO_INCREMENT,
  `iHostID` int(11) NOT NULL,
  `iPrimaryUser` varchar(50) NOT NULL,
  `iOtherTag` varchar(50) NOT NULL,
  `iOtherTag1` varchar(50) NOT NULL,
  `iCreateDate` datetime NOT NULL,
  `iSysman` varchar(250) NOT NULL,
  `iSysproduct` varchar(250) NOT NULL,
  `iSysversion` varchar(250) NOT NULL,
  `iSysserial` varchar(250) NOT NULL,
  `iSystype` varchar(250) NOT NULL,
  `iBiosversion` varchar(250) NOT NULL,
  `iBiosvendor` varchar(250) NOT NULL,
  `iBiosdate` varchar(250) NOT NULL,
  `iMbman` varchar(250) NOT NULL,
  `iMbproductname` varchar(250) NOT NULL,
  `iMbversion` varchar(250) NOT NULL,
  `iMbserial` varchar(250) NOT NULL,
  `iMbasset` varchar(250) NOT NULL,
  `iCpuman` varchar(250) NOT NULL,
  `iCpuversion` varchar(250) NOT NULL,
  `iCpucurrent` varchar(250) NOT NULL,
  `iCpumax` varchar(250) NOT NULL,
  `iMem` varchar(250) NOT NULL,
  `iHdmodel` varchar(250) NOT NULL,
  `iHdfirmware` varchar(250) NOT NULL,
  `iHdserial` varchar(250) NOT NULL,
  `iCaseman` varchar(250) NOT NULL,
  `iCasever` varchar(250) NOT NULL,
  `iCaseserial` varchar(250) NOT NULL,
  `iCaseasset` varchar(250) NOT NULL,
  PRIMARY KEY (`iID`),
  KEY `iHostID` (`iHostID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `inventory`
--


-- --------------------------------------------------------

--
-- Table structure for table `moduleStatusByHost`
--

CREATE TABLE IF NOT EXISTS `moduleStatusByHost` (
  `msID` int(11) NOT NULL AUTO_INCREMENT,
  `msHostID` int(11) NOT NULL,
  `msModuleID` varchar(50) NOT NULL,
  `msState` varchar(1) NOT NULL,
  PRIMARY KEY (`msID`),
  KEY `new_index` (`msHostID`),
  KEY `new_index2` (`msModuleID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `moduleStatusByHost`
--


-- --------------------------------------------------------

--
-- Table structure for table `multicastSessions`
--

CREATE TABLE IF NOT EXISTS `multicastSessions` (
  `msID` int(11) NOT NULL AUTO_INCREMENT,
  `msName` varchar(250) NOT NULL,
  `msBasePort` int(11) NOT NULL,
  `msLogPath` longtext NOT NULL,
  `msImage` longtext NOT NULL,
  `msClients` int(11) NOT NULL,
  `msInterface` varchar(250) NOT NULL,
  `msStartDateTime` datetime NOT NULL,
  `msPercent` int(11) NOT NULL,
  `msState` int(11) NOT NULL,
  `msCompleteDateTime` datetime NOT NULL,
  `msIsDD` int(11) NOT NULL,
  `msNFSGroupID` int(11) NOT NULL,
  `msAnon3` varchar(250) NOT NULL,
  `msAnon4` varchar(250) NOT NULL,
  `msAnon5` varchar(250) NOT NULL,
  PRIMARY KEY (`msID`),
  KEY `new_index` (`msNFSGroupID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `multicastSessions`
--


-- --------------------------------------------------------

--
-- Table structure for table `multicastSessionsAssoc`
--

CREATE TABLE IF NOT EXISTS `multicastSessionsAssoc` (
  `msaID` int(11) NOT NULL AUTO_INCREMENT,
  `msID` int(11) NOT NULL,
  `tID` int(11) NOT NULL,
  PRIMARY KEY (`msaID`),
  KEY `new_index` (`msID`),
  KEY `new_index1` (`tID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `multicastSessionsAssoc`
--


-- --------------------------------------------------------

--
-- Table structure for table `nfsFailures`
--

CREATE TABLE IF NOT EXISTS `nfsFailures` (
  `nfID` int(11) NOT NULL AUTO_INCREMENT,
  `nfNodeID` int(11) NOT NULL,
  `nfTaskID` int(11) NOT NULL,
  `nfHostID` int(11) NOT NULL,
  `nfGroupID` int(11) NOT NULL,
  `nfDateTime` datetime NOT NULL,
  PRIMARY KEY (`nfID`),
  KEY `new_index` (`nfNodeID`),
  KEY `new_index1` (`nfTaskID`),
  KEY `new_index2` (`nfHostID`),
  KEY `new_index3` (`nfGroupID`),
  KEY `new_index4` (`nfDateTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `nfsFailures`
--


-- --------------------------------------------------------

--
-- Table structure for table `nfsGroupMembers`
--

CREATE TABLE IF NOT EXISTS `nfsGroupMembers` (
  `ngmID` int(11) NOT NULL AUTO_INCREMENT,
  `ngmMemberName` varchar(250) NOT NULL,
  `ngmMemberDescription` longtext NOT NULL,
  `ngmIsMasterNode` char(1) NOT NULL,
  `ngmGroupID` int(11) NOT NULL,
  `ngmRootPath` longtext NOT NULL,
  `ngmIsEnabled` char(1) NOT NULL,
  `ngmHostname` varchar(250) NOT NULL,
  `ngmMaxClients` int(11) NOT NULL,
  `ngmUser` varchar(250) NOT NULL,
  `ngmPass` varchar(250) NOT NULL,
  `ngmKey` varchar(250) NOT NULL,
  PRIMARY KEY (`ngmID`),
  KEY `new_index` (`ngmMemberName`),
  KEY `new_index2` (`ngmIsMasterNode`),
  KEY `new_index3` (`ngmGroupID`),
  KEY `new_index4` (`ngmIsEnabled`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `nfsGroupMembers`
--

INSERT INTO `nfsGroupMembers` (`ngmID`, `ngmMemberName`, `ngmMemberDescription`, `ngmIsMasterNode`, `ngmGroupID`, `ngmRootPath`, `ngmIsEnabled`, `ngmHostname`, `ngmMaxClients`, `ngmUser`, `ngmPass`, `ngmKey`) VALUES
(1, 'DefaultMember', 'Auto generated fog nfs group member', '1', 1, '/images/', '1', '192.168.1.102', 10, 'fog', 'ebabaa1f2e6c51d51f764fdcd8da77b0', '');

-- --------------------------------------------------------

--
-- Table structure for table `nfsGroups`
--

CREATE TABLE IF NOT EXISTS `nfsGroups` (
  `ngID` int(11) NOT NULL AUTO_INCREMENT,
  `ngName` varchar(250) NOT NULL,
  `ngDesc` longtext NOT NULL,
  PRIMARY KEY (`ngID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `nfsGroups`
--

INSERT INTO `nfsGroups` (`ngID`, `ngName`, `ngDesc`) VALUES
(1, 'default', 'Auto generated fog nfs group');

-- --------------------------------------------------------

--
-- Table structure for table `oui`
--

CREATE TABLE IF NOT EXISTS `oui` (
  `ouiID` int(11) NOT NULL AUTO_INCREMENT,
  `ouiMACPrefix` varchar(8) NOT NULL,
  `ouiMan` varchar(254) NOT NULL,
  PRIMARY KEY (`ouiID`),
  KEY `idxMac` (`ouiMACPrefix`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `oui`
--


-- --------------------------------------------------------

--
-- Table structure for table `pendingMACS`
--

CREATE TABLE IF NOT EXISTS `pendingMACS` (
  `pmID` int(11) NOT NULL AUTO_INCREMENT,
  `pmAddress` varchar(18) NOT NULL,
  `pmHostID` int(11) NOT NULL,
  PRIMARY KEY (`pmID`),
  KEY `idx_mc` (`pmAddress`),
  KEY `idx_host` (`pmHostID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `pendingMACS`
--


-- --------------------------------------------------------

--
-- Table structure for table `plugins`
--

CREATE TABLE IF NOT EXISTS `plugins` (
  `pID` int(11) NOT NULL AUTO_INCREMENT,
  `pName` varchar(100) NOT NULL,
  `pState` char(1) NOT NULL,
  `pInstalled` char(1) NOT NULL,
  `pVersion` varchar(100) NOT NULL,
  `pAnon1` varchar(100) NOT NULL,
  `pAnon2` varchar(100) NOT NULL,
  `pAnon3` varchar(100) NOT NULL,
  `pAnon4` varchar(100) NOT NULL,
  `pAnon5` varchar(100) NOT NULL,
  PRIMARY KEY (`pID`),
  KEY `new_index` (`pName`),
  KEY `new_index1` (`pState`),
  KEY `new_index2` (`pInstalled`),
  KEY `new_index3` (`pVersion`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `plugins`
--


-- --------------------------------------------------------

--
-- Table structure for table `printerAssoc`
--

CREATE TABLE IF NOT EXISTS `printerAssoc` (
  `paID` int(11) NOT NULL AUTO_INCREMENT,
  `paHostID` int(11) NOT NULL,
  `paPrinterID` int(11) NOT NULL,
  `paIsDefault` varchar(2) NOT NULL,
  `paAnon1` varchar(2) NOT NULL,
  `paAnon2` varchar(2) NOT NULL,
  `paAnon3` varchar(2) NOT NULL,
  `paAnon4` varchar(2) NOT NULL,
  `paAnon5` varchar(2) NOT NULL,
  PRIMARY KEY (`paID`),
  KEY `new_index1` (`paHostID`),
  KEY `new_index2` (`paPrinterID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `printerAssoc`
--


-- --------------------------------------------------------

--
-- Table structure for table `printers`
--

CREATE TABLE IF NOT EXISTS `printers` (
  `pID` int(11) NOT NULL AUTO_INCREMENT,
  `pPort` longtext NOT NULL,
  `pDefFile` longtext NOT NULL,
  `pModel` varchar(250) NOT NULL,
  `pAlias` varchar(250) NOT NULL,
  `pConfig` varchar(10) NOT NULL,
  `pIP` varchar(20) NOT NULL,
  `pAnon2` varchar(10) NOT NULL,
  `pAnon3` varchar(10) NOT NULL,
  `pAnon4` varchar(10) NOT NULL,
  `pAnon5` varchar(10) NOT NULL,
  PRIMARY KEY (`pID`),
  KEY `new_index1` (`pModel`),
  KEY `new_index2` (`pAlias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `printers`
--


-- --------------------------------------------------------

--
-- Table structure for table `scheduledTasks`
--

CREATE TABLE IF NOT EXISTS `scheduledTasks` (
  `stID` int(11) NOT NULL AUTO_INCREMENT,
  `stName` varchar(240) NOT NULL,
  `stDesc` longtext NOT NULL,
  `stType` varchar(24) NOT NULL,
  `stTaskType` varchar(24) NOT NULL,
  `stMinute` varchar(240) NOT NULL,
  `stHour` varchar(240) NOT NULL,
  `stDOM` varchar(240) NOT NULL,
  `stMonth` varchar(240) NOT NULL,
  `stDOW` varchar(240) NOT NULL,
  `stIsGroup` varchar(2) NOT NULL,
  `stGroupHostID` int(11) NOT NULL,
  `stShutDown` varchar(2) NOT NULL,
  `stOther1` varchar(240) NOT NULL,
  `stOther2` varchar(240) NOT NULL,
  `stOther3` varchar(240) NOT NULL,
  `stOther4` varchar(240) NOT NULL,
  `stOther5` varchar(240) NOT NULL,
  `stDateTime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `stActive` varchar(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`stID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `scheduledTasks`
--


-- --------------------------------------------------------

--
-- Table structure for table `schemaVersion`
--

CREATE TABLE IF NOT EXISTS `schemaVersion` (
  `vID` int(11) NOT NULL AUTO_INCREMENT,
  `vValue` int(11) NOT NULL,
  PRIMARY KEY (`vID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=2 ;

--
-- Dumping data for table `schemaVersion`
--

INSERT INTO `schemaVersion` (`vID`, `vValue`) VALUES
(1, 23);

-- --------------------------------------------------------

--
-- Table structure for table `snapinAssoc`
--

CREATE TABLE IF NOT EXISTS `snapinAssoc` (
  `saID` int(11) NOT NULL AUTO_INCREMENT,
  `saHostID` int(11) NOT NULL,
  `saSnapinID` int(11) NOT NULL,
  PRIMARY KEY (`saID`),
  KEY `new_index` (`saHostID`),
  KEY `new_index1` (`saSnapinID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `snapinAssoc`
--


-- --------------------------------------------------------

--
-- Table structure for table `snapinJobs`
--

CREATE TABLE IF NOT EXISTS `snapinJobs` (
  `sjID` int(11) NOT NULL AUTO_INCREMENT,
  `sjHostID` int(11) NOT NULL,
  `sjCreateTime` datetime NOT NULL,
  PRIMARY KEY (`sjID`),
  KEY `new_index` (`sjHostID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `snapinJobs`
--


-- --------------------------------------------------------

--
-- Table structure for table `snapinTasks`
--

CREATE TABLE IF NOT EXISTS `snapinTasks` (
  `stID` int(11) NOT NULL AUTO_INCREMENT,
  `stJobID` int(11) NOT NULL,
  `stState` int(11) NOT NULL,
  `stCheckinDate` datetime NOT NULL,
  `stCompleteDate` datetime NOT NULL,
  `stSnapinID` int(11) NOT NULL,
  `stReturnCode` int(11) NOT NULL,
  `stReturnDetails` varchar(250) NOT NULL,
  PRIMARY KEY (`stID`),
  KEY `new_index` (`stJobID`),
  KEY `new_index1` (`stState`),
  KEY `new_index2` (`stSnapinID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `snapinTasks`
--


-- --------------------------------------------------------

--
-- Table structure for table `snapins`
--

CREATE TABLE IF NOT EXISTS `snapins` (
  `sID` int(11) NOT NULL AUTO_INCREMENT,
  `sName` varchar(200) NOT NULL,
  `sDesc` longtext NOT NULL,
  `sFilePath` longtext NOT NULL,
  `sArgs` longtext NOT NULL,
  `sCreateDate` datetime NOT NULL,
  `sCreator` varchar(200) NOT NULL,
  `sReboot` varchar(1) NOT NULL,
  `sRunWith` varchar(245) NOT NULL,
  `sRunWithArgs` varchar(200) NOT NULL,
  `sAnon3` varchar(45) NOT NULL,
  PRIMARY KEY (`sID`),
  KEY `new_index` (`sName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `snapins`
--


-- --------------------------------------------------------

--
-- Table structure for table `supportedOS`
--

CREATE TABLE IF NOT EXISTS `supportedOS` (
  `osID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `osName` varchar(150) NOT NULL,
  `osValue` int(10) unsigned NOT NULL,
  PRIMARY KEY (`osID`),
  KEY `new_index` (`osValue`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `supportedOS`
--

INSERT INTO `supportedOS` (`osID`, `osName`, `osValue`) VALUES
(1, 'Windows 2000/XP', 1),
(2, 'Windows Vista', 2),
(3, 'Other', 99),
(4, 'Windows 98', 3),
(5, 'Windows (other)', 4),
(6, 'Linux', 50),
(7, 'Windows 7', 5);

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE IF NOT EXISTS `tasks` (
  `taskID` int(11) NOT NULL AUTO_INCREMENT,
  `taskName` varchar(250) NOT NULL,
  `taskCreateTime` datetime NOT NULL,
  `taskCheckIn` datetime NOT NULL,
  `taskHostID` int(11) NOT NULL,
  `taskState` int(11) NOT NULL,
  `taskCreateBy` varchar(200) NOT NULL,
  `taskForce` varchar(1) NOT NULL,
  `taskScheduledStartTime` datetime NOT NULL,
  `taskType` varchar(1) NOT NULL,
  `taskPCT` int(10) unsigned zerofill NOT NULL,
  `taskBPM` varchar(250) NOT NULL,
  `taskTimeElapsed` varchar(250) NOT NULL,
  `taskTimeRemaining` varchar(250) NOT NULL,
  `taskDataCopied` varchar(250) NOT NULL,
  `taskPercentText` varchar(250) NOT NULL,
  `taskDataTotal` varchar(250) NOT NULL,
  `taskNFSGroupID` int(11) NOT NULL,
  `taskNFSMemberID` int(11) NOT NULL,
  `taskNFSFailures` char(1) NOT NULL,
  `taskLastMemberID` int(11) NOT NULL,
  PRIMARY KEY (`taskID`),
  KEY `new_index` (`taskHostID`),
  KEY `new_index1` (`taskCheckIn`),
  KEY `new_index2` (`taskState`),
  KEY `new_index3` (`taskForce`),
  KEY `new_index4` (`taskType`),
  KEY `new_index5` (`taskNFSGroupID`),
  KEY `new_index6` (`taskNFSMemberID`),
  KEY `new_index7` (`taskNFSFailures`),
  KEY `new_index8` (`taskLastMemberID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tasks`
--


-- --------------------------------------------------------

--
-- Table structure for table `userCleanup`
--

CREATE TABLE IF NOT EXISTS `userCleanup` (
  `ucID` int(11) NOT NULL AUTO_INCREMENT,
  `ucName` varchar(254) NOT NULL,
  PRIMARY KEY (`ucID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `userCleanup`
--

INSERT INTO `userCleanup` (`ucID`, `ucName`) VALUES
(1, 'administrator'),
(2, 'admin'),
(3, 'guest'),
(4, 'HelpAssistant'),
(5, 'ASPNET'),
(6, 'SUPPORT_');

-- --------------------------------------------------------

--
-- Table structure for table `userTracking`
--

CREATE TABLE IF NOT EXISTS `userTracking` (
  `utID` int(11) NOT NULL AUTO_INCREMENT,
  `utHostID` int(11) NOT NULL,
  `utUserName` varchar(50) NOT NULL,
  `utAction` varchar(2) NOT NULL,
  `utDateTime` datetime NOT NULL,
  `utDesc` varchar(250) NOT NULL,
  `utDate` date NOT NULL,
  `utAnon3` varchar(2) NOT NULL,
  PRIMARY KEY (`utID`),
  KEY `new_index` (`utHostID`),
  KEY `new_index1` (`utUserName`),
  KEY `new_index2` (`utAction`),
  KEY `new_index3` (`utDateTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `userTracking`
--


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `uId` int(11) NOT NULL AUTO_INCREMENT,
  `uName` varchar(40) NOT NULL,
  `uPass` varchar(50) NOT NULL,
  `uCreateDate` datetime NOT NULL,
  `uCreateBy` varchar(40) NOT NULL,
  `uType` varchar(2) NOT NULL,
  PRIMARY KEY (`uId`),
  KEY `new_index` (`uName`),
  KEY `new_index1` (`uPass`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uId`, `uName`, `uPass`, `uCreateDate`, `uCreateBy`, `uType`) VALUES
(1, 'fog', '5f4dcc3b5aa765d61d8327deb882cf99', '0000-00-00 00:00:00', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `virus`
--

CREATE TABLE IF NOT EXISTS `virus` (
  `vID` int(11) NOT NULL AUTO_INCREMENT,
  `vName` varchar(250) NOT NULL,
  `vHostMAC` varchar(50) NOT NULL,
  `vOrigFile` longtext NOT NULL,
  `vDateTime` datetime NOT NULL,
  `vMode` varchar(5) NOT NULL,
  `vAnon2` varchar(50) NOT NULL,
  PRIMARY KEY (`vID`),
  KEY `new_index` (`vHostMAC`),
  KEY `new_index2` (`vDateTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `virus`
--

