# Only one single output remains unspent from block 123,321. What address was it sent to?

#!/bin/bash

# Block height to check
block_height=123321

# Get the block hash
block_hash=$(bitcoin-cli getblockhash $block_height)

# Get the block details
block=$(bitcoin-cli getblock $block_hash)

# Iterate over all transactions in the block
for txid in $(echo "$block" | jq -r '.tx[]'); do
    echo "Checking transaction: $txid"

    # Get the transaction details
    tx=$(bitcoin-cli getrawtransaction "$txid" true)

    # Iterate over all outputs (vout) in the transaction
    for vout in $(echo "$tx" | jq -r '.vout[] | .n'); do
        # Check if the output is unspent
        txout=$(bitcoin-cli gettxout "$txid" "$vout")

        if [ "$txout" != "null" ]; then
            # Extract the address from the unspent output
            address=$(echo "$txout" | jq -r '.scriptPubKey.addresses[0]')

            echo "Unspent output found in transaction $txid, vout $vout."
            echo "Address: $address"
            exit 0  # Exit after finding the unspent output
        fi
    done
done
