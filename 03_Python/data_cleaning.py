import pandas as pd

# Load dataset
orders = pd.read_csv("01_Dataset/blinkit_orders.csv")

# Display first 5 rows
print("First 5 Rows:")
print(orders.head())

# Check data types
print("\nData Types:")
print(orders.dtypes)

# Convert date columns
orders["order_date"] = pd.to_datetime(
    orders["order_date"],
    format="%d-%m-%Y %H:%M"
)

orders["promised_delivery_time"] = pd.to_datetime(
    orders["promised_delivery_time"],
    format="%d-%m-%Y %H:%M"
)

orders["actual_delivery_time"] = pd.to_datetime(
    orders["actual_delivery_time"],
    format="%d-%m-%Y %H:%M"
)

# Check for missing values
print("\nMissing Values:")
print(orders.isnull().sum())

# Remove duplicate rows
orders = orders.drop_duplicates()

# Save cleaned dataset
orders.to_csv("01_Dataset/blinkit_orders_cleaned.csv", index=False)

print("\nCleaning Completed Successfully!")
print("Cleaned file saved as: blinkit_orders_cleaned.csv")