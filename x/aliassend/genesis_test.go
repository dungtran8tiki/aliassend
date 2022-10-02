package aliassend_test

import (
	"testing"

	keepertest "aliassend/testutil/keeper"
	"aliassend/testutil/nullify"
	"aliassend/x/aliassend"
	"aliassend/x/aliassend/types"
	"github.com/stretchr/testify/require"
)

func TestGenesis(t *testing.T) {
	genesisState := types.GenesisState{
		Params: types.DefaultParams(),

		// this line is used by starport scaffolding # genesis/test/state
	}

	k, ctx := keepertest.AliassendKeeper(t)
	aliassend.InitGenesis(ctx, *k, genesisState)
	got := aliassend.ExportGenesis(ctx, *k)
	require.NotNil(t, got)

	nullify.Fill(&genesisState)
	nullify.Fill(got)

	// this line is used by starport scaffolding # genesis/test/assert
}
