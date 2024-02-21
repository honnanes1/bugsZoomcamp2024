-- Select the columns interested for you 
SELECT passenger_count, trip_distance, PULocationID, DOLocationID, payment_type, fare_amount, tolls_amount, tip_amount
FROM `de-zoomcamp-412301.ny_taxi.yellow_tripdata_partitoned` WHERE fare_amount != 0;

-- Create a ML table with appropriate type
`passenger_count` INTEGER,
`trip_distance` FLOAT64,
`PULocationID` STRING,
`DOLocationID` STRING,
`payment_type` STRING,
`fare_amount` FLOAT64,
`tolls_amount` FLOAT64,
`tip_amount` FLOAT64
) AS (
SELECT passenger_count, trip_distance, cast(PULocationID AS STRING), CAST(DOLocationID AS STRING),
CAST(payment_type AS STRING), fare_amount, tolls_amount, tip_amount
FROM `de-zoomcamp-412301.ny_taxi.yellow_tripdata_partitoned` WHERE fare_amount != 0
);

-- Create model with default setting
CREATE OR REPLACE MODEL `de-zoomcamp-412301.ny_taxi.tip_model`
OPTIONS
(model_type='linear_reg',
input_label_cols=['tip_amount'],
DATA_SPLIT_METHOD='AUTO_SPLIT') AS
SELECT
*
FROM
`de-zoomcamp-412301.ny_taxi.yellow_tripdata_ml`
WHERE
tip_amount IS NOT NULL;


