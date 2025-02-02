# Which tx in block 257,343 spends the coinbase output of block 256,128?

#OLHAR A COINBASE DO BLOCO 256128
blockhash2=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash 256128)
bloco2=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock $blockhash2)

coinbase=$(echo $bloco2 | jq -r '.tx[0]')


#ENCONTRAR OS TX DO BLOCO 257343
blockhash=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash 257343)

bloco=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblock $blockhash)

tx=$(echo $bloco | jq -r '.tx[]')

txf=()

for i in $tx
do 
    vindet=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getrawtransaction $tx true | jq -r '.vin[]')
    for j in $(echo "$vindet" | jq -r '.txid')
    do
        if["$j" == "$coinbase"]; then
            txf=$(echo $j)
            break 2
        fi
    done
done

echo $txf