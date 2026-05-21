# 🍕 Online Food Delivery — SQL Project

> A complete, 9-phase SQL project analyzing an Online Food Delivery platform using MySQL. Covers database design, data analysis, performance optimization, and automation with triggers.

---

## 📌 Project Overview

This project simulates a real-world food delivery database (similar to Swiggy / Zomato) and applies SQL across every stage of the data analytics workflow — from schema creation to advanced querying, indexing, and trigger-based automation.

---

## 🗂️ Database Schema

| Table | Description |
|---|---|
| `customers` | Customer profiles with city and contact info |
| `restaurants` | Restaurant details with cuisine type and city |
| `menu_items` | Menu items linked to restaurants with pricing |
| `delivery_agents` | Agent profiles with vehicle type and rating |
| `orders` | Core transactional table for all orders placed |
| `order_items` | Line items (products) within each order |

---

## 🚀 Project Phases

| Phase | Topic | Description |
|---|---|---|
| **Phase 1** | Database Setup | Created database + 6 normalized tables with PK/FK constraints |
| **Phase 2** | Data Insertion | Inserted realistic sample data — 10 customers, 10 restaurants, 5 agents, 15+ orders |
| **Phase 3** | Basic Exploration | Total orders, revenue, payment method breakdown |
| **Phase 4** | Customer Analysis | Top spenders, order frequency, city-wise distribution |
| **Phase 5** | Restaurant & Revenue | Top 10 restaurants, cuisine-wise and city-wise revenue |
| **Phase 6** | Delivery Performance | Agent stats, delayed orders (>45 min), city-wise avg delivery time |
| **Phase 7** | Advanced Queries | Monthly trends, high-value orders, discount analysis |
| **Phase 8** | Performance Optimization | 5 indexes created + EXPLAIN query analysis |
| **Phase 9** | Triggers | 3 triggers for automation — high-value log, discount guard, delay log |
| **Dashboard** | Visualization | 5 export-ready queries for Google Sheets charts |

---

## ⚡ Performance Optimization (Phase 8)

Five indexes were created to speed up the most common query patterns:

```sql
CREATE INDEX idx_order_date       ON orders(order_date);
CREATE INDEX idx_customer_name    ON customers(name);
CREATE INDEX idx_restaurant_name  ON restaurants(name);
CREATE INDEX idx_delivery_time    ON orders(delivery_time_minutes);
CREATE INDEX idx_order_amount     ON orders(order_amount);
```

`EXPLAIN` statements were used to verify that full-table scans were eliminated.

---

## 🔔 Triggers (Phase 9)

Three triggers automate monitoring and data integrity in the background:

```sql
-- 1. Log orders above $1,000
CREATE TRIGGER trg_high_value_order
AFTER INSERT ON orders FOR EACH ROW
BEGIN
  IF NEW.order_amount > 1000 THEN
    INSERT INTO high_value_orders_log VALUES (NEW.order_id, NOW());
  END IF;
END;

-- 2. Prevent negative discounts
CREATE TRIGGER trg_prevent_negative_discount
BEFORE INSERT ON orders FOR EACH ROW
BEGIN
  IF NEW.discount < 0 THEN
    SET NEW.discount = 0;
  END IF;
END;

-- 3. Log delayed deliveries (>45 minutes)
CREATE TRIGGER trg_delivery_delay_log
AFTER INSERT ON orders FOR EACH ROW
BEGIN
  IF NEW.delivery_time_minutes > 45 THEN
    INSERT INTO delivery_delay_log VALUES (NEW.order_id, NEW.delivery_time_minutes, NOW());
  END IF;
END;
```

---

## 📊 Dashboard Queries

The following SQL results were exported to Google Sheets for visualization:

- **Total Revenue** — Scorecard KPI
- **City-wise Total Orders** — Pie Chart
- **Top 10 Restaurants by Revenue** — Bar Chart
- **City-wise Average Delivery Time** — 3D Pie Chart
- **Monthly Order Trends** — Line Chart

---

## 💡 Key Business Insights

- Top 20% of customers contribute ~60% of total revenue (Pareto principle)
- Indian & Fast Food cuisines lead in revenue across all cities
- ~30% of deliveries exceed the 45-minute SLA — an opportunity for optimization
- December & January show peak order volumes — ideal for seasonal campaigns
- Metro cities (Mumbai, Delhi) outperform Tier-2 cities in both volume and order value

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Database engine |
| VS Code + MySQL Extension | SQL development IDE |
| Google Sheets | Dashboard / data visualization |
| GitHub | Version control & project publishing |

---

## 📁 File Structure

```
📦 food-delivery-sql-project
 ┣ 📄 phase1_database_setup.sql
 ┣ 📄 phase2_data_insertion.sql
 ┣ 📄 phase3_basic_exploration.sql
 ┣ 📄 phase4_customer_analysis.sql
 ┣ 📄 phase5_restaurant_revenue.sql
 ┣ 📄 phase6_delivery_performance.sql
 ┣ 📄 phase7_advanced_queries.sql
 ┣ 📄 phase8_indexes.sql
 ┣ 📄 phase9_triggers.sql
 ┣ 📄 dashboard_queries.sql
 ┗ 📄 README.md
```

---

## 👤 Author

**[Pratik Gosavi]**  
SQL & Data Analytics Enthusiast  
📧 [pratikgosavi411@gmail.com]  

---

> ⭐ If you found this project useful, please give it a star!
