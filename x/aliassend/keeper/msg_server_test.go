package keeper_test

import (
	"context"
	"testing"

	keepertest "aliassend/testutil/keeper"
	"aliassend/x/aliassend/keeper"
	"aliassend/x/aliassend/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
)

func setupMsgServer(t testing.TB) (types.MsgServer, context.Context) {
	k, ctx := keepertest.AliassendKeeper(t)
	return keeper.NewMsgServerImpl(*k), sdk.WrapSDKContext(ctx)
}
