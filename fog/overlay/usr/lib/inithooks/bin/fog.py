#!/usr/bin/python
"""Set FOG admin ('fog') password and IP

Option:
    --pass=     unless provided, will ask interactively
    --ip=	unless provided, will ask interactively
                Will suggest (hopefully) reasonable guess
                eg 192.168.1.2
    --usedhcp=	unless provided, will ask interactively
		DEFAULT=y
    --interface=unless provided, will ask interactively
		Will suggest (hopefully) reasonable guess
		eg eth0
    --route=	unless provided, will ask interactively
                Will suggest (hopefully) reasonable guess
                eg 192.168.1.254
    --dns=	unless provided, will ask interactively
                Will suggest (hopefully) reasonable guess
                eg 192.168.1.1
"""

import sys
import getopt
import shutil
import md5
import random as random
import string
import commands
import subprocess

from dialog_wrapper import Dialog
from mysqlconf import MySQL

import os

# robbbing stuff from confconsole...
import confconsolefb as confconsole
import ifutil
tklconf = confconsole.TurnkeyConsole()

def usage(s=None):
    if s:
        print >> sys.stderr, "Error:", s
        print >> sys.stderr, "Syntax: %s [options]" % sys.argv[0]
        print >> sys.stderr, __doc__
        sys.exit(1)

#SUGGEST_IP = commands.getoutput("ifconfig").split("\n")[1].split()[1][5:]
DEFAULT_USE_DHCP = "y"
#SUGGEST_IF = commands.getoutput("ifconfig").split("\n")[0].split()[0]
#SUGGEST_ROUTE = commands.getoutput("route -n").split("\n")[3].split()[1]
#SUGGEST_DNS = commands.getoutput("cat /etc/resolv.conf").split("\n")[2].split()[1]

def main():
    try:
        opts, args = getopt.gnu_getopt(sys.argv[1:], "h",
                                       ['help', 'pass=', 'ip=', '--usedhcp=', '--interface=', '--route=', '--dns='])
    except getopt.GetoptError, e:
        usage(e)

    password = ""
#    ipaddr = ""
    dhcpused = ""
    interf = ""
#    router = ""
#    nameserver = ""    
	
    for opt, val in opts:
        if opt in ('-h', '--help'):
            usage()
        elif opt == '--pass':
            password = val
        elif opt == '--ip':
            ipaddr = val
        elif opt == '--usedhcp':
            dhcpused = val
        elif opt == '--interface':
            interf = val
        elif opt == '--route':
            router = val
        elif opt == '--dns':
            nameserver = val

    if not password:
        d = Dialog('TurnKey Linux - First boot configuration')
        password = d.get_password(
            "FOG Password",
            "Enter new password for the default FOG Admin account ('fog').")
    
#    if not interf:
#        defaultnic = tklconf._get_default_nic()
#        if 'd' not in locals():
#            d = Dialog('TurnKey Linux - First boot configuration')
#
#        interf = d.get_input(
#            "Set default interface for FOG server",
#            "Enter default interface",
#            defaultnic)
#
#    if interf == "DEFAULT":
#        interf = defaultnic
	
    configure = tklconf.networking()
    configure = tklconf._ifconf_staticip()
    if len(configure) != 3:
        ipaddr, router, nameserver, nameserver2 = configure
	else:
	    ipaddr, router, nameserver, nameserver2 = configure
    print ipaddr
    print router
    print nameserver
	
		
#    if not ipaddr:
#    	    if 'd' not in locals():
#               d = Dialog('TurnKey Linux - First boot configuration')
#
#            ip = d.get_input(
#                "FOG IP address",
#                "Enter the FOG server IP address. Only change this if using a direct connection (or screen) to your FOG server. All current network connections will be lost.",
#                SUGGEST_IP)

#            if ip == "DEFAULT":
#                ip = SUGGEST_IP

    if not dhcpused:
        if 'd' not in locals():
            d = Dialog('TurnKey Linux - First boot configuration')

        dhcpused = d.get_input(
            "Use FOG server for DHCP",
            "Use the FOG server for your network DHCP (y/n)?",
            DEFAULT_USE_DHCP)

    if dhcpused == "DEFAULT":
        dhcpused = DEFAULT_USE_DHCP


#    if not router:
#       if 'd' not in locals():
#            d = Dialog('TurnKey Linux - First boot configuration')
#
#        router = d.get_input(
#            "Set FOG server internet gateway",
#            "Enter your router or transparent proxy IP. This will used by DHCP (if enabled) and will be handed to clients",
#            SUGGEST_ROUTE)
#
#    if router == "DEFAULT":
#        router = SUGGEST_ROUTE

