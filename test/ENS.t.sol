// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";
import "../script/ENS.s.sol";
contract ENSTest is Test {
    ENSRegistry ens;
    PublicResolver resolver;
    FIFSRegistrar registrar;
    ReverseRegistrar reverseRegistrar;
    address deployer; 
    bytes32 exampleNode = bytes32(0);

    function setUp() public {
        ENSScript script = new ENSScript();
        (ens, resolver, registrar, reverseRegistrar, deployer) = script.run();
    }

    function testExample() public {
        vm.startPrank(deployer);
        ens.setResolver(exampleNode, address(resolver));
        resolver.setName(exampleNode, "example.eth");
        console.log(resolver.name(exampleNode));
        vm.stopPrank();
    }
}
