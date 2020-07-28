package types

import (
	sdk "github.com/cosmos/cosmos-sdk/types"
)

const (
	// Bech32Hrp defines the Bech32 prefix of an account's address
	Bech32Hrp = "cia"

	// CoinType  coin in https://github.com/satoshilabs/slips/blob/master/slip-0044.md
	CoinType = 118

	// FullFundraiserPath BIP44Prefix is the parts of the BIP44 HD path that are fixed by what we used during the fundraiser.
	// use the registered cosmos stake token ATOM 118 as coin_type
	// m / purpose' / coin_type' / account' / change / address_index
	FullFundraiserPath = "44'/118'/0'/0/0"

	// Bech32HrpAccAddr defines the Bech32 prefix of an account's address
	Bech32HrpAccAddr = Bech32Hrp
	// Bech32HrpAccPub defines the Bech32 prefix of an account's public key
	Bech32HrpAccPub = Bech32Hrp + sdk.PrefixPublic
	// Bech32HrpValAddr defines the Bech32 prefix of a validator's operator address
	Bech32HrpValAddr = Bech32Hrp + sdk.PrefixValidator + sdk.PrefixOperator
	// Bech32HrpValPub defines the Bech32 prefix of a validator's operator public key
	Bech32HrpValPub = Bech32Hrp + sdk.PrefixValidator + sdk.PrefixOperator + sdk.PrefixPublic
	// Bech32HrpConsAddr defines the Bech32 prefix of a consensus node address
	Bech32HrpConsAddr = Bech32Hrp + sdk.PrefixValidator + sdk.PrefixConsensus
	// Bech32HrpConsPub defines the Bech32 prefix of a consensus node public key
	Bech32HrpConsPub = Bech32Hrp + sdk.PrefixValidator + sdk.PrefixConsensus + sdk.PrefixPublic
) 