# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

txid="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"

tx=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_225 -rpcpassword=V4elTiWX5gf6 getrawtransaction "$txid" true)

pubkey="6321025d524ac7ec6501d018d322334f142c7c11aa24b9cffec03161eca35a1e32a71f67029000b2752102ad92d02b7061f520ebb60e932f9743a43fee1db87d2feb1398bf037b3f119fc268ac"

echo $pubkey