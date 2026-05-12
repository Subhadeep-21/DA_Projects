-- ============================================
-- AML TRANSACTION MONITORING SYSTEM
-- SQL ANALYSIS QUERIES
-- ============================================

-- ============================================
-- 1. VIEW TOTAL TRANSACTIONS
-- ============================================

SELECT 
    COUNT() AS total_transactions
FROM aml_transactions;


-- ============================================
-- 2. TOTAL TRANSACTION VOLUME
-- ============================================

SELECT 
    SUM(TransactionAmount) AS total_transaction_volume
FROM aml_transactions;


-- ============================================
-- 3. AVERAGE TRANSACTION AMOUNT
-- ============================================

SELECT 
    AVG(TransactionAmount) AS avg_transaction_amount
FROM aml_transactions;


-- ============================================
-- 4. HIGH VALUE TRANSACTIONS
-- Transactions above $1000
-- ============================================

SELECT 
FROM aml_transactions
WHERE TransactionAmount  1000
ORDER BY TransactionAmount DESC;


-- ============================================
-- 5. SUSPICIOUS LOGIN ATTEMPTS
-- More than 3 login attempts
-- ============================================

SELECT 
    TransactionID,
    AccountID,
    LoginAttempts,
    Channel,
    Location
FROM aml_transactions
WHERE LoginAttempts = 3
ORDER BY LoginAttempts DESC;


-- ============================================
-- 6. LOW BALANCE HIGH TRANSACTION RISK
-- Transaction amount exceeds account balance
-- ============================================

SELECT 
    TransactionID,
    AccountID,
    TransactionAmount,
    AccountBalance,
    Location
FROM aml_transactions
WHERE TransactionAmount  AccountBalance
ORDER BY TransactionAmount DESC;


-- ============================================
-- 7. ONLINE TRANSACTION MONITORING
-- ============================================

SELECT 
    COUNT() AS online_transaction_count,
    SUM(TransactionAmount) AS online_transaction_volume
FROM aml_transactions
WHERE Channel = 'Online';


-- ============================================
-- 8. CHANNEL WISE TRANSACTION ANALYSIS
-- ============================================

SELECT 
    Channel,
    COUNT() AS transaction_count,
    SUM(TransactionAmount) AS total_volume,
    AVG(TransactionAmount) AS avg_amount
FROM aml_transactions
GROUP BY Channel
ORDER BY total_volume DESC;


-- ============================================
-- 9. LOCATION WISE SUSPICIOUS TRANSACTIONS
-- ============================================

SELECT 
    Location,
    COUNT() AS suspicious_transactions
FROM aml_transactions
WHERE TransactionAmount  500
GROUP BY Location
ORDER BY suspicious_transactions DESC;


-- ============================================
-- 10. TOP 10 HIGH RISK ACCOUNTS
-- ============================================

SELECT 
    AccountID,
    COUNT() AS transaction_count,
    SUM(TransactionAmount) AS total_amount,
    AVG(TransactionAmount) AS avg_transaction
FROM aml_transactions
GROUP BY AccountID
ORDER BY total_amount DESC
LIMIT 10;


-- ============================================
-- 11. MULTIPLE ACCOUNTS USING SAME DEVICE
-- Potential mulefraud activity
-- ============================================

SELECT 
    DeviceID,
    COUNT(DISTINCT AccountID) AS unique_accounts
FROM aml_transactions
GROUP BY DeviceID
HAVING COUNT(DISTINCT AccountID)  1
ORDER BY unique_accounts DESC;


-- ============================================
-- 12. MULTIPLE ACCOUNTS USING SAME IP
-- ============================================

SELECT 
    `IP Address`,
    COUNT(DISTINCT AccountID) AS unique_accounts
FROM aml_transactions
GROUP BY `IP Address`
HAVING COUNT(DISTINCT AccountID)  1
ORDER BY unique_accounts DESC;


-- ============================================
-- 13. FREQUENT TRANSACTION USERS
-- ============================================

SELECT 
    AccountID,
    COUNT() AS total_transactions
FROM aml_transactions
GROUP BY AccountID
ORDER BY total_transactions DESC
LIMIT 20;


-- ============================================
-- 14. TRANSACTION TYPE DISTRIBUTION
-- ============================================

SELECT 
    TransactionType,
    COUNT() AS transaction_count,
    SUM(TransactionAmount) AS total_volume
FROM aml_transactions
GROUP BY TransactionType;


-- ============================================
-- 15. CUSTOMER OCCUPATION RISK ANALYSIS
-- ============================================

SELECT 
    CustomerOccupation,
    COUNT() AS transaction_count,
    AVG(TransactionAmount) AS avg_amount,
    SUM(TransactionAmount) AS total_volume
FROM aml_transactions
GROUP BY CustomerOccupation
ORDER BY total_volume DESC;


-- ============================================
-- 16. AGE GROUP ANALYSIS
-- ============================================

