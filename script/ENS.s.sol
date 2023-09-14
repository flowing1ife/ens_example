// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "../src/ENSRegistry.sol";
import "../src/FIFSRegistrar.sol";
import "../src/PublicResolver.sol";
import "../src/ReverseRegistrar.sol";

contract ENSScript is Script {
    address constant ZERO_ADDRESS = address(0);
    bytes32 constant ZERO_HASH = bytes32(0);

    function run() public returns( ENSRegistry ens, PublicResolver resolver, FIFSRegistrar registrar, ReverseRegistrar reverseRegistrar, address deployer){
        deployer = makeAddr("deployer");
        vm.startBroadcast(deployer);
        
            ens = new ENSRegistry();
            resolver = new PublicResolver(ens, INameWrapper(ZERO_ADDRESS));
            registrar = new FIFSRegistrar(ens, ZERO_HASH);
            reverseRegistrar = new ReverseRegistrar(ens, resolver);
        
        vm.stopBroadcast();  

        vm.label(address(ens), "ens");
        vm.label(address(resolver), "resolver");
        vm.label(address(registrar), "registrar");
        vm.label(address(reverseRegistrar), "reverseRegistrar");
    }
}
