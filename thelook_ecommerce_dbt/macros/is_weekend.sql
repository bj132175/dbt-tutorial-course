{% macro is_weekend(date_col) %}

    DAYOFWEEK( {{date_col}} ) IN (6,7)
    
{% endmacro %}