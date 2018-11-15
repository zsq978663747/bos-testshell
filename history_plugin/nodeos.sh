rm -rf nodeos-data/data/*
rm -rf wallet/*


/usr/local/eosio/bin/nodeos  --config-dir nodeos-data/config --genesis-json nodeos-data/config/genesis.json -d nodeos-data/data
