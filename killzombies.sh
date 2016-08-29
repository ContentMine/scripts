ps -ef | grep phantom | grep pm286 | grep -v grep | awk '{print $2}' > zombieprocesses.txt

kill -9 $(cat zombieprocesses.txt)

