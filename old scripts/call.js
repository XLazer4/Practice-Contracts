const web3 = new Web3("http://localhost:8545")

const daiToken = new web3.eth.Contract(ERC20TransferABI, DAI_ADDRESS)

const senderAddress = "0x204E7F44b9f6cB9784c865D14a4773d79BF605c4"
const receiverAddress = "0x609FEd289fe317225Fc1AD4bABb5c3da496a6d20"

daiToken.methods.balanceOf(senderAddress).call(function (err, res) {
    if (err) {
      console.log("An error occured", err)
      return
    }
    console.log("The balance is: ", res)
  })  