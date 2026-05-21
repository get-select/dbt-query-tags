{% macro set_query_tag(extra = {}) -%}
    {{ return(adapter.dispatch('set_query_tag', 'dbt_query_tags')(extra=extra)) }}
{%- endmacro %}

{% macro unset_query_tag(original_query_tag) -%}
    {{ return(adapter.dispatch('unset_query_tag', 'dbt_query_tags')(original_query_tag)) }}
{%- endmacro %}

{# No-op fallback for adapters without a dedicated implementation (e.g. BigQuery, where all metadata lives in the query comment). #}
{% macro default__set_query_tag(extra = {}) -%}
    {{ return("") }}
{%- endmacro %}

{% macro default__unset_query_tag(original_query_tag) -%}
    {{ return("") }}
{%- endmacro %}
