# Only one single output remains unspent from block 123,321. What address was it sent to?

blockhash=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash 123321)

txids=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock "$blockhash" | jq -r '.tx[]')

for txid in $(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock "$blockhash" | jq -r '.tx[]')
do
    echo $(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getrawtransaction "$txid" true | jq -r '.vout | select(.spent==false) | .scriptPubKey.addresses[0]')
done