const NFTs = []

function mintNFTs (_name, _eyeColor, _shirtType, _accessory) {
    const NFT ={
        name: _name,
        eyeColor: _eyeColor,
        shirtType: _shirtType,
        accessory: _accessory
    }
    NFTs.push(NFT);
    console.log("Minted: " + _name);
}

function listNFTs (){
    for (let i = 0; i <NFTs.length; i++){
        console.log("\nID: \t\t" + (i + 1));
        console.log("Name: \t\t" + NFTs[i].name);
        console.log("Eye color: \t" + NFTs[i].eyeColor);
        console.log("Shirt Type: " + NFTs[i].shirtType);
        console.log("Accessory: \t" + NFTs[i].accessory);
    }
}

function getTotalSupply() {
    console.log("\n" + NFTs.length);
}

// test
mintNFTs("Aaron","Black","Suit","Ring");
mintNFTs("John","Blue","Fleece","Necklace");
mintNFTs("Agatha","Red","Hoodie","Anklet");
mintNFTs("Qoiri","Pink","Sweater","Choker");
listNFTs();
getTotalSupply();
