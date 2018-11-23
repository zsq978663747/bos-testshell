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
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testalaction ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testerzsq111 ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testerzsq112 ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testerzsq113 ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testerzsq114 ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testerzsq115 ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testerzsq121 ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testerzsq122 ${pub_key} > test.log 2>&1

cleos system newaccount --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "10.0000 SYS"  eosio testproducer ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testproduces ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testerecieve ${pub_key} > test.log 2>&1
cleos system newaccount --stake-net "500.0000 SYS" --stake-cpu "500.0000 SYS" --buy-ram "10.0000 SYS"  eosio testerproxys ${pub_key} > test.log 2>&1


cleos transfer eosio testalaction "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testerzsq111 "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testerzsq112 "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testerzsq113 "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testerzsq114 "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testerzsq115 "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testerzsq121 "1000.0000 SYS" > test.log 2>&1
cleos transfer eosio testerzsq122 "1000.0000 SYS" > test.log 2>&1

cleos transfer eosio testerecieve "100001000.0000 SYS" > test.log 2>&1
cleos transfer eosio testproducer "100001000.0000 SYS" > test.log 2>&1


## check eosio balance
cleos  get currency balance eosio.token eosio

cleos system regproducer  testproducer ${p_pubkey1} https://www.123.com 9  > test.log 2>&1
cleos system regproducer  testproduces ${p_pubkey2} https://www.123.com 9  > test.log 2>&1
cleos system regproxy testerproxys > test.log 2>&1

#delegatebw eos
cleos system delegatebw testerecieve testerecieve "50000000.0000 SYS" "50000000.0000 SYS"
cleos system delegatebw testproducer testproducer "50000000.0000 SYS" "50000000.0000 SYS"
cleos system voteproducer prods  testerecieve testproducer  testproduces
cleos system voteproducer prods  testproducer testproducer  testproduces



echo "==========================================test case start=============================================\n"
sleep 5
echo "************************************************\n"
echo "*** test case 1: testalaction:               ***\n"
echo "*** test case quantity: 26                   ***\n"
echo "************************************************\n"

sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | transfer   |  should see message on the server   |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos transfer testalaction testerecieve "10.0000 SYS"

sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | revice token |should see message on the server   |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos transfer testalaction testerzsq111 "20.0000 SYS"

sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | delegatebw testalaction |  should see message on the server  |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system delegatebw testalaction testalaction "10.0000 SYS" "10.0000 SYS"
sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | delegatebw testerecieve |  should see message on the server  |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
cleos system delegatebw testalaction testerecieve "20.0000 SYS" "20.0000 SYS"

sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | undelegatebw testalaction |  should see message on the server  |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
cleos system undelegatebw testalaction testalaction "10.0000 SYS" "10.0000 SYS"

sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | undelegatebw testerecieve |  should see message on the server  |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
cleos system undelegatebw testalaction testerecieve "20.0000 SYS" "20.0000 SYS"


sleep 3 
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | regproducer    |  should see message on the server  |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system regproducer  testalaction ${pub_key} https://www.123.com 9
sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | unregprod  |  should see message on the server      |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system unregprod  testalaction 

sleep 3 
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | voteproducer proxy | should see message on the server |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system voteproducer proxy testalaction  testerproxys
sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | voteproducer prods |  should see message on the server  |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system voteproducer prods  testalaction testproducer
sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | voteproducer approve | should see message on the server |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system voteproducer approve  testalaction  testproduces
sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | voteproducer unapprove |should see message on the server|"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system voteproducer unapprove  testalaction   testproducer

sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | buyram for self |  should see message on the server |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system buyram testalaction testalaction "5.0000 SYS"
sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | buyram for testerecieve |  should see message on the server |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system buyram testalaction testerecieve "5.0000 SYS"
sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | buyram from testerecieve |  should see message on the server |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system buyram testerecieve testalaction "5.0000 SYS"
sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | sellram |  should see message on the server |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system sellram testalaction 100

sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | regproxy | should see message on the server |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system regproxy testalaction
sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | unregproxy | should see message on the server|"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos system unregproxy testalaction

sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | set  contract   | should see message on the server |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos set contract testalaction ${CONTRACTS_FOLDER}/eosio.token -p testalaction 
sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | set clear | should see message on the server |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos set contract testalaction ${CONTRACTS_FOLDER}/eosio.token -c 

sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | set code  | should see message on the server |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos set code testalaction ${CONTRACTS_FOLDER}/eosio.token/eosio.token.wasm -p testalaction 
sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | set clear | should see message on the server |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos set code testalaction ${CONTRACTS_FOLDER}/eosio.token -c 

sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | set abi  | should see message on the server |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos set abi testalaction ${CONTRACTS_FOLDER}/eosio.token/eosio.token.abi -p testalaction 
sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | set clear | should see message on the server |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos set abi testalaction ${CONTRACTS_FOLDER}/eosio.token -c 

sleep 3
echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | set clear | should see message on the server |"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos set account  permission testalaction owner  EOS6ZoCdrkbuuVggewpv3kkvy4WWnM9hrgPnSm6sRvRPqY6qmxuZY -p testalaction@owner
sleep 3
echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "| testalaction | set account  | should see message on the server |"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
cleos set account  permission testalaction active  EOS6ZoCdrkbuuVggewpv3kkvy4WWnM9hrgPnSm6sRvRPqY6qmxuZY



sleep 5
echo "==========================================test case end=============================================\n"
echo "=======         we should see [ 26 ]   messages  from the server                     ===================\n"
