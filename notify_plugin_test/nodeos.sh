
if [ "$1" == "" ]
then
    echo "please input the dir of config"
    exit 0
fi 
rm -rf  $1/data/*
rm -rf wallet/*


/usr/local/eosio/bin/nodeos --config-dir $1/config --genesis-json $1/config/genesis.json -d $1/data
