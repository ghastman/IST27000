CREATE VIEW `ist270`.`aggregate_cdr_stats` AS
    SELECT 
        `ist270`.`cdr_statistics`.`ims_function` AS `ims_function`,
        `ist270`.`ims_functions`.`name` AS `ims_name`,
        `ist270`.`cdr_statistics`.`fiveminuteepoch` AS `fiveminuteepoch`,
        `ist270`.`cdr_statistics`.`call_leg_id` AS `call_leg_id`,
        `ist270`.`call_leg_types`.`name` AS `call_leg_name`,
        `ist270`.`call_leg_types`.`abbreviation` AS `call_leg_abv`,
        `ist270`.`cdr_statistics`.`disco_id` AS `disco_id`,
        `ist270`.`disconnect_codes`.`name` AS `disco_name`,
        SUM(`ist270`.`cdr_statistics`.`count`) AS `count`,
        SUM(`ist270`.`cdr_statistics`.`duration`) AS `duration`
    FROM
        (((`ist270`.`cdr_statistics`
        JOIN `ist270`.`ims_functions` ON ((`ist270`.`cdr_statistics`.`ims_function` = `ist270`.`ims_functions`.`id`)))
        JOIN `ist270`.`call_leg_types` ON ((`ist270`.`cdr_statistics`.`call_leg_id` = `ist270`.`call_leg_types`.`id`)))
        JOIN `ist270`.`disconnect_codes` ON ((`ist270`.`cdr_statistics`.`disco_id` = `ist270`.`disconnect_codes`.`id`)))
    GROUP BY `ist270`.`cdr_statistics`.`ims_function` , `ist270`.`cdr_statistics`.`fiveminuteepoch` , `ist270`.`cdr_statistics`.`call_leg_id` , `ist270`.`cdr_statistics`.`disco_id`
    ;

CREATE VIEW `ist270`.`delivery_delay_irc_by_node` AS
    SELECT 
        `ist270`.`files_cdr`.`ims_function` AS `ims_function`,
        `ist270`.`ims_functions`.`name` AS `IMS Name`,
        `ist270`.`files_cdr`.`ccf_node` AS `ccf_node`,
        `ist270`.`nodes_ccf`.`node_fqdn` AS `node_fqdn`,
        FLOOR(AVG(TIMEDIFF(`ist270`.`files_cdr`.`file_delivery_time`,
                        `ist270`.`files_cdr`.`file_create_time`))) AS `avg_delay`
    FROM
        ((`ist270`.`files_cdr`
        JOIN `ist270`.`nodes_ccf` ON ((`ist270`.`files_cdr`.`ccf_node` = `ist270`.`nodes_ccf`.`id_node`)))
        JOIN `ist270`.`ims_functions` ON ((`ist270`.`files_cdr`.`ims_function` = `ist270`.`ims_functions`.`id`)))
    WHERE
        (`ist270`.`files_cdr`.`ims_function` = 6)
    GROUP BY `ist270`.`files_cdr`.`ims_function` , `ist270`.`files_cdr`.`ccf_node`   
    ;

 CREATE VIEW `ist270`.`delivery_delay_irc_overall` AS
    SELECT 
        `ist270`.`files_cdr`.`ims_function` AS `ims_function`,
        FLOOR(AVG(TIMEDIFF(`ist270`.`files_cdr`.`file_delivery_time`,
                        `ist270`.`files_cdr`.`file_create_time`))) AS `avg_delay`
    FROM
        `ist270`.`files_cdr`
    WHERE
        (`ist270`.`files_cdr`.`ims_function` = 6)
    GROUP BY `ist270`.`files_cdr`.`ims_function`   
    ;

CREATE VIEW `ist270`.`delivery_delay_irc_overall` AS
    SELECT 
        `ist270`.`files_cdr`.`ims_function` AS `ims_function`,
        FLOOR(AVG(TIMEDIFF(`ist270`.`files_cdr`.`file_delivery_time`,
                        `ist270`.`files_cdr`.`file_create_time`))) AS `avg_delay`
    FROM
        `ist270`.`files_cdr`
    WHERE
        (`ist270`.`files_cdr`.`ims_function` = 6)
    GROUP BY `ist270`.`files_cdr`.`ims_function`

CREATE VIEW `ist270`.`unvalidated_reason_headers` AS
    SELECT 
        `ist270`.`reason_header`.`ims_function_id` AS `ims_function_id`,
        `ist270`.`ims_functions`.`name` AS `IMS Name`,
        `ist270`.`ims_functions`.`filename_key` AS `filename_key`,
        `ist270`.`reason_header`.`call_leg_id` AS `call_leg_id`,
        `ist270`.`call_leg_types`.`name` AS `Call Leg Name`,
        `ist270`.`call_leg_types`.`abbreviation` AS `abbreviation`,
        `ist270`.`reason_header`.`cdr_data` AS `cdr_data`
    FROM
        ((`ist270`.`reason_header`
        JOIN `ist270`.`call_leg_types` ON ((`ist270`.`reason_header`.`call_leg_id` = `ist270`.`call_leg_types`.`id`)))
        JOIN `ist270`.`ims_functions` ON ((`ist270`.`reason_header`.`ims_function_id` = `ist270`.`ims_functions`.`id`)))    
    ;        