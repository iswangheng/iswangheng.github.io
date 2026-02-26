# API 文档

## 概述

链上监控技能使用以下免费 API：

- **Etherscan** - ETH 链数据查询
- **Solscan** - Solana 链数据查询
- **Dexscreener** - DEX 价格和交易数据
- **Honeypot.is** - 貔貅盘检测

## Etherscan API

### 基本信息

- 官网: https://etherscan.io/apis
- 免费版限制: 5 calls/second, 100,000 calls/day
- 需要 API Key

### 常用端点

#### 获取 ETH 价格
```
GET https://api.etherscan.io/api
  ?module=stats
  &action=ethprice
  &apikey=YOUR_KEY
```

#### 获取账户交易列表
```
GET https://api.etherscan.io/api
  ?module=account
  &action=txlist
  &address=ADDRESS
  &startblock=0
  &endblock=99999999
  &page=1
  &offset=100
  &sort=desc
  &apikey=YOUR_KEY
```

#### 获取 ERC20 转账
```
GET https://api.etherscan.io/api
  ?module=account
  &action=tokentx
  &address=ADDRESS
  &page=1
  &offset=100
  &sort=desc
  &apikey=YOUR_KEY
```

#### 获取区块信息
```
GET https://api.etherscan.io/api
  ?module=proxy
  &action=eth_getBlockByNumber
  &tag=0x10d4f
  &boolean=true
  &apikey=YOUR_KEY
```

## Solscan API

### 基本信息

- 官网: https://solscan.io/api/v1/docs
- 免费版限制: 根据官方文档
- API Key 可选，建议使用

### 常用端点

#### 获取账户交易
```
GET https://public-api.solscan.io/account/transactions
  ?account=ADDRESS
  &limit=50
```

#### 获取代币转账
```
GET https://public-api.solscan.io/account/token/transactions
  ?account=ADDRESS
  &limit=50
```

## Dexscreener API

### 基本信息

- 官网: https://dexscreener.com/api
- 免费，无限制
- 无需 API Key

### 常用端点

#### 搜索交易对
```
GET https://api.dexscreener.com/latest/dex/search?q=QUERY
```

#### 获取代币信息
```
GET https://api.dexscreener.com/latest/dex/tokens/TOKEN_ADDRESS
```

#### 获取交易对信息
```
GET https://api.dexscreener.com/latest/dex/pairs/CHAIN/PAIR_ADDRESS
```

### 响应示例

```json
{
  "pairs": [
    {
      "chainId": "ethereum",
      "dexId": "uniswap",
      "url": "https://dexscreener.com/ethereum/0x...",
      "pairAddress": "0x...",
      "baseToken": {
        "address": "0x...",
        "name": "Token Name",
        "symbol": "TKN"
      },
      "quoteToken": {
        "address": "0x...",
        "name": "Wrapped Ether",
        "symbol": "WETH"
      },
      "priceNative": "0.000000123",
      "priceUsd": "0.000456",
      "txns": {
        "h24": { "buys": 100, "sells": 50 }
      },
      "volume": {
        "h24": 123456.78
      },
      "liquidity": {
        "usd": 500000
      },
      "pairCreatedAt": 1234567890
    }
  ]
}
```

## Honeypot.is API

### 基本信息

- 官网: https://honeypot.is
- 免费 API
- 用于检测貔貅盘

### 端点

```
GET https://api.honeypot.is/v2/IsHoneypot
  ?address=TOKEN_ADDRESS
  &chainID=1
```

### 响应示例

```json
{
  "isHoneypot": false,
  "tax": {
    "buy": 5,
    "sell": 5
  },
  "simulationResult": {
    "buySuccess": true,
    "sellSuccess": true
  }
}
```

## Rate Limit 处理

所有 API 请求都应该：

1. 添加适当的延迟（推荐 250-500ms）
2. 处理 429 错误（Too Many Requests）
3. 实现指数退避重试
4. 记录失败请求以便调试

### 示例代码

```javascript
async function requestWithRetry(url, maxRetries = 3) {
    for (let i = 0; i < maxRetries; i++) {
        try {
            const response = await fetch(url);
            
            if (response.status === 429) {
                const delay = Math.pow(2, i) * 1000;
                await sleep(delay);
                continue;
            }
            
            return await response.json();
        } catch (e) {
            if (i === maxRetries - 1) throw e;
        }
    }
}
```

## 错误处理

### 常见错误

1. **429 Too Many Requests** - 降低请求频率
2. **401 Unauthorized** - 检查 API Key
3. **404 Not Found** - 检查地址格式
4. **Timeout** - 增加超时时间或重试

### 最佳实践

1. 缓存常用数据（如 ETH 价格）
2. 批量请求合并
3. 使用请求队列
4. 监控 API 使用量
