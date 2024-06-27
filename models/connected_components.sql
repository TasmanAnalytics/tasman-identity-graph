declare loop_counter int := 0;

begin
    while (loop_counter < 5) do
    insert into dbt_package_dev.dbt_anna.base_id_graph (
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
                when tmp_id_1 < curr_id_1 then :loop_counter + 1
                else version_curr_id_1
             end as version_curr_id_1,
             
             case
                when curr_id_2 is null then version_curr_id_2
                when tmp_id_2 < curr_id_2 then :loop_counter + 1
                else version_curr_id_2
             end as version_curr_id_2,
             :loop_counter as loop_iteration
             
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
                    dbt_package_dev.dbt_anna.base_id_graph
               
               where 
                version_curr_id_1 = :loop_counter
                or version_curr_id_2 = :loop_counter
            )
     );
    
    loop_counter := loop_counter + 1;
    
  end while;
  return loop_counter;
end;

select * from dbt_package_dev.dbt_anna.base_id_graph 
order by id_1, id_2, timestamp, version_curr_id_1, version_curr_id_2
