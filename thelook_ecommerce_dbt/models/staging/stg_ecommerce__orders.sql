WITH source AS (
    SELECT *
    FROM {{ source('raw', 'orders') }}
)

SELECT
    order_id,
    user_id,
    status,
    {{ string_to_timestamp('created_at') }} AS created_at,
    {{ string_to_timestamp('returned_at') }} AS returned_at,
    {{ string_to_timestamp('shipped_at') }} AS shipped_at,
    {{ string_to_timestamp('delivered_at') }} AS delivered_at,
    num_of_item AS num_items_ordered
FROM
    source