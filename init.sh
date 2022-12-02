KEY="mykey"
CHAINID="aliassend"
MONIKER="localtestnet"
KEYRING="test"
LOGLEVEL="info"
# to trace evm
#TRACE="--trace"
TRACE=""

# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

rm -rf ~/.aliassend*

# Reinstall daemon
#make install

# Set client config
aliassendd config keyring-backend $KEYRING
aliassendd config chain-id $CHAINID

# if $KEY exists it should be deleted
aliassendd keys add $KEY --keyring-backend $KEYRING

# Set moniker and chain-id for Evmos (Moniker can be anything, chain-id must be an integer)
aliassendd init $MONIKER --chain-id $CHAINID

# Change parameter token denominations to aastra
#cat $HOME/.aliassendd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="aastra"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json
#cat $HOME/.aliassendd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="aastra"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json
#cat $HOME/.aliassendd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aastra"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json
#cat $HOME/.aliassendd/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="aastra"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json
#cat $HOME/.aliassendd/config/genesis.json | jq '.app_state["distribution"]["params"]["community_tax"]="0.0"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json


# cat $HOME/.aliassendd/config/genesis.json | jq '.app_state["epochs"]["epochs"][0]["identifier"]="hour"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json
# cat $HOME/.aliassendd/config/genesis.json | jq '.app_state["epochs"]["epochs"][0]["duration"]="3600s"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json
# cat $HOME/.aliassendd/config/genesis.json | jq '.app_state["inflation"]["epoch_identifier"]="hour"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json

# increase block time (?)
#cat $HOME/.aliassendd/config/genesis.json | jq '.consensus_params["block"]["time_iota_ms"]="1000"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json

# Set gas limit in genesis
#cat $HOME/.aliassendd/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="10000000"' > $HOME/.aliassendd/config/tmp_genesis.json && mv $HOME/.aliassendd/config/tmp_genesis.json $HOME/.aliassendd/config/genesis.json

# disable produce empty block
#if [[ "$OSTYPE" == "darwin"* ]]; then
#    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.aliassendd/config/config.toml
#  else
#    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.aliassendd/config/config.toml
#fi

if [[ $1 == "pending" ]]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.aliassendd/config/config.toml
      sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.aliassendd/config/config.toml
      sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.aliassendd/config/config.toml
      sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.aliassendd/config/config.toml
      sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.aliassendd/config/config.toml
      sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.aliassendd/config/config.toml
      sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.aliassendd/config/config.toml
      sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.aliassendd/config/config.toml
      sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.aliassendd/config/config.toml
  else
      sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.aliassendd/config/config.toml
      sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.aliassendd/config/config.toml
      sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.aliassendd/config/config.toml
      sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.aliassendd/config/config.toml
      sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.aliassendd/config/config.toml
      sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.aliassendd/config/config.toml
      sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.aliassendd/config/config.toml
      sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.aliassendd/config/config.toml
      sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.aliassendd/config/config.toml
  fi
fi

# Allocate genesis accounts (cosmos formatted addresses)
aliassendd add-genesis-account $KEY 1000stake --keyring-backend $KEYRING

# Sign genesis transaction
aliassendd gentx $KEY 100stake --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
aliassendd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
aliassendd validate-genesis

if [[ $1 == "pending" ]]; then
  echo "pending mode is on, please wait for the first block committed."
fi

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
aliassendd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001stake