# Titanic Data Analysis Using R

## Project Overview

This project focuses on data cleaning, preprocessing, and exploratory data analysis of the Titanic passenger dataset using R.

## Objectives

- Understand the structure of the dataset
- Identify and handle missing values
- Check for duplicate records
- Detect potential outliers
- Convert categorical variables into factors
- Perform descriptive statistical analysis
- Analyze numerical variables
- Study relationships between variables
- Create visualizations
- Generate meaningful insights from the dataset

## Dataset

The Titanic dataset contains **891 passenger records** and the following original variables:

- PassengerId
- Survived
- Pclass
- Name
- Sex
- Age
- SibSp
- Parch
- Ticket
- Fare
- Cabin
- Embarked

## Data Cleaning

The following preprocessing steps were performed:

1. Loaded the Titanic dataset using R.
2. Inspected the first few records using `head()`.
3. Checked the dataset structure using `str()`.
4. Generated summary statistics using `summary()`.
5. Checked the number of rows and columns using `dim()`.
6. Identified missing values using `is.na()`.
7. Checked blank values in character columns.
8. Calculated missing-value percentages.
9. Created a missing-value summary table.
10. Replaced missing Age values using the median Age.
11. Handled missing Embarked values.
12. Created a `CabinKnown` variable to indicate cabin availability.
13. Checked for duplicate records.
14. Checked for duplicate Passenger IDs.
15. Verified data types.
16. Converted categorical variables into factors.
17. Checked categorical value consistency.
18. Examined numerical variables.
19. Detected potential outliers using the IQR method.

## Exploratory Data Analysis

The project includes analysis of:

- Passenger survival
- Survival by gender
- Survival by passenger class
- Age distribution
- Fare distribution
- Family-related variables
- Numerical variable relationships
- Correlation between numerical variables

## Visualizations

The analysis includes graphical representations such as:

- Bar charts
- Histograms
- Boxplots
- Correlation plots
- Correlation heatmap

## Data Quality Findings

The original dataset contained missing values mainly in:

- Age
- Cabin
- Embarked

There were **177 missing Age values**, **687 missing Cabin values**, and **2 missing Embarked values**.

No duplicate complete records were found.

## Tools Used

- R
- RStudio
- Base R functions
- Statistical analysis
- Data visualization

## Project Files

```text
Titanic_Data_Analysis/
│
├── data/
│   ├── train.csv
│   └── titanic_cleaned.csv
│
├── analysis.R
├── README.md
└── Titanic_Data_Analysis.Rproj
