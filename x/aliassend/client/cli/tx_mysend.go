package cli

import (
	sdk "github.com/cosmos/cosmos-sdk/types"
	"strconv"

	"aliassend/x/aliassend/types"
	"github.com/cosmos/cosmos-sdk/client"
	"github.com/cosmos/cosmos-sdk/client/flags"
	"github.com/cosmos/cosmos-sdk/client/tx"
	"github.com/spf13/cobra"
)

var _ = strconv.Itoa(0)

func CmdMysend() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "mysend [alias] [from] [to] [coin]",
		Short: "Broadcast message mysend",
		Args:  cobra.ExactArgs(4),
		RunE: func(cmd *cobra.Command, args []string) (err error) {
			argAlias := args[0]
			argFrom := args[1]
			argTo := args[2]
			//argCoin := args[3]

			cmd.Flags().Set(flags.FlagFrom, args[0])
			clientCtx, err := client.GetClientTxContext(cmd)
			if err != nil {
				return err
			}

			decCoin, err := sdk.ParseDecCoin(args[3])
			if err != nil {
				return err
			}
			coin, _ := sdk.NormalizeDecCoin(decCoin).TruncateDecimal()

			msg := types.NewMsgMysend(
				clientCtx.GetFromAddress().String(),
				argAlias,
				argFrom,
				argTo,
				&coin,
			)
			if err := msg.ValidateBasic(); err != nil {
				return err
			}
			return tx.GenerateOrBroadcastTxCLI(clientCtx, cmd.Flags(), msg)
		},
	}

	flags.AddTxFlagsToCmd(cmd)

	return cmd
}
