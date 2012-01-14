#!/usr/bin/python

# This particular messy (but clever if I do say so!) TKL firstboot script written by Jeremy Davis (aka JedMeister)
# using a jigsaw of scrounged, stolen and otherwise mish-mashed code...!

"""Set FOG admin ('fog') password and IP

Option:
    --pass=     unless provided, will ask interactively
    --ip=	    unless provided, will ask interactively
                    eg 192.168.1.2
#This stuff hasn't been implemented yet - not sure if I'll bother....
#    --usedhcp=	unless provided, will ask interactively
                    DEFAULT=y
#    --interface=unless provided, will ask interactively
                    eg eth0
#    --route=	unless provided, will ask interactively
                    eg 192.168.1.254
#    --dns=	unless provided, will ask interactively
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

import datetime

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

def main():
    try:
        opts, args = getopt.gnu_getopt(sys.argv[1:], "h",
                                       ['help', 'pass=', 'ip=', '--usedhcp=', '--interface=', '--route=', '--dns='])
    except getopt.GetoptError, e:
        usage(e)

    password = ""
#    ipaddr = ""
#    dhcpused = ""
#    interf = ""
#    router = ""
#    nameserver = ""    
    
    for opt, val in opts:
        if opt in ('-h', '--help'):
            usage()
        elif opt == '--pass':
            password = val
        elif opt == '--ip':
            ipaddr = val
#        elif opt == '--usedhcp':
#            dhcpused = val
#        elif opt == '--interface':
#            interf = val
#        elif opt == '--route':
#            router = val
#        elif opt == '--dns':
#            nameserver = val

#Get FOG WebUI/FTP user password
# configuration happens later on...
    if not password:
        d = Dialog('TurnKey Linux - First boot configuration')
        password = d.get_password(
            "FOG Password",
            "Enter new password for the default FOG Admin account ('fog').")
    
#Network setup inc IP address
# set FOG server static IP address, netmask, router/gateway, nameserver
# leverages a slightly modified version of TKL confconsole
    
    configure = tklconf.networking()
    configure = tklconf._ifconf_staticip()
    ipaddr, netmask, router, nameserver = configure

#Use FOG DHCP?
# If yes configure DHCP, if no disable DHCP
    d = Dialog('TurnKey Linux - First boot configuration')
    dhcpused = d.yesno(
        "FOG server integrated DHCP",
        "Use the FOG server for your network DHCP? \n \nIf 'Yes' then disable all other network DHCP servers. \nIf 'No' then configure your current DHCP server to use the FOG PXE boot image. See \nhttp://www.fogproject.org/wiki/index.php?title=Modifying_existing_DHCP_server_to_work_with_FOG \nfor more info.")

    #set some variables
    CONF_DIR = "/etc/dhcp3/"
    CONF_FILE = CONF_DIR+"dhcpd.conf"
    
    if dhcpused == True:
    # if DHCP used then... otherwise skip this bit
        networkbase = ipaddr.split(".")
        networkbase = networkbase[0]+"."+networkbase[1]+"."+networkbase[2]+"."
        ipexample = networkbase+"x"

        d = Dialog('TurnKey Linux - First boot configuration')
        startrange = d.get_input(
            "Set FOG DHCP IP range",
            "The FOG DHCP server will use the previous network settings for clients \nSet FOG server DHCP start IP range (%s)" % ipexample,
            networkbase)

        d = Dialog('TurnKey Linux - First boot configuration')
        endrange = d.get_input(
            "Set FOG DHCP IP range",
            "Set FOG server DHCP end IP range (%s)" % ipexample,
            networkbase)
        
        #Configure DHCP
        # set some more variables
        BACKUP_FILE = CONF_FILE+".backup"
        TEMP_FILE = CONF_FILE+".temp" 

        # backup conf file
        shutil.copy2(CONF_FILE, BACKUP_FILE)
    
        # write new dhcp.conf file
        now = datetime.datetime.now()
        installtime = now.strftime("%a %d %b %Y %H:%M:%S") # put a time stamp in config file cause it was a little bit fancy :)
        file01 = '# DHCP Server Configuration file. \n# see /usr/share/doc/dhcp*/dhcpd.conf.sample \n# This file was created by TKL FOG firstboot script (/usr/lib/inithooks/bin/fog.py) \n# on '+installtime+'\nuse-host-decl-names on; \nddns-update-style interim; \nignore client-updates; \nnext-server '+ipaddr+'; \n \nsubnet '+networkbase+'0 netmask '+netmask+' { \n    option subnet-mask '+netmask+'; \n    range dynamic-bootp '+startrange+' '+endrange+'; \n    default-lease-time 21600; \n    max-lease-time 43200; \n    option domain-name-servers'
        file02=''
        count = 0
        for count in len(nameserver):
            file02 = file02+' '+nameserver[count]
            if count != len(nameserver):
                file02 = file02+', '
        file03 = '; \n    option routers '+router+'; \n    filename "pxelinux.0/"; \n}'
        conf = open(CONF_FILE, "w")
        conf.write(file01+file02+file03)
        conf.close()

    else:
        #Disable DHCP - ATM it's a dirty hack which just renames dhcp.conf...
        DISABLE_CONF = CONF_FILE+".disabled"
        shutil.move(CONF_FILE, DISABLE_CONF)
     
#Set FOG WebUI/FTP user password
# password for WebUI hashed and stored in MySQL
    hash = md5.md5(password)
    hashpass = hash.hexdigest()
    m = MySQL()
    m.execute('UPDATE fog.users SET uPass=\"%s\"  WHERE uName=\"fog\";' % hashpass)

 # set fog Linux user (FTP) password
    login = 'fog'
    p = subprocess.Popen(('openssl', 'passwd', '-1', password), stdout=subprocess.PIPE)
    shadow_password = p.communicate()[0].strip()
    if p.returncode != 0:
        print 'Error creating hash for ' + login
    r = subprocess.call(('usermod', '-p', shadow_password, login))
    if r != 0:
        print 'Error changing password for ' + login

#Add above values to FOG config.php file
    # Set some variables
    CONF_DIR = "/var/www/fog/commons/"
    CONF_FILE = CONF_DIR+"config.php"
    BACKUP_FILE = CONF_FILE+".backup"
    TEMP_FILE = CONF_FILE+".temp"
    
    start = 'define( "'
    mid = '", "'
    end = '" );'+'\n'

    # backup conf file
    shutil.copy2(CONF_FILE, BACKUP_FILE)
    
    # set password in conf file
    # this is a little messy, but allows for customisations to be maintained should the firstboot script be run later on (ie not on firstboot).
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
    ip_line = ['TFTP_HOST', 'STORAGE_HOST', 'WEB_HOST', 'WOL_HOST']
    for thing in ip_line:
        conf = open(CONF_FILE, "r")
        temp = open(TEMP_FILE, "w")
        for line in conf:
            if line.lstrip().startswith(start+thing):
                temp.write(start+thing+mid+ipaddr+end)
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

# Adjust conf file #2
#  Set some variables
#    CONF_DIR2 = "/opt/fog/"
#    CONF_FILE2 = CONF_DIR2+".fogsettings"

if __name__ == "__main__":
    main()
