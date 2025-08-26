SELECT
    order_id
FROM
    {{ source('raw', 'orders') }}
WHERE
    (created_at IS NOT NULL AND {{ string_to_timestamp('created_at') }} IS NULL)
    OR (returned_at IS NOT NULL AND {{ string_to_timestamp('returned_at') }} IS NULL)
    OR (shipped_at IS NOT NULL AND {{ string_to_timestamp('shipped_at') }} IS NULL)
    OR (delivered_at IS NOT NULL AND {{ string_to_timestamp('delivered_at') }} IS NULL)