-- SELECT * FROM ist270.call_leg_types;
INSERT IGNORE INTO `ist270`.`call_leg_types`(
	 `id`
    ,`name`
    ,`abbreviation`
)
VALUES
 (100,'Originating','O')
,(200,'Terminating','T')
,(911,'Emergency','E')
,(300,'Interim','I')
;
