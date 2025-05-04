-- SELECT * FROM ist270.cdr_statistics;

INSERT IGNORE INTO `ist270`.`cdr_statistics`(
	 `file_id`
	,`ims_function`
    ,`fiveminuteepoch`
    ,`call_leg_id`
    ,`disco_id`
    ,`count`
    ,`duration`
)
VALUES
 (1,6,from_unixtime(1746366000),200,200,2,55)
,(2,6,from_unixtime(1746366000),200,200,2,56)
,(3,6,from_unixtime(1746366000),200,200,2,56)
,(4,6,from_unixtime(1746366000),200,503,2,0)
;
