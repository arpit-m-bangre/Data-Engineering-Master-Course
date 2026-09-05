# 📡 SYSTEM DESIGN CASE 01: Telecom Postpaid CDR Billing — Batch vs Streaming
**Module:** 03_ETL_DATA_PIPELINES | **Domain:** Telecommunications & Real-Time Billing Architecture

---

## 1. Problem Statement & Historical Context

In early 2G/3G telecom networks, carriers (Airtel, Vodafone, AT&T) processed hundreds of millions of Call Detail Records (CDRs) per day. Because compute resources (mainframes and early relational databases) were expensive and constrained, telecom systems utilized **Nightly Batch Processing** scheduled at **12:00 AM (Midnight)**.

### The Midnight Boundary Bug:
- If a customer was on a voice call from 11:55 PM to 12:10 AM, the call crossed the billing calendar date.
- The 12:00 AM batch job would either:
  1. Lock the active account record, causing the live call to abruptly drop.
  2. Fail to bill the 15-minute call duration until the *next* night's batch, causing revenue leakage.
  3. Miscalculate peak vs off-peak tariff rates.

---

## 2. Legacy Batch Architecture (The Bottleneck)

```
[ Mobile Towers / Switches ]
             │ (Writes flat CSV / ASN.1 CDR files)
             ▼
[ SFTP File Landing Zone ]
             │ (Nightly 12:00 AM Cron Job Trigger)
             ▼
[ Monolithic Batch ETL Engine ] (Heavy CPU / Memory Spike)
             │ (Hours of batch aggregation & lock contention)
             ▼
[ Customer Billing Database ] (Stale by 24 hours)
```

### Limitations:
- **24-Hour Data Staleness**: Prepaid balances could not be enforced in real-time, allowing users to make calls beyond balance.
- **Resource Spikes**: 90% CPU idle during the day, 100% pegged at midnight.
- **High Blast Radius**: A single corrupt file at 12:05 AM aborted the entire night's billing run for millions of subscribers.

---

## 3. Modern Real-Time Streaming Architecture (Kappa / Lambda Solution)

Modern Tier-1 telecom providers employ distributed event streaming to process CDRs continuously with sub-second latency.

```
[ Mobile Towers / 5G Core ]
             │ (Real-Time Event Streams)
             ▼
[ Distributed Message Broker: Apache Kafka ]
   • Topic: `cdr.voice.raw`
   • Topic: `cdr.data.raw`
             │
             ▼
[ Stream Processing Engine: Apache Flink / Spark Streaming ]
   • Sliding / Tumbling Windows (Event-Time Watermarking)
   • Dynamic Session Windowing (Handles calls crossing midnight seamlessly)
   • Deduplication & Real-Time Fraud Detection
             │
             ├───────────────────────────┐
             ▼                           ▼
[ Low-Latency Cache / OLTP ]    [ Medallion Lakehouse (Delta/Iceberg) ]
   • Redis / ScyllaDB              • Bronze: Raw CDR Parquet files
   • Live Balance & Credit Limit   • Silver: Cleansed & Partitioned
   • Sub-10ms Balance Query        • Gold: Daily Revenue Marts for BI
```

---

## 4. Key Architectural Tradeoffs: Batch vs Streaming

| Dimension | Legacy Midnight Batch | Modern Distributed Streaming |
| :--- | :--- | :--- |
| **Data Freshness** | 24 hours behind real time | Sub-second (100ms - 2s) |
| **Infrastructure Cost** | Low complexity, high midnight compute burst | Steady infrastructure footprint, streaming cluster management |
| **Failure Recovery** | Re-run entire daily batch | Replay Kafka topic from committed consumer offset |
| **Handling Midnight Overlaps** | Broken / manual edge-case logic | Handled natively via Event-Time Watermarking |
| **Idempotency** | Truncate & reload daily partition | Deduplication based on `(SwitchID, CallID, StartTime)` |

---

## 5. Tier-1 Interview Takeaways

1. **Event Time vs Ingestion Time**: Always process streaming metrics using **Event Time** (when the phone call actually occurred) rather than **Ingestion Time** (when the server received the packet).
2. **Watermarking**: Use watermarks to handle late-arriving CDRs from roaming towers without dropping historical records.
3. **Dual Storage Pattern**: Use in-memory key-value stores (Redis) for real-time balance checks and columnar lakehouses (Delta Lake / Snowflake) for long-term historical billing audits.
