{% macro set_query_tag(extra = {}) -%}
    {{ return(adapter.dispatch('set_query_tag', 'dbt_query_tags')(extra=extra)) }}
{%- endmacro %}

{% macro unset_query_tag(original_query_tag) -%}
    {{ return(adapter.dispatch('unset_query_tag', 'dbt_query_tags')(original_query_tag)) }}
{%- endmacro %}
