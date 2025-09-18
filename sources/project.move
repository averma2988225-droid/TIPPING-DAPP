<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🚀 Aptos Simple Tipping DApp</title>
    <script src="https://unpkg.com/aptos@latest/dist/index.global.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
            padding: 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            color: white;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .setup-section {
            background: #e8f4fd;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 4px solid #2196f3;
        }

        .setup-section h3 {
            color: #1976d2;
            margin-bottom: 10px;
        }

        .code-block {
            background: #2d3748;
            color: #e2e8f0;
            padding: 15px;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            font-size: 14px;
            overflow-x: auto;
            margin: 10px 0;
        }

        .wallet-status {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .status-item {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .status-label {
            font-size: 0.85rem;
            color: #6c757d;
            margin-bottom: 5px;
        }

        .status-value {
            font-weight: bold;
            color: #343a40;
        }

        .connect-btn {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }

        .connect-btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
        }

        .connect-btn:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .action-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        @media (max-width: 768px) {
            .action-section {
                grid-template-columns: 1fr;
            }
        }

        .action-card {
            background: #ffffff;
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 25px;
            transition: all 0.3s;
        }

        .action-card:hover {
            border-color: #667eea;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.15);
        }

        .action-card h3 {
            color: #495057;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .action-btn {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .action-btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .action-btn:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
        }

        .tips-section {
            background: #ffffff;
            border-radius: 15px;
            padding: 25px;
            border: 2px solid #e9ecef;
        }

        .tips-section h3 {
            color: #495057;
            margin-bottom: 20px;
            text-align: center;
        }

        .tip-display {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }

        .tip-amount {
            font-size: 2rem;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 10px;
        }

        .tip-details {
            color: #6c757d;
            margin-bottom: 15px;
        }

        .tip-message {
            background: #fff3cd;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #ffc107;
            font-style: italic;
            color: #856404;
        }

        .loading {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            border-left: 4px solid #dc3545;
        }

        .success {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            border-left: 4px solid #28a745;
        }

        .contract-info {
            background: #fff3cd;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            border-left: 4px solid #ffc107;
        }

        .contract-info h4 {
            color: #856404;
            margin-bottom: 10px;
        }

        .contract-address {
            font-family: 'Courier New', monospace;
            background: white;
            padding: 10px;
            border-radius: 5px;
            word-break: break-all;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Simple Aptos Tipping DApp</h1>
            <p>Send APT tips using Move smart contracts</p>
        </div>

        <div class="setup-section">
            <h3>📋 Quick Setup Instructions</h3>
            <p><strong>1. Install Prerequisites:</strong></p>
            <div class="code-block">winget install Git.Git Rustlang.Rust.MSVC OpenJS.NodeJS</div>
            
            <p><strong>2. Install Aptos CLI:</strong></p>
            <div class="code-block">cargo install --git https://github.com/aptos-labs/aptos-core.git aptos</div>
            
            <p><strong>3. Deploy Contract (See Move code below):</strong></p>
            <div class="code-block">aptos move publish --named-addresses simple_tipping=YOUR_ADDRESS</div>
            
            <p><strong>4. Install Petra Wallet Extension & Connect</strong></p>
        </div>

        <div class="contract-info">
            <h4>⚠ Contract Deployment Required</h4>
            <p>Deploy the Move contract below first, then update MODULE_ADDRESS in the JavaScript.</p>
            <div class="contract-address" id="moduleAddress">
                Module Address: UPDATE_AFTER_DEPLOYMENT
            </div>
        </div>

        <div class="wallet-status">
            <div class="status-item">
                <div class="status-label">Network</div>
                <div class="status-value" id="networkStatus">Disconnected</div>
            </div>
            <div class="status-item">
                <div class="status-label">Account</div>
                <div class="status-value" id="accountStatus">Not Connected</div>
            </div>
            <div class="status-item">
                <div class="status-label">Balance</div>
                <div class="status-value" id="balanceStatus">0 APT</div>
            </div>
            <div class="status-item">
                <button class="connect-btn" id="connectBtn" onclick="connectWallet()">
                    Connect Petra Wallet
                </button>
            </div>
        </div>

        <div class="action-section">
            <div class="action-card">
                <h3>🏗 Initialize Tip Jar</h3>
                <p>Create your tip jar (run once per account)</p>
                <button class="action-btn" id="initBtn" onclick="initializeTipJar()" disabled>
                    Create My Tip Jar
                </button>
            </div>

            <div class="action-card">
                <h3>💰 Send Tip</h3>
                <div class="form-group">
                    <label for="recipientAddress">Recipient Address</label>
                    <input type="text" id="recipientAddress" placeholder="0x123...abc">
                </div>
                <div class="form-group">
                    <label for="tipAmount">Amount (APT)</label>
                    <input type="number" id="tipAmount" placeholder="0.01" step="0.001" min="0.001">
                </div>
                <div class="form-group">
                    <label for="tipMessage">Message</label>
                    <textarea id="tipMessage" rows="2" placeholder="Great work! 🎉"></textarea>
                </div>
                <button class="action-btn" id="sendTipBtn" onclick="sendTip()" disabled>
                    Send Tip 🚀
                </button>
            </div>
        </div>

        <div class="tips-section">
            <h3>💬 Latest Tip Received</h3>
            <div id="tipDisplay">
                <div class="loading">Connect wallet to view tips</div>
            </div>
            <button class="action-btn" onclick="loadTipData()" id="refreshBtn" disabled>
                Refresh Data 🔄
            </button>
        </div>
    </div>

    <script>
        // UPDATE THIS WITH YOUR DEPLOYED MODULE ADDRESS
        const MODULE_ADDRESS = "0x1"; // ⚠ REPLACE AFTER DEPLOYMENT
        const NODE_URL = "https://fullnode.devnet.aptoslabs.com/v1";

        let aptosClient = null;
        let currentAccount = null;

        // Initialize on page load
        window.addEventListener('load', async () => {
            aptosClient = new aptos.AptosClient(NODE_URL);
            await checkWalletConnection();
            updateModuleAddressDisplay();
        });

        function updateModuleAddressDisplay() {
            document.getElementById('moduleAddress').textContent = Module Address: ${MODULE_ADDRESS};
        }

        // Check if wallet is already connected
        async function checkWalletConnection() {
            try {
                if (!window.aptos) {
                    showError('Please install Petra Wallet extension!');
                    return;
                }

                const isConnected = await window.aptos.isConnected();
                if (isConnected) {
                    currentAccount = await window.aptos.account();
                    updateWalletDisplay();
                    await updateBalance();
                    enableButtons();
                }
            } catch (error) {
                console.log('No existing wallet connection');
            }
        }

        // Connect to Petra wallet
        async function connectWallet() {
            try {
                if (!window.aptos) {
                    showError('Petra Wallet is not installed. Please install it from Chrome Web Store.');
                    return;
                }

                const wallet = await window.aptos.connect();
                currentAccount = wallet;
                
                updateWalletDisplay();
                await updateBalance();
                enableButtons();
                
                showSuccess('Wallet connected successfully! 🎉');
            } catch (error) {
                console.error('Wallet connection failed:', error);
                showError('Failed to connect wallet: ' + error.message);
            }
        }

        // Update wallet display
        function updateWalletDisplay() {
            if (currentAccount) {
                document.getElementById('networkStatus').textContent = 'Devnet';
                document.getElementById('accountStatus').textContent = 
                    currentAccount.address.slice(0, 8) + '...' + currentAccount.address.slice(-6);
                document.getElementById('connectBtn').textContent = 'Connected ✓';
                document.getElementById('connectBtn').disabled = true;
            }
        }

        // Enable buttons after wallet connection
        function enableButtons() {
            document.getElementById('initBtn').disabled = false;
            document.getElementById('sendTipBtn').disabled = false;
            document.getElementById('refreshBtn').disabled = false;
        }

        // Update balance
        async function updateBalance() {
            try {
                if (!currentAccount) return;
                
                const resources = await aptosClient.getAccountResources(currentAccount.address);
                const coinResource = resources.find(r => r.type === '0x1::coin::CoinStore<0x1::aptos_coin::AptosCoin>');
                
                if (coinResource) {
                    const balance = parseInt(coinResource.data.coin.value) / 100000000; // Convert octas to APT
                    document.getElementById('balanceStatus').textContent = balance.toFixed(4) + ' APT';
                }
            } catch (error) {
                console.error('Error fetching balance:', error);
            }
        }

        // Initialize tip jar
        async function initializeTipJar() {
            if (!currentAccount) {
                showError('Please connect wallet first');
                return;
            }

            try {
                document.getElementById('initBtn').textContent = 'Creating... ⏳';
                document.getElementById('initBtn').disabled = true;

                const payload = {
                    type: "entry_function_payload",
                    function: ${MODULE_ADDRESS}::tip_jar::create_tip_jar,
                    type_arguments: [],
                    arguments: []
                };

                const response = await window.aptos.signAndSubmitTransaction(payload);
                await aptosClient.waitForTransaction(response.hash);

                showSuccess(Tip jar created successfully! 🎉 Hash: ${response.hash});
                await loadTipData();
            } catch (error) {
                console.error('Initialization failed:', error);
                if (error.message.includes('RESOURCE_ALREADY_EXISTS')) {
                    showError('Tip jar already exists for this account!');
                } else {
                    showError('Failed to initialize tip jar: ' + error.message);
                }
            } finally {
                document.getElementById('initBtn').textContent = 'Create My Tip Jar';
                document.getElementById('initBtn').disabled = false;
            }
        }

        // Send a tip
        async function sendTip() {
            const recipient = document.getElementById('recipientAddress').value;
            const amount = parseFloat(document.getElementById('tipAmount').value);
            const message = document.getElementById('tipMessage').value;

            if (!currentAccount) {
                showError('Please connect wallet first');
                return;
            }

            if (!recipient || !amount || !message) {
                showError('Please fill all fields');
                return;
            }

            if (amount < 0.001) {
                showError('Minimum tip amount is 0.001 APT');
                return;
            }

            try {
                document.getElementById('sendTipBtn').textContent = 'Sending... ⏳';
                document.getElementById('sendTipBtn').disabled = true;

                const payload = {
                    type: "entry_function_payload",
                    function: ${MODULE_ADDRESS}::tip_jar::send_tip,
                    type_arguments: [],
                    arguments: [
                        recipient,
                        Math.floor(amount * 100000000), // Convert APT to octas
                        Array.from(new TextEncoder().encode(message))
                    ]
                };

                const response = await window.aptos.signAndSubmitTransaction(payload);
                await aptosClient.waitForTransaction(response.hash);

                showSuccess(Tip sent successfully! 🎉 Hash: ${response.hash});
                
                // Clear form
                document.getElementById('recipientAddress').value = '';
                document.getElementById('tipAmount').value = '';
                document.getElementById('tipMessage').value = '';

                await updateBalance();
                await loadTipData();
            } catch (error) {
                console.error('Tip sending failed:', error);
                showError('Failed to send tip: ' + error.message);
            } finally {
                document.getElementById('sendTipBtn').textContent = 'Send Tip 🚀';
                document.getElementById('sendTipBtn').disabled = false;
            }
        }

        // Load tip data
        async function loadTipData() {
            if (!currentAccount) return;

            try {
                const myAddress = document.getElementById('recipientAddress').value || currentAccount.address;
                
                // Check if tip jar exists
                const isInitialized = await aptosClient.view({
                    function: ${MODULE_ADDRESS}::tip_jar::is_initialized,
                    type_arguments: [],
                    arguments: [myAddress]
                });

                if (!isInitialized[0]) {
                    document.getElementById('tipDisplay').innerHTML = 
                        '<div class="loading">This account hasn\'t created a tip jar yet</div>';
                    return;
                }

                // Get tip stats
                const totalTips = await aptosClient.view({
                    function: ${MODULE_ADDRESS}::tip_jar::get_total_tips,
                    type_arguments: [],
                    arguments: [myAddress]
                });

                const tipCount = await aptosClient.view({
                    function: ${MODULE_ADDRESS}::tip_jar::get_tip_count,
                    type_arguments: [],
                    arguments: [myAddress]
                });

                // Get latest tip
                let latestTipHtml = '';
                if (parseInt(tipCount[0]) > 0) {
                    const latestTip = await aptosClient.view({
                        function: ${MODULE_ADDRESS}::tip_jar::get_latest_tip,
                        type_arguments: [],
                        arguments: [myAddress]
                    });

                    const [sender, amount, message, timestamp] = latestTip;
                    const aptAmount = (parseInt(amount) / 100000000).toFixed(6);
                    const date = new Date(parseInt(timestamp) * 1000).toLocaleString();

                    latestTipHtml = `
                        <div class="tip-amount">${aptAmount} APT</div>
                        <div class="tip-details">
                            From: ${sender.slice(0, 8)}...${sender.slice(-6)}<br>
                            ${date}
                        </div>
                        <div class="tip-message">"${message}"</div>
                    `;
                } else {
                    latestTipHtml = '<div class="loading">No tips received yet</div>';
                }

                document.getElementById('tipDisplay').innerHTML = `
                    <div style="margin-bottom: 20px;">
                        <strong>Total: ${(parseInt(totalTips[0]) / 100000000).toFixed(6)} APT</strong> 
                        (${tipCount[0]} tips)
                    </div>
                    ${latestTipHtml}
                `;

            } catch (error) {
                console.error('Error loading tip data:', error);
                document.getElementById('tipDisplay').innerHTML = 
                    '<div class="loading">Error loading data. Make sure contract is deployed.</div>';
            }
        }

        // Utility functions
        function showError(message) {
            removeMessages();
            const errorDiv = document.createElement('div');
            errorDiv.className = 'error';
            errorDiv.textContent = message;
            document.querySelector('.container').insertBefore(errorDiv, document.querySelector('.wallet-status'));
            setTimeout(() => errorDiv.remove(), 8000);
        }

        function showSuccess(message) {
            removeMessages();
            const successDiv = document.createElement('div');
            successDiv.className = 'success';
            successDiv.textContent = message;
            document.querySelector('.container').insertBefore(successDiv, document.querySelector('.wallet-status'));
            setTimeout(() => successDiv.remove(), 8000);
        }

        function removeMessages() {
            document.querySelectorAll('.error, .success').forEach(el => el.remove());
        }
    </script>

    <!-- MOVE CONTRACT CODE - DEPLOY THIS FIRST -->
    <div style="display: none;">
        <!--
        
        === MOVE CONTRACT CODE ===
        Create file: sources/simple_tipping.move

        module simple_tipping::tip_jar {
            use std::signer;
            use std::string::{Self, String};
            use aptos_framework::coin::{Self, Coin};
            use aptos_framework::aptos_coin::AptosCoin;
            use aptos_framework::timestamp;

            const E_NOT_INITIALIZED: u64 = 1;
            const E_ALREADY_INITIALIZED: u64 = 2;
            const E_INSUFFICIENT_AMOUNT: u64 = 3;
            const MIN_TIP: u64 = 1000;

            struct Tip has store, drop {
                sender: address,
                amount: u64,
                message: String,
                timestamp: u64,
            }

            struct TipJar has key {
                owner: address,
                total_received: u64,
                tip_count: u64,
                latest_tip: Tip,
            }

            public entry fun create_tip_jar(account: &signer) {
                let addr = signer::address_of(account);
                assert!(!exists<TipJar>(addr), E_ALREADY_INITIALIZED);

                let empty_tip = Tip {
                    sender: addr,
                    amount: 0,
                    message: string::utf8(b"Welcome to my tip jar!"),
                    timestamp: timestamp::now_seconds(),
                };

                move_to(account, TipJar {
                    owner: addr,
                    total_received: 0,
                    tip_count: 0,
                    latest_tip: empty_tip,
                });
            }

            public entry fun send_tip(
                sender: &signer,
                tip_jar_owner: address,
                amount: u64,
                message_bytes: vector<u8>
            ) acquires TipJar {
                assert!(amount >= MIN_TIP, E_INSUFFICIENT_AMOUNT);
                assert!(exists<TipJar>(tip_jar_owner), E_NOT_INITIALIZED);

                let sender_addr = signer::address_of(sender);
                let coins = coin::withdraw<AptosCoin>(sender, amount);
                coin::deposit(tip_jar_owner, coins);

                let tip_jar = borrow_global_mut<TipJar>(tip_jar_owner);
                tip_jar.total_received = tip_jar.total_received + amount;
                tip_jar.tip_count = tip_jar.tip_count + 1;
                
                tip_jar.latest_tip = Tip {
                    sender: sender_addr,
                    amount,
                    message: string::utf8(message_bytes),
                    timestamp: timestamp::now_seconds(),
                };
            }

            #[view]
            public fun get_total_tips(owner: address): u64 acquires TipJar {
                if (!exists<TipJar>(owner)) return 0;
                borrow_global<TipJar>(owner).total_received
            }

            #[view]
            public fun get_tip_count(owner: address): u64 acquires TipJar {
                if (!exists<TipJar>(owner)) return 0;
                borrow_global<TipJar>(owner).tip_count
            }

            #[view]
            public fun get_latest_tip(owner: address): (address, u64, String, u64) acquires TipJar {
                assert!(exists<TipJar>(owner), E_NOT_INITIALIZED);
                let tip_jar = borrow_global<TipJar>(owner);
                let tip = &tip_jar.latest_tip;
                (tip.sender, tip.amount, tip.message, tip.timestamp)
            }

            #[view]
            public fun is_initialized(owner: address): bool {
                exists<TipJar>(owner)
            }
        }

        === Move.toml ===
        [package]
        name = "simple_tipping"
        version = "1.0.0"

        [addresses]
        simple_tipping = "_"

        [dependencies.AptosFramework]
        git = "https://github.com/aptos-labs/aptos-core.git"
        rev = "mainnet"
        subdir = "aptos-move/framework/aptos-framework"

        === DEPLOYMENT COMMANDS ===
        1. mkdir aptos-tip-dapp && cd aptos-tip-dapp
        2. aptos init --network devnet
        3. mkdir move-contract && cd move-contract
        4. aptos move init --name simple_tipping
        5. [Create sources/simple_tipping.move with code above]
        6. [Create Move.toml with config above]
        7. aptos move compile
        8. aptos move publish --named-addresses simple_tipping=YOUR_ADDRESS
        9. Update MODULE_ADDRESS in JavaScript above
        10. Open this HTML file in browser!
        -->
    </div>
</body>
</html>