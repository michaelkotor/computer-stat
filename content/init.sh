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

curl -F 'file=@$name' localhost:3000/file