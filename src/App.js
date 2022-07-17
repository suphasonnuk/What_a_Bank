import logo from './logo.svg';
import './App.css';
import erc20ABI from "./abi/ERC20ABI.json";
import bankingABI from "./abi/BankingABI.json";
import {useState , useEffect} from "react"
import {ethers} from "ethers"
import Body from "./body"
// import Navbar from './navbar';

import WalletCardEthers from'./WalletCard';

function App() {

  return (
    <div className="App">
      <WalletCardEthers/>
      <Body></Body>
    </div>
  );
}

export default App;