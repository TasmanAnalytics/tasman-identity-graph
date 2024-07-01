with 

events_per_id as (
    
    select 
        event_id, 
        event_time, 
        id
        
    from 
        {{ ref('identifies_events') }}
        
    unpivot (
        id for id_type in (user_id, anonymous_id, email)
        )
        
    order by 
        event_id
        
),

base_id_graph as (

    select 
        first.id as id_1, 
        second.id as id_2,
        first.event_time as timestamp, 
        first.id as curr_id_1, 
        second.id as curr_id_2,  
        0 as version_curr_id_1, 
        0 as version_curr_id_2,
        null as loop_iteration
        
    from 
        events_per_id as first
        
    inner join 
        events_per_id as second 
        on first.event_id = second.event_id
    
    where 
        first.id < second.id
        
    order by 
        first.event_id

)

select * from base_id_graph