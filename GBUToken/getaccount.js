async function getAccount() {
    if (typeof window.ethereum !== 'undefined') {
        web3 = new Web3(web3.currentProvider);
    }
    else{
        web3 = ethereum.request({ method: 'eth_requestAccounts' });
    }
    const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
    const account = accounts[0];
    showAccount.innerHTML = account;
    return account;
}