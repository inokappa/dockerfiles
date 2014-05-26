#!/usr/bin/env expect

set timeout -1
spawn python /usr/lib/python2.6/site-packages/graphite/manage.py syncdb

expect "Would you like to create one now" {
  send "yes\r"
}

expect "Username *:" {
  send "admin\r"
}

expect "E-mail address:" {
  send "admim@example.com\r"
}

expect "Password:" {
  send "admin\r"
}

expect "Password *:" {
  send "admin\r"
}

interact

expect "Superuser created successfully"
