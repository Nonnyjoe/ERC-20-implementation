// mod ERC_20;
#[contract]
mod ERC_20 {
    // Library imports
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use array::ArrayTrait;

    // Contract storage
    struct Storage {
        name: felt252,
        symbol: felt252,
        decimal: u32,
        totalSupply: u32,
        user_balance: LegacyMap::<ContractAddress, u32>,
        allowance: LegacyMap::<(ContractAddress, ContractAddress), u32>,
    }

    // Constructor initialization
    #[constructor]
    fn constructor(name_: felt252, symbol_: felt252, decimal_: u32, totalSupply_: u32) {
        // assert(totalSupply_ != 0_u32, 'Amount cannot be zero');
        name::write(name_);
        symbol::write(symbol_);
        decimal::write(decimal_);
        totalSupply::write(totalSupply_);
        let msg_sender: ContractAddress = get_caller_address();
        // _mint(msg_sender, totalSupply::read());
        // decimal::write(18_u32);
        // totalSupply::write(1800_u32);
        _mint(msg_sender, totalSupply_);
    }

    // Events declarations
    #[events]
    fn transferSuccesful(from: ContractAddress, to: ContractAddress, amount: u32) {}

    #[external]
    fn mintSucessful(user: ContractAddress, amount: u32) {}

    #[events]
    fn allowance_granted(msg_sender: ContractAddress, alawee: ContractAddress, amount: u32) {}

    #[events]
    fn allowance_revoked(msg_sender: ContractAddress, alawee: ContractAddress, amount: u32) {}

    // View functions
    #[view]
    fn name_() -> felt252 {
        name::read()
    }

    #[view]
    fn symbol_() -> felt252 {
        symbol::read()
    }

    #[view]
    fn decimal_() -> u32 {
        decimal::read()
    }

    #[view]
    fn totalSupply_() -> u32 {
        totalSupply::read()
    }

    #[view]
    fn balance_of(user: ContractAddress) -> u32 {
        user_balance::read(user)
    }

    #[view]
    fn check_user_allowance(allower: ContractAddress, allawee: ContractAddress) -> u32 {
        allowance::read((allower, allawee))
    }

    // External function calls
    #[external]
    fn grant_allowance(alawee: ContractAddress, amount: u32) {
        let msg_sender: ContractAddress = get_caller_address();
        let allowance_: u32 = allowance::read((msg_sender, alawee));
        allowance::write((msg_sender, alawee), allowance_ + amount);
        allowance_granted(msg_sender, alawee, amount);
    }

    #[external]
    fn revoke_allowance(alawee: ContractAddress, amount: u32) {
        let msg_sender: ContractAddress = get_caller_address();
        let allowance_: u32 = allowance::read((msg_sender, alawee));
        assert(allowance_ >= amount, 'Insufficient Allowance');
        allowance::write((msg_sender, alawee), allowance_ - amount);
        allowance_revoked(msg_sender, alawee, amount);
    }

    #[external]
    fn transfer_from(mut from: ContractAddress, mut to: ContractAddress, mut amount: u32) {
        let msg_sender: ContractAddress = get_caller_address();
        assert(amount != 0_u32, 'Cannot transfer zero value');
        let allowance_: u32 = allowance::read((from, msg_sender));
        assert(allowance_ >= amount, 'Insufficient Allowance');
        assert(user_balance::read(from) >= amount, 'Insufficient Balance');
        allowance::write((from, msg_sender), allowance_ - amount);
        let status: bool = _transfer(ref from, ref to, ref amount);
        assert(status == true, 'Transfer Failed');
        transferSuccesful(msg_sender, to, amount);
    }

    #[external]
    fn transfer(mut to: ContractAddress, mut amount: u32) {
        let mut msg_sender: ContractAddress = get_caller_address();
        assert(amount != 0_u32, 'Cannot transfer zero value');
        assert(user_balance::read(msg_sender) >= amount, 'Insufficient Balance');
        let status: bool = _transfer(ref msg_sender, ref to, ref amount);
        assert(status == true, 'Transfer Failed');
        transferSuccesful(msg_sender, to, amount);
    }

    // internal functions
    fn _transfer(ref from: ContractAddress, ref to: ContractAddress, ref amount: u32) -> bool {
        user_balance::write(from, user_balance::read(from) - amount);
        user_balance::write(to, user_balance::read(to) + amount);
        true
    }

    fn _mint(user: ContractAddress, amount: u32) {
        user_balance::write(user, amount);
        mintSucessful(user, amount);
    }

    #[external]
    fn add(a: u256, b: u256) -> u256 {
        a + b
    }
}
// #[cfg(test)]
// pub mod test {
//     use starknet::contract_address_const;
//     use starknet::ContractAddress;
//     use starknet::testing::set_caller_address;
//     use protostar_print::PrintTrait;
//     use result::ResultTrait;
// }


