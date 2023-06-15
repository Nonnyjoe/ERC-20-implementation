use ERC20::contract::ERC_20;
use starknet::contract_address_const;
use starknet::ContractAddress;
use starknet::testing::set_caller_address;
use protostar_print::PrintTrait;
use result::ResultTrait;
use array::ArrayTrait;


// Initializing Setup for tests

// fn setup() -> (ContractAddress, u256) {
//     let name: felt252 = 'Hope Token';
//     let symbol: felt252 = 'HPT';
//     let decimal: u32 = 18_u32;
//     let totalSupply: u256 = 5000_u256;
//     let initial_supply: u256 = 2000;
//     // Set account as default caller
//     let account: ContractAddress = contract_address_const::<1>();
//     set_caller_address(account);
//     // Initialize constructor
//     ERC_20::constructor(name, symbol, decimal, totalSupply);
//     (account, initial_supply)
// }

// // Active testing 
// #[test]
// #[available_gas(2000000)]
// fn test_Constructor_initialization() {
//     let (sender, supply) = setup();
//     assert(ERC_20::balance_of(sender) == 2000, 'User ballance does not tally');
//     assert(ERC_20::totalSupply_() == ERC_20::balance_of(sender), 'Incorrect TS and BAL');
//     let ballance: u256 = ERC_20::balance_of(sender);
//     let totalSupply: u256 = ERC_20::totalSupply_();
//     totalSupply.print();
//     ballance.print();
// }

// #[test]
// #[available_gas(2000000)]
// fn test_transfer() {
//     let (sender, supply) = setup();
//     let recipient: ContractAddress = contract_address_const::<2>();
//     let transferAmount: u256 = 200;
//     let senderBalance: u256 = ERC_20::balance_of(sender);
//     ERC_20::transfer(recipient, transferAmount);
//     assert(ERC_20::balance_of(recipient) == transferAmount, 'Receiver ballance Error');
//     assert(
//         ERC_20::balance_of(sender) == senderBalance - transferAmount,
//         'Sender ballance does not tally'
//     );
// }

// #[test]
// #[available_gas(2000000)]
// fn test_grant_allowance() {
//     let (sender, supply) = setup();
//     let recipient: ContractAddress = contract_address_const::<2>();
//     let Allowance_amount: u256 = 200;
//     ERC_20::grant_allowance(recipient, Allowance_amount);
//     assert(ERC_20::check_user_allowance(sender, recipient) == Allowance_amount, 'Allowance Error');
// }

// // EXPECTED FAILURES 
// #[test]
// #[available_gas(2000000)]
// #[should_panic(expected: ('Insufficient Allowance', ))]
// fn test_transfer_above_allowance() {
//     let (sender, supply) = setup();
//     let recipient: ContractAddress = contract_address_const::<2>();
//     let Allowance_amount: u256 = 200;
//     ERC_20::grant_allowance(recipient, Allowance_amount);

//     set_caller_address(recipient);
//     ERC_20::transfer_from(sender, recipient, 300)
// }

// #[test]
// #[available_gas(2000000)]
// #[should_panic(expected: ('Insufficient Balance', ))]
// fn test_insufficeient_balance() {
//     let (sender, supply) = setup();
//     let recipient: ContractAddress = contract_address_const::<2>();
//     let transferAmount: u256 = 200;
//     let senderBalance: u256 = ERC_20::balance_of(sender);
//     ERC_20::transfer(recipient, transferAmount + senderBalance);
// }
///////////////////////////////////////////////////////////////////////
///////////// INTEGRATION TESTING /////////////////////////////////////
///////////////////////////////////////////////////////////////////////

// testing 
#[test]
#[available_gas(2000000)]
fn test_add() {
    // setup();
    let c: u256 = ERC_20::add(6, 6);
    assert(c == 12, 'fghfyfty');
    c.print();
}

