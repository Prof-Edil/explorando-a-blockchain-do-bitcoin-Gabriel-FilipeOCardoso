# Which tx in block 257,343 spends the coinbase output of block 256,128?

#OLHAR A COINBASE DO BLOCO 256128
blockhash2=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash 256128)
bloco2=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock $blockhash2)

coinbase=$(echo $bloco2 | jq -r '.tx[0]')


#ENCONTRAR OS TX DO BLOCO 257343
blockhash=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash 257343)

bloco=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock $blockhash)


for i in $(echo $bloco | jq -r '.tx[@]')
do 
    vindet=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getrawtransaction "$(echo $bloco | jq -r '.tx[i]')" true | jq -r '.vin[]')
    for j in $(echo "$vindet" | jq -r '.txid')
    do
        if [ $j == $coinbase ]
        then
            txf=$(echo $bloco | jq -r '.tx[@]')
            break 2
        fi
    done
done

echo $(echo $bloco | jq -r '.tx[@]')