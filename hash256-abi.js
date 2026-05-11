export const HASH256_ADDRESS = "0xAC7b5d06fa1e77D08aea40d46cB7C5923A87A0cc";

export const HASH256_ABI = [
  {
    type: "function",
    stateMutability: "view",
    name: "balanceOf",
    inputs: [{ name: "account", type: "address" }],
    outputs: [{ type: "uint256" }],
  },
  {
    type: "function",
    stateMutability: "view",
    name: "genesisState",
    inputs: [],
    outputs: [
      { name: "minted", type: "uint256" },
      { name: "remaining", type: "uint256" },
      { name: "ethRaised", type: "uint256" },
      { name: "complete", type: "bool" },
    ],
  },
  {
    type: "function",
    stateMutability: "view",
    name: "miningState",
    inputs: [],
    outputs: [
      { name: "era", type: "uint256" },
      { name: "reward", type: "uint256" },
      { name: "difficulty", type: "uint256" },
      { name: "minted", type: "uint256" },
      { name: "remaining", type: "uint256" },
      { name: "epoch", type: "uint256" },
      { name: "epochBlocksLeft", type: "uint256" },
    ],
  },
  {
    type: "function",
    stateMutability: "view",
    name: "currentDifficulty",
    inputs: [],
    outputs: [{ type: "uint256" }],
  },
  {
    type: "function",
    stateMutability: "view",
    name: "getChallenge",
    inputs: [{ name: "miner", type: "address" }],
    outputs: [{ type: "bytes32" }],
  },
  {
    type: "function",
    stateMutability: "nonpayable",
    name: "mine",
    inputs: [{ name: "nonce", type: "uint256" }],
    outputs: [],
  },
  {
    type: "event",
    name: "Mined",
    inputs: [
      { name: "miner", type: "address", indexed: true },
      { name: "nonce", type: "uint256", indexed: false },
      { name: "reward", type: "uint256", indexed: false },
      { name: "era", type: "uint256", indexed: false },
    ],
  },
];
