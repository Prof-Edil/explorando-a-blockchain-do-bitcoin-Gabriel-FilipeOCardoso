# Only one single output remains unspent from block 123,321. What address was it sent to?


block=123321

block_hash=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash $block_height)

block=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock $block_hash)

# Iterate over all transactions in the block
for txid in $(echo "$block" | jq -r '.tx[]'); do
    echo "Checking transaction: $txid"

    tx=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getrawtransaction "$txid" true)

    # Iterate over all outputs (vout) in the transaction
    for vout in $(echo "$tx" | jq -r '.vout[] | .n'); do
        # Check if the output is unspent
        txout=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 gettxout "$txid" "$vout")

        if [ "$txout" != "null" ]; then
            # Extract the address from the unspent output
            address=$(echo "$txout" | jq -r '.scriptPubKey.addresses[0]')

            echo "Unspent output found in transaction $txid, vout $vout."
            echo "Address: $address"
            break 2
        fi
    done
done
