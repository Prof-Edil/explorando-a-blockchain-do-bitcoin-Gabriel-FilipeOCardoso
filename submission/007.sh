# Only one single output remains unspent from block 123,321. What address was it sent to?

blockhash=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash 123321)

txids=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock "$blockhash" | jq -r '.tx[]')

for txid in $(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock "$blockhash" | jq -r '.tx[]')
do
    txdetail=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getrawtransaction "$txids" true)
    echo $txdetail | jq -c '.vout[]' | while read -r VOUT
    do
        if [ $(echo "$VOUT" | jq -r '.spent') == "false" ]; then
            ADDRESS=$(echo "$VOUT" | jq -r '.scriptPubKey.addresses[0]')
            echo "Address with unspent output: $ADDRESS"
        fi
    done
done
