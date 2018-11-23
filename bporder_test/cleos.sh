#!/bin/bash
#*************************************************************************
#Private key: 5KfoUm5cAqvQNL7xq9w55JP8Sff1EjasfzGTgoVTUTKW5sazsH9
#Public key: EOS6ZoCdrkbuuVggewpv3kkvy4WWnM9hrgPnSm6sRvRPqY6qmxuZY

#Private key: 5K19NUFqP6V6x7MuxcTEjeNxny6sow6t385R52gprfPT9RPvBXo
#Public key: EOS8d5DLVBGi8sbmaNEbPgjKy9qUWJBUHSLqfn4wQLRs6ugvyKhoN
#*************************************************************************
pub_key=EOS7qFV5yUBBJdEu9ZHbSPsj4rLPWMyAeZth97qivEDJsaWMCZdrr
pri_key=5JYVZBVrmb4Wg8aGeAjLHMuWu9r33tAvCrLKbqei3mJh1FQhn5L

p_pubkey1=EOS6neVuYQ2aBkgkR6HEJ8oGCA8ZtSyutuEdHQXyrAfHp2td7j82F
p_prikey1=5KZeBN8FApPTTqxW67p7Wk3j1TryVu2UZQ69du2H6hPGn2a1JB7

p_pubkey2=EOS71jwuHADuNCn75u8fHmJCoDeMWMT48YfGP19ninb8TWZp5nFpJ
p_prikey2=5KNJB6thERehtU8xCxozDkeFtmrYMQFL8tsieTStj6P3q2AeBsm

pub_change1=EOS6ZoCdrkbuuVggewpv3kkvy4WWnM9hrgPnSm6sRvRPqY6qmxuZY
pri_change1=5KfoUm5cAqvQNL7xq9w55JP8Sff1EjasfzGTgoVTUTKW5sazsH9

pub_change2=EOS8d5DLVBGi8sbmaNEbPgjKy9qUWJBUHSLqfn4wQLRs6ugvyKhoN
pri_change2=5K19NUFqP6V6x7MuxcTEjeNxny6sow6t385R52gprfPT9RPvBXo
#TEST_LOG= > test.log 2>&1

# step 3: prepare wallet
cleos wallet create --to-console
cleos wallet import --private-key ${pri_key}
cleos wallet import --private-key ${pri_change1}
cleos wallet import --private-key ${pri_change2}
cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

# step 4: set contract eosio.bios
CONTRACTS_FOLDER='../../bos/build/contracts'

echo -e "\nset contract eosio.bios,you can see the message!! "
cleos  set contract eosio ${CONTRACTS_FOLDER}/eosio.bios -p eosio > test.log 2>&1

# step 5: create system accounts
for account in eosio.bpay eosio.msig eosio.names eosio.ram eosio.ramfee eosio.saving eosio.stake eosio.token eosio.vpay
do
  echo -e "\ncreating $account ";
  cleos create account eosio ${account} EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV > test.log 2>&1;
  sleep 1;
done

# step 6: set contract
echo -e "\nset contract"
cleos set contract eosio.token ${CONTRACTS_FOLDER}/eosio.token -p eosio.token > test.log 2>&1
cleos set contract eosio.msig ${CONTRACTS_FOLDER}/eosio.msig -p eosio.msig > test.log 2>&1

# step 7: create and issue token
cleos push action eosio.token create '["eosio", "10000000000.0000 SYS"]' -p eosio.token > test.log 2>&1
echo -e "\nissue token!! "
cleos push action eosio.token issue '["eosio",  "1000000000.0000 SYS", "cryptokylin"]' -p eosio > test.log 2>&1

# setp 8: setting privileged account for eosio.msig
echo -e "\nset privileged"
cleos push action eosio setpriv '{"account": "eosio.msig", "is_priv": 1}' -p eosio > test.log 2>&1

# step 9: set contract eosio.system
echo -e "\nset system contract"
cleos  set contract eosio ${CONTRACTS_FOLDER}/eosio.system  -p eosio > test.log 2>&1

# step 10: create some account

cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testproducea ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testproduceb ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testproducec ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testproduced ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testproducee ${pub_key} > test.log 2>&1


cleos transfer eosio testproducea "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testproduceb "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testproducec "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testproduced "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testproducee "1000.0000 SYS" > test.log 2>&1


