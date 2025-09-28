tolk 1.1

struct Claim {
    amount: int;
    claimedAt: uint32;
}

struct Storage {
    claims: map<address, Claim>;
    totalTokens: int;
    description: string;
}

fun Storage.load() = Storage.fromCell(contract.getData());
fun Storage.save(self) = contract.setData(self.toCell());

fun claimTokens(amount: int) {
    var st = Storage.load();
    let caller = get_caller();

    st.totalTokens += amount;
    st.claims.set(caller, Claim{amount: amount, claimedAt: blockchain.now()});
    st.description = "Airdrop contract storing user claims in a map, causing storage overload.";
    st.save();
}
