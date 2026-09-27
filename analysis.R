# ============================================
# TITANIC DATA ANALYSIS
# Week 1 - Data Cleaning and Preliminary Analysis
# ============================================


# ============================================
# 1. LOAD DATASET
# ============================================

data <- read.csv("data/train.csv")


# ============================================
# 2. INITIAL DATA INSPECTION
# ============================================

# View first few rows
head(data)

# Check structure
str(data)

# Generate summary statistics
summary(data)

# Check number of rows and columns
dim(data)


# ============================================
# 3. MISSING VALUE ANALYSIS
# ============================================

# Check missing values represented as NA
na_count <- colSums(is.na(data))

na_count


# Check blank values represented as ""
blank_count <- sapply(
  data,
  function(x) sum(x == "", na.rm = TRUE)
)

blank_count


# ============================================
# 4. STANDARDIZE MISSING VALUES
# ============================================

# Convert blank strings to NA
data[data == ""] <- NA


# Recheck missing values
total_missing <- colSums(is.na(data))

total_missing


# ============================================
# 5. MISSING VALUE PERCENTAGE
# ============================================

missing_percentage <- 
  (total_missing / nrow(data)) * 100

round(missing_percentage, 2)


# ============================================
# 6. MISSING VALUE SUMMARY TABLE
# ============================================

missing_summary <- data.frame(
  Variable = names(data),
  Missing_Count = total_missing,
  Missing_Percentage = round(missing_percentage, 2)
)

missing_summary
# ============================================
# 7. HANDLE MISSING AGE VALUES
# ============================================

# Calculate median age
median_age <- median(data$Age, na.rm = TRUE)

# Replace missing Age values with median age
data$Age[is.na(data$Age)] <- median_age

# Check Age missing values after imputation
sum(is.na(data$Age))
# ============================================
# HANDLE MISSING EMBARKED VALUES
# ============================================

# Find the most frequent Embarked value
mode_embarked <- names(
  sort(table(data$Embarked), decreasing = TRUE)
)[1]

# Replace missing Embarked values with the mode
data$Embarked[is.na(data$Embarked)] <- mode_embarked

# Check missing Embarked values
sum(is.na(data$Embarked))
# ============================================
# HANDLE MISSING CABIN INFORMATION
# ============================================

# Create indicator for cabin availability
data$CabinKnown <- ifelse(
  is.na(data$Cabin),
  "No",
  "Yes"
)

# Check cabin availability
table(data$CabinKnown)
# ============================================
# FINAL MISSING VALUE CHECK
# ============================================

colSums(is.na(data))
# ============================================
# CHECK FOR DUPLICATE RECORDS
# ============================================

duplicate_count <- sum(duplicated(data))

duplicate_count
# Check for duplicate Passenger IDs
sum(duplicated(data$PassengerId))
# ============================================
# 11. CHECK DATA TYPES
# ============================================

str(data)
# ============================================
# 12. CONVERT CATEGORICAL VARIABLES TO FACTORS
# ============================================

data$Survived <- factor(
  data$Survived,
  levels = c(0, 1),
  labels = c("No", "Yes")
)

data$Pclass <- factor(data$Pclass)

data$Sex <- factor(data$Sex)

data$Embarked <- factor(data$Embarked)

data$CabinKnown <- factor(data$CabinKnown)

# Check the updated structure
str(data)
# ============================================
# 13. CHECK CATEGORICAL VALUE CONSISTENCY
# ============================================

table(data$Sex)

table(data$Embarked)

table(data$Pclass)

table(data$Survived)

table(data$CabinKnown)
# ============================================
# 14. CHECK NUMERICAL VARIABLES
# ============================================

summary(data$Age)

summary(data$Fare)

summary(data$SibSp)

summary(data$Parch)
# ============================================
# 15. OUTLIER DETECTION USING IQR METHOD
# ============================================

# Function to calculate outlier limits and count
check_outliers <- function(x) {
  
  Q1 <- quantile(x, 0.25, na.rm = TRUE)
  Q3 <- quantile(x, 0.75, na.rm = TRUE)
  IQR_value <- Q3 - Q1
  
  lower_limit <- Q1 - 1.5 * IQR_value
  upper_limit <- Q3 + 1.5 * IQR_value
  
  outliers <- x[x < lower_limit | x > upper_limit]
  
  cat("Q1:", Q1, "\n")
  cat("Q3:", Q3, "\n")
  cat("IQR:", IQR_value, "\n")
  cat("Lower Limit:", lower_limit, "\n")
  cat("Upper Limit:", upper_limit, "\n")
  cat("Number of Outliers:", length(outliers), "\n\n")
  
  return(outliers)
}
# Check for outliers in Age
age_outliers <- check_outliers(data$Age)
# ============================================
# 16. CHECK FARE OUTLIERS
# ============================================

