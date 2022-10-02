package types

import (
	sdk "github.com/cosmos/cosmos-sdk/types"
	sdkerrors "github.com/cosmos/cosmos-sdk/types/errors"
)

const TypeMsgMysend = "mysend"

var _ sdk.Msg = &MsgMysend{}

func NewMsgMysend(creator string, alias string, from string, to string, coin *sdk.Coin) *MsgMysend {
	return &MsgMysend{
		Creator: creator,
		Alias:   alias,
		From:    from,
		To:      to,
		Coin:    coin,
	}
}

func (msg *MsgMysend) Route() string {
	return RouterKey
}

func (msg *MsgMysend) Type() string {
	return TypeMsgMysend
}

func (msg *MsgMysend) GetSigners() []sdk.AccAddress {
	creator, err := sdk.AccAddressFromBech32(msg.Creator)
	if err != nil {
		panic(err)
	}
	return []sdk.AccAddress{creator}
}

func (msg *MsgMysend) GetSignBytes() []byte {
	bz := ModuleCdc.MustMarshalJSON(msg)
	return sdk.MustSortJSON(bz)
}

func (msg *MsgMysend) ValidateBasic() error {
	_, err := sdk.AccAddressFromBech32(msg.Creator)
	if err != nil {
		return sdkerrors.Wrapf(sdkerrors.ErrInvalidAddress, "invalid creator address (%s)", err)
	}
	return nil
}
