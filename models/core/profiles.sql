{{
  config(
    pre_hook = before_begin("{{ loop_connected_component(max_loop= 5)}}")
    )
}}

with all_id as (

    select 
        id_1 as original_id,
        curr_id_1 as loop_generated_id,
        timestamp, 
        loop_iteration 
    from 
        {{ ref('base_table') }}

    union all 
    select 
        id_2 as original_id, 
        curr_id_2 as loop_generated_id, 
        timestamp, 
        loop_iteration 

    from 
        {{ ref('base_table') }}

),

first_seen_at_graph as (

    select 
        id_1 as original_id,
        timestamp
    from 
        {{ ref('base_table') }}

    union all 
    select 
        id_2 as original_id, 
        timestamp

    from 
        {{ ref('base_table') }}

),

first_seen_at_per_id as (

    select 
        original_id, 
        min(timestamp) as first_seen_at

    from 
        first_seen_at_graph

    group by original_id

),

find_max_loop_iteration as (

    select 
        all_id.original_id, 
        all_id.loop_generated_id,
        first_seen_at_per_id.first_seen_at,
        all_id.timestamp as original_timestamp, 
        all_id.loop_iteration, 
        max(all_id.loop_iteration) over (partition by all_id.original_id) as max_loop_iteration

    from 
        all_id

    left join 
        first_seen_at_per_id
        on first_seen_at_per_id.original_id = all_id.original_id

),

profile_mapping as (

    select distinct
        original_id, 
        first_seen_at,
        loop_generated_id 
        
    from 
        find_max_loop_iteration 
        
    where 
        loop_iteration = max_loop_iteration 
        
)

select 

    original_id, 
    first_value(original_id)
        over(
            partition by loop_generated_id 
            order by first_seen_at asc
    ) as profile_id

from 
    profile_mapping

order by profile_id, original_id
