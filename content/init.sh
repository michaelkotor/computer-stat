sudo apt-get -y install sysbench

mkdir /test
cd /test

name=result-`date +%F`.txt
touch $name

# first test CPU
sysbench cpu --cpu-max-prime=20000 run >> $name

#second test
sysbench fileio --file-total-size=70G prepare >> $name

sysbench fileio --file-total-size=70G --file-test-mode=rndrw  --max-time=300 --max-requests=0  run >> $name

sysbench fileio cleanup >> $name

second_name="@$name"

# to fix name not working for now
curl -F 'file=$second_name' http://54.198.238.38/file