fare_outliers <- check_outliers(data$Fare)
# ============================================
# 17. CHECK SIBSP OUTLIERS
# ============================================

sibsp_outliers <- check_outliers(data$SibSp)
# ============================================
# 18. CHECK PARCH OUTLIERS
# ============================================

parch_outliers <- check_outliers(data$Parch)
# ============================================
# 19. BOXPLOTS FOR OUTLIER VISUALIZATION
# ============================================

boxplot(
  data$Age,
  main = "Boxplot of Age",
  ylab = "Age"
)
# ============================================
# 20. BOXPLOT OF FARE
# ============================================

boxplot(
  data$Fare,
  main = "Boxplot of Passenger Fare",
  ylab = "Fare"
)
# ============================================
# 21. BOXPLOT OF SIBSP
# ============================================

boxplot(
  data$SibSp,
  main = "Boxplot of Number of Siblings/Spouses",
  ylab = "SibSp"
)
# ============================================
# 22. BOXPLOT OF PARCH
# ============================================

boxplot(
  data$Parch,
  main = "Boxplot of Number of Parents/Children",
  ylab = "Parch"
)
# ============================================
# 23. OUTLIER SUMMARY
# ============================================

outlier_summary <- data.frame(
  Variable = c("Age", "Fare", "SibSp", "Parch"),
  Outlier_Count = c(
    length(age_outliers),
    length(fare_outliers),
    length(sibsp_outliers),
    length(parch_outliers)
  )
)

outlier_summary
# ============================================
# 24. NORMALIZATION
# ============================================

# Min-Max normalization of Fare
data$Fare_Normalized <- (
  data$Fare - min(data$Fare)
) / (
  max(data$Fare) - min(data$Fare)
)

# Check normalized values
summary(data$Fare_Normalized)
# ============================================
# 25. CATEGORICAL ENCODING
# ============================================

# Encode Sex as a binary variable
data$Sex_Encoded <- ifelse(
  data$Sex == "male",
  1,
  0
)

# Check the encoded values
table(data$Sex, data$Sex_Encoded)
# ============================================
# 26. EDA - SURVIVAL DISTRIBUTION
# ============================================

# Count passengers by survival status
survival_count <- table(data$Survived)

survival_count
# Bar plot of survival status
barplot(
  survival_count,
  main = "Passenger Survival Distribution",
  xlab = "Survival Status",
  ylab = "Number of Passengers"
)
# ============================================
# 28. SURVIVAL BY GENDER
# ============================================

# Create a gender-survival table
gender_survival <- table(
  data$Sex,
  data$Survived
)

gender_survival
# Bar plot of survival by gender
barplot(
  gender_survival,
  beside = TRUE,
  main = "Survival by Gender",
  xlab = "Gender",
  ylab = "Number of Passengers",
  legend = TRUE
)
# ============================================
# 29. SURVIVAL BY PASSENGER CLASS
# ============================================

# Create passenger-class and survival table
class_survival <- table(
  data$Pclass,
  data$Survived
)

class_survival
# Bar plot of survival by passenger class
barplot(
  class_survival,
  beside = TRUE,
  main = "Survival by Passenger Class",
  xlab = "Passenger Class",
  ylab = "Number of Passengers",
  legend = TRUE
)
# ============================================
# 30. AGE DISTRIBUTION
# ============================================

hist(
  data$Age,
  main = "Age Distribution of Passengers",
  xlab = "Age",
  ylab = "Frequency"
)
# ============================================
# 31. FARE DISTRIBUTION
# ============================================

hist(
  data$Fare,
  main = "Fare Distribution of Passengers",
  xlab = "Fare",
  ylab = "Frequency"
)
# ============================================
# 32. CORRELATION ANALYSIS
# ============================================

# Select numerical variables
numeric_data <- data[, c(
  "Age",
  "Fare",
  "SibSp",
  "Parch"
)]

# Calculate correlation matrix
correlation_matrix <- cor(
  numeric_data,
  use = "complete.obs"
)

correlation_matrix
# ============================================
# 33. CORRELATION HEATMAP
# ============================================

heatmap(
  correlation_matrix,
  main = "Correlation Heatmap of Numerical Variables",
  symm = TRUE
)
# ============================================
# 34. SAVE CLEANED DATASET
# ============================================

write.csv(
  data,
  "data/titanic_cleaned.csv",
  row.names = FALSE
)
# ============================================================
# 38. SAVE FINAL CLEANED DATASET
# ============================================================

write.csv(
  data,
  "data/titanic_cleaned.csv",
  row.names = FALSE
)

# Check final dataset dimensions
dim(data)

# Check final missing values
colSums(is.na(data))

# Display final structure
str(data)
# 39. SAVE CLEANED DATASET

write.csv(
  data,
  "data/titanic_cleaned.csv",
  row.names = FALSE
)