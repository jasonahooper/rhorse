clear
cat log/development.log |grep Started|grep -v "31.51.51.251"| grep -v "127.0.0.1"|grep -v " 192.168.1"
