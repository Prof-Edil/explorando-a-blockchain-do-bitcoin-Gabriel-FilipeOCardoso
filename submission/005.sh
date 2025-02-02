# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

tx="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

#aonde estao as chaves txinwitness
chaves=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getrawtransaction "$tx" true)


#separacao das chaves
#pubkey1="02bbb4ba3f39b5f3258f0014d5e4eab5a6990009e3e1dba6e8eaff10b3832394f7"
#pubkey2="03aaf17b1a7b4108f7e5bc4f7d59c20f7fb1a72dbc74a9a3d6d1f8488df159c760"
#pubkey3="03a6d919c76d9117c23570a767450013edf31cf6be7d3b5a881c06a9aa1f2c24ce"
#pubkey4="0383d12258e3e294a6d7754336f6b4baef992ec4b91694d3460bcb022b11da8cd2"

multisig=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 createmultisig 1 '["02bbb4ba3f39b5f3258f0014d5e4eab5a6990009e3e1dba6e8eaff10b3832394f7","03aaf17b1a7b4108f7e5bc4f7d59c20f7fb1a72dbc74a9a3d6d1f8488df159c760","03a6d919c76d9117c23570a767450013edf31cf6be7d3b5a881c06a9aa1f2c24ce","0383d12258e3e294a6d7754336f6b4baef992ec4b91694d3460bcb022b11da8cd2"]')

address=$(echo $multisig | jq -r '.address')

echo $address