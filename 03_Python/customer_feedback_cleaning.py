import pandas as pd

# Load dataset
feedback = pd.read_csv("01_Dataset/blinkit_customer_feedback.csv")

# Display first 5 rows
print("First 5 Rows:")
print(feedback.head())

# Display data types
print("\nData Types:")
print(feedback.dtypes)

# Convert feedback_date to proper date format
feedback["feedback_date"] = pd.to_datetime(
    feedback["feedback_date"],
    format="%d-%m-%Y"
)

# Check missing values
print("\nMissing Values:")
print(feedback.isnull().sum())

# Remove duplicate rows
feedback = feedback.drop_duplicates()

# Save cleaned dataset
feedback.to_csv(
    "01_Dataset/blinkit_customer_feedback_cleaned.csv",
    index=False
)

print("\nCleaning Completed Successfully!")
print("Cleaned file saved as: blinkit_customer_feedback_cleaned.csv")