WITH source AS (
    SELECT *
    FROM {{ source('raw', 'products') }}
)

SELECT
    id AS product_id,
    cost,
    retail_price,
    department
FROM
    source