{% macro insert_into_connected_components(loop_counter) %}
{% set query %}
insert into {{ ref('tasman_identity_base_table') }} (
select
        id_1,
        id_2,
        timestamp,
        case
            when curr_id_1 is null then null
            when tmp_id_1 < curr_id_1 then tmp_id_1
            else curr_id_1
        end as curr_id_1,

        case
            when curr_id_2 is null then null
            when tmp_id_2 < curr_id_2 then tmp_id_2
            else curr_id_2
        end as curr_id_2,
        
        case
            when curr_id_1 is null then version_curr_id_1
            when tmp_id_1 < curr_id_1 then {{ loop_counter }} + 1
            else version_curr_id_1
        end as version_curr_id_1,
        
        case
            when curr_id_2 is null then version_curr_id_2
            when tmp_id_2 < curr_id_2 then {{ loop_counter }} + 1
            else version_curr_id_2
        end as version_curr_id_2,
        {{ loop_counter }} as loop_iteration
        
    from (
        select
            id_1,
            id_2,
            timestamp,
            curr_id_1,
            curr_id_2,
            version_curr_id_1,
            version_curr_id_2,
            min(curr_id_2)
                over(partition by id_1)
                as tmp_id_1,
                
            min(curr_id_1)
                over(partition by id_2)
                as tmp_id_2
            
        from
            {{ ref('tasman_identity_base_table') }}
        
        where 
            version_curr_id_1 = {{ loop_counter }}
            or version_curr_id_2 = {{ loop_counter }}
        )
)
{% endset %}

{{ run_query(query)}}

{% endmacro %}