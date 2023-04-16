// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

// 3rd leaf
// 0xdca3326ad7e8121bf9cf9c12333e6b2271abe823ec9edfe42f813b1e768fa57b

// root
// 0xcc086fcc038189b4641db2cc4f1de3bb132aefbd65d510d817591550937818c7

// index
// 2

// proof
// 0x8da9e1c820f9dbd1589fd6585872bc1063588625729e7ab0797cfc63a00bd950
// 0x995788ffc103b987ad50f5e5707fd094419eb12d9552cc423bd0cd86a3861433

contract merkleProof {
    function verify(
        bytes32[] calldata proof,
        bytes32 root,
        bytes32 leaf,
        uint index
    ) external pure returns (bool) {
        bytes32 hash = leaf;

        //computing merkle root
        for (uint i = 0; i < proof.length; i++) {
            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proof[i]));
            } else {
                hash = keccak256(abi.encodePacked(proof[i], hash));
            }
            index /= 2;
        }
        return hash == root;
    }
}
