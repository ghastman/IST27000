-- SELECT * FROM ist270.nodes_ccf;
-- DELETE FROM ist270.nodes_ccf where id_node > -1;

INSERT IGNORE INTO `ist270`.`nodes_ccf`(
	`node_fqdn`
    ,`filename_key`
)
VALUES
 ('north.virc.ims.megatel.co','NVIRC')
,('east.virc.ims.megatel.co','EVIRC')
,('south.virc.ims.megatel.co','SVIRC')
,('west.virc.ims.megatel.co','WVIRC')
;
