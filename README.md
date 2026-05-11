# HASH256 GPU Miner

HASH256 proof-of-work CLI miner using NVIDIA CUDA GPU.

**RTX 4090 实测：~4.6 GH/s**

## 原理

```
keccak256(challenge || nonce) < difficulty
```

合约地址（Ethereum mainnet）：`0xAC7b5d06fa1e77D08aea40d46cB7C5923A87A0cc`

## 安装

需要：Node.js、CUDA Toolkit（nvcc）、NVIDIA 驱动

```bash
git clone https://github.com/fanqieBTC/hash256-cli.git
cd hash256-cli
npm install
npm run assets
npm run build:cuda
```

其他 GPU 架构（默认 `sm_89` 适用于 RTX 4090）：

```bash
CUDA_ARCH=sm_86 sh build-cuda.sh   # RTX 3090
CUDA_ARCH=sm_80 sh build-cuda.sh   # A100
```

## 配置

```bash
cp .env.example .env
nano .env
```

```text
HASH256_RPC_URL=https://rpc.mevblocker.io/fast
PRIVATE_KEY=0xYourPrivateKey
```

## 使用

查看链上状态：

```bash
node hash256-cli.js status
```

基准测试：

```bash
node hash256-cli.js bench --engine cuda --seconds 10
```

挖矿（提交交易）：

```bash
node hash256-cli.js mine --engine cuda --submit --loop
```

只挖不提交：

```bash
node hash256-cli.js mine --address 0xYourAddress --engine cuda --loop
```

## Ubuntu 服务器（systemd）

```bash
cp .env.example .env && nano .env
bash scripts/install-linux-service.sh
journalctl -u hash256-miner -f
```

## 停止

```bash
sudo systemctl stop hash256-miner
# 或
pkill -f hash256-cuda-miner
```
