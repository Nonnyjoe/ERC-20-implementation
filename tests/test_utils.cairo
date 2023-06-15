use ERC20::contract::ERC_20;
use starknet::contract_address_const;
use starknet::ContractAddress;
use starknet::testing::set_caller_address;
use protostar_print::PrintTrait;
use result::ResultTrait;
use array::ArrayTrait;
use starknet::get_caller_address;


const NAME: felt252 = 'Hope';
const SYMBOL: felt252 = 'HPE';

// #[test]
// #[available_gas(200000)]
fn setup() -> felt252 {
    let mut calldata = ArrayTrait::new();
    calldata.append(NAME);
    calldata.append(SYMBOL);
    calldata.append(18);
    calldata.append(1800);
    let deployed_contract_address = deploy_contract('ERC20', @calldata).unwrap();
    // invoke(deployed_contract_address, 'hello', @ArrayTrait::new()).unwrap();
    deployed_contract_address.print();
    deployed_contract_address
}

#[test]
#[available_gas(200000)]
fn test_Constructor_initialization() {
    let sender: ContractAddress = contract_address_const::<1>();
    // set_caller_address(sender);
    let contract: felt252 = setup();
    let total_supply = call(contract, 'totalSupply_', @ArrayTrait::new()).unwrap();
    let name_ = call(contract, 'name_', @ArrayTrait::new()).unwrap();
    assert(*total_supply.at(0) == 1800, 'FAILED INITIALIZATION');
    assert(*name_.at(0) == 'Hope', 'FAILED INITIALIZATION');
}

#[test]
#[available_gas(200000)]
fn test_transfer() {
    let contract: felt252 = setup();
    let recipient: felt252 = contract_address_const::<1>();

    let mut calldata3 = ArrayTrait::new();
    calldata3.append(recipient);
    calldata3.append(200);
    invoke(contract, 'transfer', @calldata3).unwrap();
    let caller: ContractAddress = get_caller_address();
    let mut calldata2 = ArrayTrait::new();
    calldata2.append(caller);
    let caller_balance = call(contract, 'balance_of', @calldata2);
// assert
}

