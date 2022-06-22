const main = async () => {
    // adding wallet adderesses
    const [owner, randomPerson] = await hre.ethers.getSigners();
    // compile contract and generate the necessary files we need to work with our contract under the artifacts directory
    const ContractFactory = await hre.ethers.getContractFactory("Greeter");
    // create a local Ethereum network for us, but just for this contract and sending ether to it
    const Contract = await ContractFactory.deploy("check");
    await Contract.deployed();

    console.log("Contract deployed to:", Contract.address);
    console.log("Contract deployed by:", owner.address);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0); // exit Node process without error
    } catch (error) {
      console.log(error);
      process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
    }
  };
  
  runMain();