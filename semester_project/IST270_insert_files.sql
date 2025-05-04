-- SELECT * FROM ist270.files_cdr;

INSERT IGNORE INTO `ist270`.`files_cdr`(
     `filename`
    ,`ims_function`
    ,`ccf_node`
    ,`file_create_time`
    ,`file_delivery_time`
)
VALUES
 ('NVIRC_20250504085011_00000527_G01KNC.XML',6,1,from_unixtime(1746366611),from_unixtime(1746366791))
,('EVIRC_20250504085011_00000527_G01KNC.XML',6,2,from_unixtime(1746366611),from_unixtime(1746366791))
,('SVIRC_20250504085011_00000527_G01KNC.XML',6,3,from_unixtime(1746366611),from_unixtime(1746366791))
,('WVIRC_20250504085011_00000527_G01KNC.XML',6,4,from_unixtime(1746366611),from_unixtime(1746366791))
,('NVIRC_20250504085045_00000527_G01KNC.XML',6,1,from_unixtime(1746366645),from_unixtime(1746366891))


;
