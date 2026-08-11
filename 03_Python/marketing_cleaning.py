import pandas as pd

# Load dataset
marketing = pd.read_csv("01_Dataset/blinkit_marketing_performance.csv")

# Display first 5 rows
print("First 5 Rows:")
print(marketing.head())

# Display data types
print("\nData Types:")
print(marketing.dtypes)

# Convert date column
marketing["date"] = pd.to_datetime(
    marketing["date"],
    format="%d-%m-%Y"
)

# Check missing values
print("\nMissing Values:")
print(marketing.isnull().sum())

# Remove duplicate rows
marketing = marketing.drop_duplicates()

# Save cleaned dataset
marketing.to_csv(
    "01_Dataset/blinkit_marketing_performance_cleaned.csv",
    index=False
)

print("\nCleaning Completed Successfully!")
print("Cleaned file saved as: blinkit_marketing_performance_cleaned.csv")