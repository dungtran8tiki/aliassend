package keeper_test

import (
	"testing"

	testkeeper "aliassend/testutil/keeper"
	"aliassend/x/aliassend/types"
	"github.com/stretchr/testify/require"
)

func TestGetParams(t *testing.T) {
	k, ctx := testkeeper.AliassendKeeper(t)
	params := types.DefaultParams()

	k.SetParams(ctx, params)

	require.EqualValues(t, params, k.GetParams(ctx))
}
