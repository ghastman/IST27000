-- SELECT * FROM ist270.reason_header;

INSERT IGNORE INTO `ist270`.`reason_header`(
	 `ims_function_id`
    ,`call_leg_id`
    ,`cdr_data`
)
VALUES
 (6,200,'SIP;cause=200;text="Call Rejected By User"')
,(6,200,'text="Random Vendor Return Message 01"')
,(6,200,'text="Random Vendor Return Message 02"')
,(6,200,'text="Random Vendor Return Message 03"')
,(6,100,'SIP;cause=34;text="Server Failure"')
,(6,100,'text="Random Vendor Return Message 01"')
,(6,100,'text="Random Vendor Return Message 02"')
,(6,100,'text="Random Vendor Return Message 03"')
;
