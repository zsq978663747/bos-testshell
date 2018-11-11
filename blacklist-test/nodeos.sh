rm -rf nodeos1-data/data/*
rm -rf wallet/*


../../build/programs/nodeos/nodeos  --config-dir nodeos-data/config --genesis-json nodeos-data/config/genesis.json -d nodeos-data/data
