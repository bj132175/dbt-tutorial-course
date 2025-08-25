WITH source AS (
    SELECT *
    FROM {{ source('raw', 'order_items') }}
)

SELECT
    id AS order_item_id,
    order_id,
    user_id,
    product_id,
    sale_price AS item_sale_price
FROM
    source