#    if not nameserver:
#        if 'd' not in locals():
#            d = Dialog('TurnKey Linux - First boot configuration')
#
#        nameserver = d.get_input(
#            "Set FOG server DNS",
#            "Enter the nameserver for FOG. This will used by DHCP (if enabled) and will be handed to clients",
#            SUGGEST_DNS)

#    if nameserver == "DEFAULT":
#        nameserver = SUGGEST_DNS

#Adjust settings relative to answers above

 #Password
 # password for WebUI hashed and stored in MySQL
    hash = md5.md5(password)
    hashpass = hash.hexdigest()
    m = MySQL()
    m.execute('UPDATE fog.users SET uPass=\"%s\"  WHERE uName=\"fog\";' % hashpass)

 # set fog Linux user password
    login = 'fog'
    p = subprocess.Popen(('openssl', 'passwd', '-1', password), stdout=subprocess.PIPE)
    shadow_password = p.communicate()[0].strip()
    if p.returncode != 0:
        print 'Error creating hash for ' + login
    r = subprocess.call(('usermod', '-p', shadow_password, login))
    if r != 0:
    	print 'Error changing password for ' + login

 #IP address
 # Set FOG server IP address
 # would like to leverage TKL confconsole (or something...) to do this...
 ######################
 #THIS NOT DONE YET!!!
 ######################

 #DHCP disabled
 # DHCP is enabled by default - this bit will disable it if q answered 'n'.
 
 ######################
 #THIS NOT DONE YET!!!
 ###################### 
 
 #Set interface
 
 #Set router IP
 
 #Set DNS server
 

#Add above values to conf file #1
 # Set some variables
    CONF_DIR = "/var/www/fog/commons/"
    CONF_FILE = CONF_DIR+"config.php"
    OLD_FILE = CONF_DIR+"oldconf.php"
    TEMP_FILE = CONF_DIR+"tempconf.php"
    BLANK_CONF_FILE = CONF_DIR+"blankconf.php"
    
    start = 'define( "'
    mid = '", "'
    end = '" );'+'\n'

# set password in conf file
    pass_line = ['TFTP_FTP_PASSWORD', 'STORAGE_FTP_PASSWORD']
    for thing in pass_line:
        conf = open(CONF_FILE, "r")
        temp = open(TEMP_FILE, "w")
        for line in conf:
            if line.lstrip().startswith(start+thing):
                temp.write(start+thing+mid+hashpass+end)
            else:
                temp.write(line)
        conf.close()
        temp.close()
        shutil.move(TEMP_FILE, CONF_FILE)

# set IP in conf file
    shutil.copy2(CONF_FILE, OLD_FILE)
    ip_line = ['TFTP_HOST', 'STORAGE_HOST', 'WEB_HOST', 'WOL_HOST']
    for thing in ip_line:
        conf = open(CONF_FILE, "r")
        temp = open(TEMP_FILE, "w")
        for line in conf:
            if line.lstrip().startswith(start+thing):
                temp.write(start+thing+mid+ip+end)
            else:
                temp.write(line)
        conf.close()
        temp.close()
        shutil.move(TEMP_FILE, CONF_FILE)

# set DNS in conf file		
    thing = 'PXE_IMAGE_DNSADDRESS'
    conf = open(CONF_FILE, "r")
    temp = open(TEMP_FILE, "w")
    for line in conf:
        if line.lstrip().startswith(start+thing):
            temp.write(start+thing+mid+dns+end)
        else:
            temp.write(line)
        conf.close()
        temp.close()
        shutil.move(TEMP_FILE, CONF_FILE)

#    temp.write(conf.readline())
    
#    for line in conf:
#        if not line.lstrip().startswith(URL_LINE):
#            temp.write(line)

#

#    conf.close()
#    temp.close()
#    shutil.move(TEMP_FILE, CONF_FILE)

#    conf = open(CONF_FILE, "r")
#    temp = open(TEMP_FILE, "w")

#    temp.write(conf.readline())
    
#    for line in conf:
#        if not line.lstrip().startswith(SALT_LINE):
#            temp.write(line)

#    temp.write(NEW_SALT_LINE)

#    conf.close()
#    temp.close()
#    shutil.move(TEMP_FILE, CONF_FILE)

# Adjust conf file #2
#  Set some variables
#    CONF_DIR2 = "/opt/fog/"
#    CONF_FILE2 = CONF_DIR2+".fogsettings"

if __name__ == "__main__":
    main()
