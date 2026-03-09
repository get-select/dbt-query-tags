{% macro databricks__set_query_tag(extra = {}) -%}
    {# extra and other Snowflake-specific extension points (model query_tag config,
       profiles.yml session tag, env_vars_to_query_tag_list) are intentionally not
       supported on Databricks — the adapter already provides rich tagging via its
       auto-appended @@dbt_* tags. #}

    {% set query_tag = {
        'app': 'dbt',
        'dbt_query_tags_version': '3.0.1',
    } %}

    {% if thread_id %}
        {%- do query_tag.update(thread_id=thread_id) -%}
    {% endif %}

    {# We have to bring is_incremental through here because its not available in the comment context #}
    {% if model.resource_type == 'model' %}
        {%- do query_tag.update(is_incremental=is_incremental()) -%}
    {% endif %}

    {% set query_tag_json = tojson(query_tag) %}
    {{ log("Setting query_tag metadata to '" ~ query_tag_json ~ "'.") }}
    {{ return("SET QUERY_TAGS['metadata'] = '{}'".format(query_tag_json)) }}
{%- endmacro %}

{% macro databricks__unset_query_tag(original_query_tag) -%}
    {# original_query_tag is unused — no save/restore needed since we only touch the named 'metadata' key #}
    {{ log("Unsetting query_tag metadata.") }}
    {{ return("SET QUERY_TAGS['metadata'] = UNSET") }}
{%- endmacro %}
