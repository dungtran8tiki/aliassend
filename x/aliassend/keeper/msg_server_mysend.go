package keeper

import (
	"aliassend/x/aliassend/types"
	"context"
	"fmt"
	sdk "github.com/cosmos/cosmos-sdk/types"
)

func (k msgServer) Mysend(goCtx context.Context, msg *types.MsgMysend) (*types.MsgMysendResponse, error) {
	ctx := sdk.UnwrapSDKContext(goCtx)

	// TODO: Handling the message

	from, err := sdk.AccAddressFromBech32(msg.From)
	if err != nil {
		return nil, err
	}
	to, err := sdk.AccAddressFromBech32(msg.To)
	if err != nil {
		return nil, err
	}

	err = k.bankKeeper.SendCoins(ctx, from, to, sdk.Coins{*msg.Coin})
	if err != nil {
		return nil, fmt.Errorf("@@@@ sendcoins failed")
	}

	return &types.MsgMysendResponse{}, nil
}
