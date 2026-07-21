WITH ranked AS (
    SELECT
        symbol,
        name,
        trade_date,
        volume,
        ROW_NUMBER() OVER (
            PARTITION BY trade_date
            ORDER BY volume DESC, symbol
        ) AS rn
    FROM daily_k
    WHERE trade_date LIKE '2025%'
),
top10 AS (
    SELECT
        symbol,
        name
    FROM ranked
    WHERE rn <= 10
)
SELECT
    symbol,
    name,
    COUNT(*) AS count
FROM top10
GROUP BY symbol, name
ORDER BY count DESC, symbol;