## check eosio balance
cleos  get currency balance eosio.token eosio

#cleos system regproducer  testproducea EOS6neVuYQ2aBkgkR6HEJ8oGCA8ZtSyutuEdHQXyrAfHp2td7j82F https://www.123.com   
sleep 3

echo -e "\n===========================testcase 1========================================"
echo "order is : testproducee testproduced testproducec testproduceb testproducea  "

cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com +12  
cleos system regproducer  testproduceb ${p_pubkey2} https://www.123.com +11  
cleos system regproducer  testproducec ${p_pubkey1} https://www.123.com +10  
cleos system regproducer  testproduced ${p_pubkey2} https://www.123.com +9  
cleos system regproducer  testproducee ${p_pubkey1} https://www.123.com +8  




#delegatebw eos
cleos system delegatebw eosio testproducea "50000000.0000 SYS" "50000000.0000 SYS"
cleos system delegatebw eosio testproduceb "50000000.0000 SYS" "50000000.0000 SYS"
cleos system voteproducer prods  eosio testproducea  testproduceb  testproducec  testproduced testproducee
sleep 0.5
cleos system voteproducer prods  eosio testproducea  testproduceb  testproducec  testproduced testproducee



sleep 50
echo -e "\n===========================testcase 2========================================"
echo "order is : testproducea testproduced testproduceb testproducec testproducee  "


cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com -11  
cleos system regproducer  testproduceb ${p_pubkey2} https://www.123.com -8  
cleos system regproducer  testproducec ${p_pubkey1} https://www.123.com -6
cleos system regproducer  testproduced ${p_pubkey2} https://www.123.com -9  
cleos system regproducer  testproducee ${p_pubkey1} https://www.123.com -4 


sleep 100
echo -e "\n===========================testcase 3========================================"
echo "order is : testproduced testproducea testproduceb testproducec testproducee  "


cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com -6 
cleos system regproducer  testproduceb ${p_pubkey2} https://www.123.com -6  
cleos system regproducer  testproducec ${p_pubkey1} https://www.123.com -6
cleos system regproducer  testproduced ${p_pubkey2} https://www.123.com -9  
cleos system regproducer  testproducee ${p_pubkey1} https://www.123.com -1 


sleep 150
echo -e "\n===========================testcase 4========================================"
echo "order is : testproducea testproducec testproduceb testproduced testproducee  "
cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com 3  
cleos system regproducer  testproduceb ${p_pubkey2} https://www.123.com -9 
cleos system regproducer  testproducec ${p_pubkey1} https://www.123.com 5  
cleos system regproducer  testproduced ${p_pubkey2} https://www.123.com -7  
cleos system regproducer  testproducee ${p_pubkey1} https://www.123.com -3  





sleep 200
echo -e "\n===========================testcase 5========================================"
echo "order is : testproduceb testproduced testproducea testproducec testproducee  "
cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com -11  
cleos system regproducer  testproduceb ${p_pubkey2} https://www.123.com 3  
cleos system regproducer  testproducec ${p_pubkey1} https://www.123.com -5  
cleos system regproducer  testproduced ${p_pubkey2} https://www.123.com 7  
cleos system regproducer  testproducee ${p_pubkey1} https://www.123.com -1  


sleep 250
echo -e "\n===========================testcase 6========================================"
echo "test persent should regin success!!! "
echo "order is : testproduceb testproducea testproduced  testproducec testproducee  "
cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com 5.5 
sleep 1
cleos system regproducer  testproduceb ${p_pubkey2} https://www.123.com 1.6  
sleep 1
cleos system regproducer  testproducec ${p_pubkey1} https://www.123.com -2.5 
sleep 1
cleos system regproducer  testproduced ${p_pubkey2} https://www.123.com -3.1 
sleep 1 
cleos system regproducer  testproducee ${p_pubkey1} https://www.123.com -1  



sleep 300

echo -e "\n===========================testcase 7========================================"
echo "not set the location,have error!"
cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com   


sleep 2
echo -e "\n===========================testcase 8========================================"
echo "not set the location,have error!"
cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com   90



sleep 2
echo -e "\n===========================testcase 9========================================"
echo "not set the location,have error!"
cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com   -12

sleep 2
echo -e "\n===========================testcase 10========================================"
echo "not set the location,have error!"
cleos system regproducer  testproducea ${p_pubkey1} https://www.123.com   -20

