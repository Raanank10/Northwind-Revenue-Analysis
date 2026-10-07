# Northwind Revenue & Operations Analysis

**SQL Server · Excel · Tableau** | Business question: *How can Northwind, a wholesale food distributor, increase profit using its own sales and fulfillment data?*

This is an end-to-end analysis of the classic Northwind database: 830 orders and $1.27M in net revenue from July 1996 to May 1998. It covers pricing, fulfillment, customers and sales staff, and ends with recommendations for the board.

![Northwind dashboard](Visualizations/Northwind%20Data%20Analysis%20Project%20Dashboard.png)

## Key findings

| # | Finding | Evidence |
|---|---|---|
| 1 | **Discounts cost $88.7K** (7.0% of net revenue). Meat/Poultry has the highest average discount (6.45%) but earns about **$45K less estimated gross profit than Beverages**. | `The Profit vs. Discount Breakdown.sql` |
| 2 | **A 5.5% discount cap on Meat/Poultry recovers at most ~$10.3K** over the full dataset (59 order lines affected). This is an upper bound: it assumes no lost volume. | `Discount Cap Scenario.sql` |
| 3 | **United Package is both the largest and the slowest carrier.** It handles 315 shipped orders ($517K revenue) at an average of 9.2 days to ship, and **21% of its orders take more than 10 days**. Federal Shipping averages 7.5 days with 12% over 10 days. | `Shipper Lead Time.sql` |
| 4 | **Sales staff split into volume vs. value profiles.** Margaret Peacock leads on volume (156 orders, $233K). Anne Dodsworth has the highest average order value (~$1.8K) on just 43 orders. | `Fulfillment & Sales Talent.sql` |
| 5 | **The apparent 1998-Q2 revenue drop is a data artifact, not a decline.** The data ends on 6 May 1998, so Q2 covers only 36 days. Per day, Q2 ran at ~$3.9K vs ~$3.3K in Q1, which is still growth. | `Regional Revenue Trend.sql`, `Declining Regions.sql` |

## Recommendations

- **Pricing:** Pilot a 5.5% discount cap on Meat/Poultry and track unit volume for a quarter. The upside is at most ~$10K over the 22 months of data (about $5.6K a year), so this is a margin-hygiene fix, not a growth lever.
- **Logistics:** Move high-value orders (over $1,800) away from United Package and renegotiate its SLA. The gap is about 2 days on average, but the bigger problem is the late tail (21% vs 12% of orders over 10 days).
- **Sales:** Pair high-volume reps with high-AOV reps for upselling coaching, and assign the top 10 customers by lifetime value to the high-AOV reps.

## Method

1. **Extraction (SQL Server):** Eight queries join Orders, Order Details, Products, Categories, Customers, Employees and Shippers. Fulfillment metrics are aggregated **at order grain first** (in a CTE) so line items don't inflate order counts.
2. **Staging (Excel):** Cleaning, currency formatting and RFM-lite customer segmentation.
3. **Visualization (Tableau):** An executive dashboard covering employee performance, VIP risk, volume vs. speed, and profit vs. discount.

**Assumptions and limits**
- Northwind has no cost column. As the project brief instructs, `Products.UnitPrice` is used as a cost proxy, so the profit figures are only valid for *comparing* categories with each other.
- "Recovered revenue" scenarios assume no change in volume.
- Quarterly comparisons need to account for the partial final quarter (1998-Q2).
- Lead time is measured from order date to shipped date. The 21 unshipped orders are excluded.

## Repository structure

| Folder | Contents |
|---|---|
| [`SQL queries/`](SQL%20queries/) | All extraction and scenario queries (T-SQL) |
| [`Data_Processing_Excel/`](Data_Processing_Excel/) | Excel staging workbooks |
| [`Visualizations/`](Visualizations/) | Dashboard and chart exports |
| [`Documentation/`](Documentation/) | Project brief, work plan and executive presentation (PDF) |

**More assets:** [Executive slide deck](https://docs.google.com/presentation/d/1MT3qpxGW1fjxQlGgQDSsi2LqFqtpFYXnBTC-EvjVQmQ/edit?usp=sharing) · [Tableau workbook & logs (Google Drive)](https://drive.google.com/drive/folders/1CFXFY58VXuMOi2tlM_00CS3he5MqFbCS?usp=sharing)

---
**Raanan Kelner**, Data Analyst · [LinkedIn](https://www.linkedin.com/in/raanan-kelner)
