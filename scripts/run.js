const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
      value: hre.ethers.utils.parseEther('.1'),
    });
    await waveContract.deployed();
    console.log("Contract address:", waveContract.address);

    // Get contract balance
    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address)
    console.log('Contract Balance before: ', hre.ethers.utils.formatEther(contractBalance));
    
    // Send Wave
    let waveTxn = await waveContract.wave("Test Message! This must work! :)");
    await waveTxn.wait();

    
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address)
    console.log('Contract Balance after: ', hre.ethers.utils.formatEther(contractBalance));

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
  };
  
const runMain = async () => {
    try {
      await main();
      process.exit(0); // exit Node process without error
    } catch (error) {
      console.log(error);
      process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
    }
    // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
  };
  
  runMain();