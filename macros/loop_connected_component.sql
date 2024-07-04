{% macro loop_connected_component() %}
{{ insert_into_connected_components(loop_counter=0) }}
{{ insert_into_connected_components(loop_counter=1) }}
{{ insert_into_connected_components(loop_counter=2) }}
{{ insert_into_connected_components(loop_counter=3) }}
{{ insert_into_connected_components(loop_counter=4) }}
{{ insert_into_connected_components(loop_counter=5) }}

{% endmacro %}