# Only one single output remains unspent from block 123,321. What address was it sent to?


blockh=123321

# hash do bloco
block_hash=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash $blockh)

bloco=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock $block_hash)

# todas as transações do bloco
for txid in $(echo $bloco | jq -r '.tx[]') 
do

    tx=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getrawtransaction "$txid" true)
    vcont=$(echo "$tx" | jq '.vout | length')

    for i in $vcont
    do
        txout=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 gettxout $txid $i)

        # Se txout  (not null), então unspent output
        if [[ ! -z "$txout" ]]
        then
            # the address
            address=$(echo $txout | jq -r '.scriptPubKey.addresses')

            echo "Address: $address"
            break 2  # Break both loops as we found the unspent output
        fi
    done
done

