rm -rf nodeos1-data/data/*
rm -rf wallet/*


../../bos/build/programs/nodeos/nodeos --config-dir nodeos1-data/config --genesis-json nodeos1-data/config/genesis.json -d nodeos1-data/data
