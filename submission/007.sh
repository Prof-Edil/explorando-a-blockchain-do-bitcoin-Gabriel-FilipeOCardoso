# Only one single output remains unspent from block 123,321. What address was it sent to?

hash=$(bitcoin-cli getblockhash 123321)
bloco=$(bitcoin-cli getblock $hash | jq -r '.tx[]')

for txid in $bloco; do

  txsaida=$(bitcoin-cli getrawtransaction $txid true)
  vc=$(echo "$txsaida" | jq '.vout | length')

  for (( i=0; i<$vc; i++ )); do
    address=$(bitcoin-cli gettxout $txid $i)

    if [[ ! -z "$address" ]]; then
      echo $address | jq -r '.scriptPubKey.address'
      break 2
    fi

  done

done