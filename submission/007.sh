# Only one single output remains unspent from block 123,321. What address was it sent to?

blockhash=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash 123321)

bloco=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock "$blockhash")

for txid in $(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock "$bloco" | jq -r '.tx[]')
do
    echo $(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock "$bloco" | jq -r '.tx[]')
    tx=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getrawtransaction "$txid" true)

    for vout in $(echo $tx | jq -r '.vout[] | .n')
    do
        # Verifique se a saída foi gasta usando gettxout
        txout=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 gettxout "$txid" "$vout")

        # Se gettxout retornar null, a saída foi gasta
        if [ $txout == null ] 
        then
            echo "Saída $vout da transação $txid FOI GASTA."
        else
            echo "Saída $vout da transação $txid NÃO FOI GASTA."
            saidatx=$(echo $vout)
            break 2
        fi
    done
done

echo $saidatx | jq -r '.vout[].scriptPubKey.addresses[]'