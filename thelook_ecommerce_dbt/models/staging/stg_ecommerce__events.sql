{{
    config(
        materialized = 'incremental',
        unique_key = 'event_id',
        on_schema_change = 'sync_all_columns',
        parition_by={
            'field':'created_at',
            'data_type':'timestamp',
            'granularity':'day'
        }
    )
}}


WITH source AS (
    SELECT *
    FROM {{ source('raw', 'events') }}
)

SELECT
	id AS event_id,
	user_id,
	sequence_number,
	session_id,
	{{ string_to_timestamp('created_at') }} AS created_at,
	ip_address,
	city,
	state,
	postal_code,
	browser,
	traffic_source,
	uri,
	event_type
FROM
    source
{# Only runs this filter on an incremental run #}
{% if is_incremental() %}

    WHERE {{ string_to_timestamp('created_at') }} >= COALESCE((SELECT MAX(created_at) FROM {{ this }}), '1900-01-01')

{% endif %}