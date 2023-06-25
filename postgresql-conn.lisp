(ql:quickload "postmodern")
(use-package :postmodern)

(connect-toplevel "databasename" "username" "userpass" "hostip" :port 5454)

(query "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'users';")
