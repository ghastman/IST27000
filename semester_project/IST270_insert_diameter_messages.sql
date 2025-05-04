-- SELECT * FROM ist270.diameter_messages;

INSERT IGNORE INTO `ist270`.`diameter_messages`(
	 `diameter_id`
	,`cdr_data`
)
VALUES
 (1001010015, 'MTA01A')
,(1001010015, 'MTA02A')
,(1001010015, 'MTA02B')
,(1001010016, 'European Telco')
,(1001010016, 'Canadian Telco')
,(1001010020, 'stas-tafe.01.ims.megatel.co')
,(1001010020, 'stas-tafe.02.ims.megatel.co')
#google dns
,(1001010021, '2001:4860:4860::8888')
,(1001010021, '2001:4860:4860::8844')
,(1001010025, 'pcscf.01.ims.megatel.co')
,(1001010025, 'pcscf.02.ims.megatel.co')
#canada
,(1001020006, '250NPANXXX')
#czech republic
,(1001020006, '420XXXxxxxxx')
,(1001020012, '12345')
,(1001020012, '54321')
,(1001020014, 'EUTC')
,(1001020014, 'CATC')
,(1001020016, '8.8.8.8')
,(1001020016, '8.8.4.4')
;
