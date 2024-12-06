# What is the hash of block 654,321?
blockhash=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getblockhash 654321)
echo $blockhash