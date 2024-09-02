{% macro loop_connected_component(max_loop, current=0) %}
    {% if current <= max_loop %}
        {{ insert_into_connected_components(loop_counter=current) }},
        {{ loop_connected_component(max_loop, current + 1) }}
    {% endif %}
{% endmacro %}