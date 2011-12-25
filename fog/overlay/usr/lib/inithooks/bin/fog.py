#!/usr/bin/python
"""Set FOG admin password and domain to serve # currently just a copy of the concrete5 py

Option:
    --pass=     unless provided, will ask interactively # Not working yet
    --domain=   unless provided, will ask interactively
                DEFAULT=concrete5.example.com
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

DEFAULT_DOMAIN="fog.example.com"
DEFAULT_PROTOCOL="http"

def main():
    try:
        opts, args = getopt.gnu_getopt(sys.argv[1:], "h",
                                       ['help', 'pass=', 'protocol=', 'domain='])
    except getopt.GetoptError, e:
        usage(e)

    protocol = ""
    domain = ""
    password = ""
    for opt, val in opts:
        if opt in ('-h', '--help'):
            usage()
        elif opt == '--pass':
            password = val
        elif opt == '--protocol':
            protocol = val
        elif opt == '--domain':
            domain = val

    if not password:
        d = Dialog('TurnKey Linux - First boot configuration')
        password = d.get_password(
            "Concrete5 Password",
            "Enter new password for the Concrete5 'admin' account.")
    
    if not protocol:
        if 'd' not in locals():
            d = Dialog('TurnKey Linux - First boot configuration')

        protocol = d.get_input(
            "Concrete5 Protocol",
            "Enter the protocol to serve Concrete5 (http or https).",
            DEFAULT_PROTOCOL)

    if protocol == "DEFAULT":
        protocol = DEFAULT_PROTOCOL

    if not domain:
        if 'd' not in locals():
            d = Dialog('TurnKey Linux - First boot configuration')

        domain = d.get_input(
            "Concrete5 Domain",
            "Enter the domain to serve Concrete5.",
            DEFAULT_DOMAIN)

    if domain == "DEFAULT":
        domain = DEFAULT_DOMAIN

    salt = "".join(random.choice(string.letters+string.digits) for line in range(1, 65))
#    salt = "qHlUmvrKzyMZlwBy1PQfltXGCezTrwN8Qm2uRABczMkTFBZMcm35J6jIRntPgRpS"
    hash = md5.md5(password+':'+salt)
    hashpass = hash.hexdigest()

    m = MySQL()
#    m.execute('UPDATE concrete5.Users SET uEmail=\"%s\" WHERE username=\"admin\";' % email)
    m.execute('UPDATE concrete5.Users SET uPassword=\"%s\"  WHERE uName=\"admin\";' % hashpass)

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
