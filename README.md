# SaaS Data Pipeline & Analytics Project

## Overview  
This project demonstrates a full end-to-end data pipeline for a SaaS-like environment, covering synthetic data generation, relational database design, cloud data warehousing, exploratory analysis, and advanced modeling. It simulates realistic user behavior and revenue data to showcase data engineering and analytics skills.

---

## Process Summary & Accomplishments

### Data Generation
- Created synthetic data using Python’s Faker library for realistic prototyping and testing.
- Ensured data variability and realism for meaningful analysis.

### Schema & Relationships
- Designed a normalized database schema in Microsoft SQL Server (MSSQL) with appropriate tables and foreign key relationships.
- Ensured data integrity and accurate joins.

### Data Upload
- Populated MSSQL tables with generated data.
- Validated data quality with SQL queries inside MSSQL.

### ETL to BigQuery
- Developed a Python ETL pipeline that extracts data from MSSQL and loads it into Google BigQuery.
- Simulated a modern data pipeline migrating on-premise transactional data to a cloud warehouse.

### Querying & Analysis
- Conducted exploratory data analysis (EDA) and cohort analysis using SQL in BigQuery.
- Derived actionable insights from the generated data.

### Advanced Analysis & Modeling
- Integrated BigQuery ML and Python for predictive modeling:
  - Churn prediction,
  - Revenue forecasting,
  - User segmentation via clustering,
  - Identification of key retention and LTV factors.
- Added predictive power on top of descriptive analysis.

### Visualization
- Created dashboards connecting BigQuery with Looker Studio (Google Data Studio).
- Visualized key metrics like user growth, retention, churn, promo usage, and revenue trends.

### Documentation & Automation
- Documented the full data pipeline, schema, and analysis steps.
- Automated data generation, ETL, and analysis workflows.

---

## Technologies & Tools Used

- **Data Generation:** Python, Faker  
- **Database:** Microsoft SQL Server (MSSQL)  
- **ETL Pipeline:** Python (PyODBC, Google BigQuery client library)  
- **Cloud Data Warehouse:** Google BigQuery  
- **Analysis & Modeling:** SQL, Python (Pandas, Scikit-learn)  
- **Visualization:** Looker Studio (Google Data Studio)  

---

## How to Use

1. Clone the repository.  
2. Run Python scripts to generate synthetic data.  
3. Load data into MSSQL following the schema.  
4. Execute ETL scripts to transfer data into BigQuery.  
5. Use SQL queries and Python notebooks for analysis and modeling.  
6. Explore dashboards built with Looker Studio to visualize insights.

---

## Conclusion

This project exemplifies a complete data engineering and analytics workflow from data generation to predictive modeling and visualization. It is ideal for showcasing skills in cloud data pipelines, SQL, Python, and BI tools in a SaaS-like environment.

---

## Contribution

Contributions are welcome! Feel free to submit issues or pull requests to further enhance the project.

---

## License

MIT License

---

*Created by Nandu Prasad*