SELECT
    CASE
        WHEN CustomerAge  25 THEN '18-24'
        WHEN CustomerAge BETWEEN 25 AND 40 THEN '25-40'
        WHEN CustomerAge BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS age_group,
    
    COUNT() AS transaction_count,
    AVG(TransactionAmount) AS avg_transaction
FROM aml_transactions
GROUP BY age_group
ORDER BY transaction_count DESC;


-- ============================================
-- 17. LONG TRANSACTION DURATION ANALYSIS
-- ============================================

SELECT 
    TransactionID,
    AccountID,
    TransactionDuration,
    Channel,
    TransactionAmount
FROM aml_transactions
WHERE TransactionDuration  250
ORDER BY TransactionDuration DESC;


-- ============================================
-- 18. RAPID  SHORT DURATION TRANSACTIONS
-- Potential botfraud behavior
-- ============================================

SELECT 
    TransactionID,
    AccountID,
    TransactionDuration,
    TransactionAmount
FROM aml_transactions
WHERE TransactionDuration  20
ORDER BY TransactionDuration ASC;


-- ============================================
-- 19. MONTHLY TRANSACTION TREND
-- ============================================

SELECT 
    MONTH(TransactionDate) AS txn_month,
    COUNT() AS transaction_count,
    SUM(TransactionAmount) AS total_volume
FROM aml_transactions
GROUP BY MONTH(TransactionDate)
ORDER BY txn_month;


-- ============================================
-- 20. TOP 10 HIGHEST TRANSACTIONS
-- ============================================

SELECT 
    TransactionID,
    AccountID,
    TransactionAmount,
    Location,
    Channel
FROM aml_transactions
ORDER BY TransactionAmount DESC
LIMIT 10;


-- ============================================
-- 21. HIGH RISK TRANSACTION DETECTION
-- Composite AML Rule Engine
-- ============================================

SELECT 
    TransactionID,
    AccountID,
    TransactionAmount,
    LoginAttempts,
    AccountBalance,
    Channel,
    Location,

    CASE
        WHEN TransactionAmount  1000 THEN 'High Amount'
        WHEN LoginAttempts = 3 THEN 'Multiple Login Attempts'
        WHEN TransactionAmount  AccountBalance THEN 'Insufficient Balance Risk'
        WHEN TransactionDuration  20 THEN 'Abnormal Fast Transaction'
        ELSE 'Normal'
    END AS risk_reason

FROM aml_transactions

WHERE 
    TransactionAmount  1000
    OR LoginAttempts = 3
    OR TransactionAmount  AccountBalance
    OR TransactionDuration  20

ORDER BY TransactionAmount DESC;


-- ============================================
-- 22. RISK SCORE GENERATION
-- ============================================

SELECT 
    TransactionID,
    AccountID,

    (
        CASE 
            WHEN TransactionAmount  1000 THEN 40
            ELSE 0
        END +

        CASE 
            WHEN LoginAttempts = 3 THEN 30
            ELSE 0
        END +

        CASE 
            WHEN Channel = 'Online' THEN 10
            ELSE 0
        END +

        CASE 
            WHEN TransactionDuration  20 THEN 20
            ELSE 0
        END +

        CASE 
            WHEN TransactionAmount  AccountBalance THEN 30
            ELSE 0
        END

    ) AS risk_score

FROM aml_transactions
ORDER BY risk_score DESC;


-- ============================================
-- 23. HIGH RISK TRANSACTIONS ONLY
-- ============================================

SELECT 
FROM (
    SELECT 
        TransactionID,
        AccountID,
        TransactionAmount,

        (
            CASE 
                WHEN TransactionAmount  1000 THEN 40
                ELSE 0
            END +

            CASE 
                WHEN LoginAttempts = 3 THEN 30
                ELSE 0
            END +

            CASE 
                WHEN Channel = 'Online' THEN 10
                ELSE 0
            END +

            CASE 
                WHEN TransactionDuration  20 THEN 20
                ELSE 0
            END +

            CASE 
                WHEN TransactionAmount  AccountBalance THEN 30
                ELSE 0
            END
        ) AS risk_score

    FROM aml_transactions
) risk_data

WHERE risk_score = 50
ORDER BY risk_score DESC;


-- ============================================
-- 24. TOP RISKY LOCATIONS
-- ============================================

SELECT 
    Location,
    COUNT() AS risky_transactions
FROM aml_transactions
WHERE 
    LoginAttempts = 3
    OR TransactionAmount  1000
GROUP BY Location
ORDER BY risky_transactions DESC;


-- ============================================
-- 25. DASHBOARD KPI SUMMARY
-- ============================================

SELECT
    COUNT() AS total_transactions,

    SUM(TransactionAmount) AS total_volume,

    AVG(TransactionAmount) AS avg_transaction,

    SUM(
        CASE 
            WHEN TransactionAmount  1000
            OR LoginAttempts = 3
            OR TransactionAmount  AccountBalance
            THEN 1
            ELSE 0
        END
    ) AS suspicious_transactions,

    COUNT(DISTINCT AccountID) AS total_accounts,

    COUNT(DISTINCT DeviceID) AS total_devices

FROM aml_transactions;