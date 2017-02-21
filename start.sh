IP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`

cabal run -- $IP
