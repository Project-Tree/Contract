init:
	npm init --yes
	npm install --save-dev hardhat
	npx hardhat

install: 
	npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai

compile:
	npx hardhat compile

test:
	npx hardhat test

deploy-local:
	npx hardhat run scripts/deploy.js --network localhost

deploy-testnet:
	npx hardhat run scripts/deploy.js --network ropsten

deploy-mainnet:
	