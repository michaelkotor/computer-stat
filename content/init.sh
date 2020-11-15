sudo apt update
sudo apt-get -y install sysbench curl

touch result.txt

# first test CPU
sysbench cpu --cpu-max-prime=20000 run >> result.txt

#second test
sysbench fileio --file-total-size=70G prepare >> result.txt

sysbench fileio --file-total-size=70G --file-test-mode=rndrw  --max-time=300 --max-requests=0  run >> result.txt

sysbench fileio cleanup >> result.txt

# to fix name not working for now

data=$(cat result.txt)
curl -d "body=$data" -X POST http://3.84.96.27/file
