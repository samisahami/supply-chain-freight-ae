# Supply Chain Freight Analytics Engineering Pipeline

This project simulates a manufacturing sourcing and freight analytics environment.

## Goals

- Recreate freight spend reporting similar to ERP-driven Power BI dashboards
- Build dimensional models in Snowflake using dbt
- Implement CI with dbt build on PR
- Deliver Power BI dashboards on top of clean marts

## Architecture (Planned)

Raw CSV → Snowflake → dbt (staging → marts) → Power BI
