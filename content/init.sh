sudo yum -y install sysbench curl

mkdir /test
cd /test || exit

touch result.txt

# first test CPU
sysbench cpu --cpu-max-prime=20000 run >> result.txt

#second test
sysbench fileio --file-total-size=70G prepare >> result.txt

sysbench fileio --file-total-size=70G --file-test-mode=rndrw  --max-time=300 --max-requests=0  run >> result.txt

sysbench fileio cleanup >> result.txt

# to fix name not working for now

data=$(cat result.txt)
curl -d "body=$data" -X POST http://54.198.238.38/file