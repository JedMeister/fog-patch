#!/usr/bin/python
"""Set FOG admin ('fog') password and IP

Option:
    --pass=     unless provided, will ask interactively
    --ip=		unless provided, will ask interactively
                DEFAULT=192.168.1.2
	--use-dhcp=	unless provided, will ask interactively
				DEFAULT=y
"""

import sys
import getopt
import shutil
import md5
import random as random
import string

from dialog_wrapper import Dialog
from mysqlconf import MySQL

import os

#from tempfile import mkstemp

def usage(s=None):
    if s:
        print >> sys.stderr, "Error:", s
    print >> sys.stderr, "Syntax: %s [options]" % sys.argv[0]
    print >> sys.stderr, __doc__
    sys.exit(1)

DEFAULT_IP="192.168.1.2"
DEFAULT_USE_DHCP="y"

# Get some suggestions
# I have the bash scripts and don't know enough about python to script this properly so am using bash...

script = """
SuggestIP=`ifconfig | grep "inet addr:" | head -n 1  | cut -d':' -f2 | cut -d' ' -f1`;
SuggestInterface=`ifconfig | grep "Link encap:" | head -n 1 | cut -d' ' -f1`;
SuggestRoute=`route -n | grep "^.*UG.*${strSuggestedInterface}$"  | head -n 1`;
SuggestRoute=`echo ${SuggestRoute:16:16} | tr -d [:blank:]`;
SuggestDNS="";
	if [ -f "/etc/resolv.conf" ]
	then
		SuggestDNS=` cat /etc/resolv.conf | grep "nameserver" | head -n 1 | tr -d "nameserver" | tr -d [:blank:] | grep "^[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$"`
	fi
"""
os.system("bash -c '%s'" % script)

def main():
    try:
        opts, args = getopt.gnu_getopt(sys.argv[1:], "h",
                                       ['help', 'pass=', 'ip='])
    except getopt.GetoptError, e:
        usage(e)

    ip = ""
    password = ""
    for opt, val in opts:
        if opt in ('-h', '--help'):
            usage()
        elif opt == '--pass':
            password = val
        elif opt == '--ip':
            protocol = val

    if not password:
        d = Dialog('TurnKey Linux - First boot configuration')
        password = d.get_password(
            "FOG Password",
            "Enter new password for the default FOG Admin account ('fog').")
    
    if not ip:
        if 'd' not in locals():
            d = Dialog('TurnKey Linux - First boot configuration')

        ip = d.get_input(
            "FOG IP address",
            "Enter the FOG server IP address.",
            DEFAULT_IP)

    if ip == "DEFAULT":
        ip = DEFAULT_IP

    if not use-dhcp:
        if 'd' not in locals():
            d = Dialog('TurnKey Linux - First boot configuration')

        use-dhcp = d.get_input(
            "Use FOG server for DHCP",
            "Use the FOG server for your network DHCP (y/n)?",
            DEFAULT_USE_DHCP)

    if use-dhcp == "DEFAULT":
        use-dhcp = DEFAULT_USE_DHCP

    salt = "".join(random.choice(string.letters+string.digits) for line in range(1, 65))
#    salt = "qHlUmvrKzyMZlwBy1PQfltXGCezTrwN8Qm2uRABczMkTFBZMcm35J6jIRntPgRpS"
    hash = md5.md5(password+':'+salt)
    hashpass = hash.hexdigest()

    m = MySQL()
#    m.execute('UPDATE concrete5.Users SET uEmail=\"%s\" WHERE username=\"admin\";' % email)
    m.execute('UPDATE fog.Users SET uPassword=\"%s\"  WHERE uName=\"admin\";' % hashpass)

# Set some variables
    CONF_DIR = "/var/www/concrete5/config/"
    CONF_FILE = CONF_DIR+"site.php"
    OLD_FILE = CONF_DIR+"oldsite.php"
    TEMP_FILE = CONF_DIR+"tempsite.php"
    BLANK_CONF_FILE = CONF_DIR+"blanksite.php"
    URL_LINE = "define('BASE_URL', '"
    SALT_LINE = "define('PASSWORD_SALT', '"
    NEW_URL_LINE = URL_LINE+protocol+"://"+domain+"');"+"\n"
    NEW_SALT_LINE = SALT_LINE+salt+"');"+"\n"

    shutil.copy2(CONF_FILE, OLD_FILE)

    conf = open(CONF_FILE, "r")
    temp = open(TEMP_FILE, "w")

    temp.write(conf.readline())
    
    for line in conf:
        if not line.lstrip().startswith(URL_LINE):
            temp.write(line)

    temp.write(NEW_URL_LINE)

    conf.close()
    temp.close()
    shutil.move(TEMP_FILE, CONF_FILE)

    conf = open(CONF_FILE, "r")
    temp = open(TEMP_FILE, "w")

    temp.write(conf.readline())
    
    for line in conf:
        if not line.lstrip().startswith(SALT_LINE):
            temp.write(line)

    temp.write(NEW_SALT_LINE)

    conf.close()
    temp.close()
    shutil.move(TEMP_FILE, CONF_FILE)

if __name__ == "__main__":
    main()
