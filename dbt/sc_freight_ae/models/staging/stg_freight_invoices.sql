{{ config(materialized='view') }}

WITH source AS (
    SELECT *
    FROM {{ source('raw', 'freight_invoices') }}
),

cleaned AS (
    SELECT
        invoice_id,
        shipment_id,
        gl_location,

        -- normalize inbound/outbound values (this prevents filter bugs in BI)
        UPPER(TRIM(inbound_outbound)) AS inbound_outbound,

        TRIM(carrier) AS carrier,
        UPPER(TRIM(ship_mode)) AS ship_mode,

        invoice_date,

        weight_lbs,
        distance_miles,

        freight_cost_local,
        UPPER(TRIM(currency_code)) AS currency_code,

        fx_rate_to_usd,
        freight_cost_usd

    FROM source
)

SELECT * FROM cleaned























