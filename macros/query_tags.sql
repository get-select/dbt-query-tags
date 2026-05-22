{% macro set_query_tag(extra = {}) -%}
    {{ return(adapter.dispatch('set_query_tag', 'dbt_query_tags')(extra=extra)) }}
{%- endmacro %}

{% macro unset_query_tag(original_query_tag) -%}
    {{ return(adapter.dispatch('unset_query_tag', 'dbt_query_tags')(original_query_tag)) }}
{%- endmacro %}

{# BigQuery has no per-execution job-label mechanism from hook context; all metadata lives in the query comment. #}
{% macro bigquery__set_query_tag(extra = {}) -%}
    {{ return("") }}
{%- endmacro %}

{% macro bigquery__unset_query_tag(original_query_tag) -%}
    {{ return("") }}
{%- endmacro %}
