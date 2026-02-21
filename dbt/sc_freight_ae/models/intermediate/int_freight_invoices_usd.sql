{{ config(materialized='view') }}

WITH freight AS (
    SELECT *
    FROM {{ ref('stg_freight_invoices') }}
),

fx AS (
    SELECT
        month_start,
        UPPER(TRIM(currency_code)) AS currency_code,
        fx_rate_to_usd
    FROM {{ source('raw', 'fx_rates_monthly') }}
),

joined AS (
    SELECT
        f.*,
        DATE_TRUNC('MONTH', f.invoice_date) AS invoice_month,
        fx.fx_rate_to_usd AS fx_rate_joined,
        ROUND(f.freight_cost_local * fx.fx_rate_to_usd, 2) AS freight_cost_usd_calc
    FROM freight f
    LEFT JOIN fx
      ON DATE_TRUNC('MONTH', f.invoice_date) = fx.month_start
     AND f.currency_code = fx.currency_code
)

SELECT * FROM joined