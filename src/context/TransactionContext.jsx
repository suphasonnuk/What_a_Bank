import React , {useEffects , useState} from "react";
import {ethers} from 'ethers';

import {contractABI , contractAddress} from "../utils/constants";

export const TransactionContext = React.createContext();

const {ethereum } = window; 

const getEthererumContract = () => {
    const provider = new ethers.providers.Web3Provider(ethereum);
    const signer = provider.getSigner();
    const transactionContract = new ethers.Contract(contractAddress, contractABI, signer);
    console.log({
        provider, signer, transactionContract
    })
}


export const TransactionProvider = ({children}) =>{
    return(
        <transactionContract.Provider value = {{value : "test"}}>
            {children}
        </transactionContract.Provider>
    )
}