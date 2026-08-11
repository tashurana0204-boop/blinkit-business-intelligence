import pandas as pd

# Load the delivery performance dataset
delivery = pd.read_csv("01_Dataset/blinkit_delivery_performance.csv")

# Display first 5 rows
print("First 5 Rows:")
print(delivery.head())

# Display data types
print("\nData Types:")
print(delivery.dtypes)

# Convert datetime columns
delivery["promised_time"] = pd.to_datetime(
    delivery["promised_time"],
    format="%d-%m-%Y %H:%M"
)

delivery["actual_time"] = pd.to_datetime(
    delivery["actual_time"],
    format="%d-%m-%Y %H:%M"
)

# Check missing values
print("\nMissing Values:")
print(delivery.isnull().sum())

# Remove duplicate rows
delivery = delivery.drop_duplicates()

# Save cleaned dataset
delivery.to_csv(
    "01_Dataset/blinkit_delivery_performance_cleaned.csv",
    index=False
)

print("\nCleaning Completed Successfully!")
print("Cleaned file saved as: blinkit_delivery_performance_cleaned.csv")