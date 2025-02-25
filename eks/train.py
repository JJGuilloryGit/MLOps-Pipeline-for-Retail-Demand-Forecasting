import os
import numpy as np
import pandas as pd
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense
from sklearn.preprocessing import MinMaxScaler
import mlflow
import mlflow.tensorflow

# Enable MLflow autologging
mlflow.tensorflow.autolog()

# Load dataset (replace with actual path)
data_path = "sales_data.csv"
df = pd.read_csv(data_path)

# Preprocess data
scaler = MinMaxScaler(feature_range=(0, 1))
df_scaled = scaler.fit_transform(df[['sales']])

# Create sequences for LSTM
def create_sequences(data, seq_length=10):
    X, y = [], []
    for i in range(len(data) - seq_length):
        X.append(data[i:i+seq_length])
        y.append(data[i+seq_length])
    return np.array(X), np.array(y)

seq_length = 10
X, y = create_sequences(df_scaled, seq_length)
X = np.reshape(X, (X.shape[0], X.shape[1], 1))

# Split data into train and test sets
split = int(0.8 * len(X))
X_train, X_test = X[:split], X[split:]
y_train, y_test = y[:split], y[split:]

# Build LSTM model
model = Sequential([
    LSTM(50, return_sequences=True, input_shape=(seq_length, 1)),
    LSTM(50, return_sequences=False),
    Dense(25, activation='relu'),
    Dense(1)
])

model.compile(optimizer='adam', loss='mse')

# Train model with MLflow tracking
with mlflow.start_run():
    model.fit(X_train, y_train, epochs=20, batch_size=16, validation_data=(X_test, y_test))
    mlflow.log_param("sequence_length", seq_length)
    mlflow.tensorflow.log_model(model, "model")

# Save trained model
model.save("model.h5")
print("Model training complete. Saved as model.h5")
