init:
	yarn init --yes
	yarn add --dev hardhat
	npx hardhat

install: 
	yarn add --dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai

compile:
	npx hardhat compile

test:
	npx hardhat test

deploy-local:
	npx hardhat run scripts/deploy.ts --network localhost

deploy-testnet:
	yarn hardhat run scripts/deploy.ts --network ropsten

deploy-mainnet:
	