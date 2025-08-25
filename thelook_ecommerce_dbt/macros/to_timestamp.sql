/*
This macro attempts to parse string timestamps that may or may not include fractional seconds.
Some values contain fractions ("YYYY-MM-DD HH24:MI:SS.FF TZD"), others do not ("YYYY-MM-DD HH24:MI:SS TZD").
By calling TRY_TO_TIMESTAMP with both formats and using COALESCE, we guarantee  conversion for mixed timestamp formats,
regardless of whether fractional seconds are present, and preserve the UTC timezone for accuracy.
*/

{% macro string_to_timestamp(timestamp_string) %}

  COALESCE(
    TRY_TO_TIMESTAMP({{ timestamp_string }}, 'YYYY-MM-DD HH24:MI:SS.FF TZD'), -- First, try with fractional seconds
    TRY_TO_TIMESTAMP({{ timestamp_string }}, 'YYYY-MM-DD HH24:MI:SS TZD')     -- If that fails, try without
  )

{% endmacro %}