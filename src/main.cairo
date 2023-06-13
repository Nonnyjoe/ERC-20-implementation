#[Contract]
mod ERC_20 {
    // Library imports
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use array::ArrayTrait;

    struct storage {}

    #[external]
    fn transferSuccesful() {}

    #[view]
    fn balance() -> u64 {}

    #[external]
    fn grant_allowance() {}
}
