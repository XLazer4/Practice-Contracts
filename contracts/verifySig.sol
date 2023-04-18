// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

// message to sign -
// hash(message)
// sign(hash(message),private key) - offchain
// ecrecover(hash(message), signature) == signer/public address

contract verifySig {
    function splitSignature(
        bytes memory sig
    ) public pure returns (bytes32 r, bytes32 s, uint8 v) {
        // 32+32+1
        require(sig.length == 65, "invalid signature length");

        assembly {
            /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */

            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }
    }

    function recoverSigner(
        bytes32 _ethSignedMessageHash,
        bytes memory _signature
    ) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        //r,s - cryptographic parameters used for digital signature
        //v - used for ethereum

        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function verify(
        address _signer,
        string calldata _message,
        bytes calldata _sig
    ) external pure returns (bool) {
        bytes32 messageHash = keccak256(abi.encodePacked(_message));
        bytes32 signedMessageHash = keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash)
        );

        return recoverSigner(signedMessageHash, _sig) == _signer;
    }
}
