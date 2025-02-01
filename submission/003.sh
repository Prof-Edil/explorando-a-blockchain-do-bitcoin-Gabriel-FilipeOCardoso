# How many new outputs were created by block 123,456?
# instalado jq
hash=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash 123456)

bloco=$(bitcoin-cli -rpconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock $hash 2)

out=$($bloco | jq '[.tx[].vout | length] | add')

