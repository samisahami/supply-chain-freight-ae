{{ config(materialized='table') }}

WITH base AS (
    SELECT *
    FROM {{ ref('int_freight_invoices_usd') }}
),

agg AS (
    SELECT
        invoice_month,
        gl_location,
        inbound_outbound,

        -- optional extra breakdowns (comment out if you want it simpler)
        carrier,
        ship_mode,

        COUNT(*) AS invoice_count,
        SUM(weight_lbs) AS total_weight_lbs,
        SUM(distance_miles) AS total_distance_miles,

        -- our canonical USD metric
        SUM(freight_cost_usd_calc) AS freight_spend_usd

    FROM base
    GROUP BY 1,2,3,4,5
)

SELECT * FROM agg