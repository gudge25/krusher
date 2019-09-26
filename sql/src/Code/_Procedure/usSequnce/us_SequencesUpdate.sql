DELIMITER $$
DROP PROCEDURE IF EXISTS us_SequencesUpdate;
CREATE PROCEDURE us_SequencesUpdate()
BEGIN
    DECLARE $id            INT;
    DECLARE $sql           VARCHAR(1000);
    --
    SET $sql = 'ALTER SEQUENCE IF EXISTS s3 RESTART ';
    SET $id = 1;
    --
    SELECT MAX(adsID)
    INTO $id
    FROM crmAddress;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'adsID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'adsID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(cbID)
    INTO $id
    FROM ast_callback;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'cbID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'cbID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(ccID)
    INTO $id
    FROM crmContact;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'ccID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'ccID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(cdID)
    INTO $id
    FROM ast_custom_destination;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'cdID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'cdID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(cfID)
    INTO $id
    FROM ast_conference;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'cfID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'cfID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(clID)
    INTO $id
    FROM crmClient;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'clID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'clID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(coID)
    INTO $id
    FROM crmCompany;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'coID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'coID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(comID)
    INTO $id
    FROM ccCommentList;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'comID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'comID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(cpID)
    INTO $id
    FROM crmClientProduct;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'cpID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'comID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(ctgID)
    INTO $id
    FROM crmTagList;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'ctgID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'ctgID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(dbID)
    INTO $id
    FROM fsBase;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'dbID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'dbID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(dcID)
    INTO $id
    FROM dcDoc;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'dcID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'dcID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(dctID)
    INTO $id
    FROM dcType;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'dctID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'dctID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(diID)
    INTO $id
    FROM slDealItem;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'diID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'diID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(dtID)
    INTO $id
    FROM dcDocTemplate;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'dtID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'dtID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(emID)
    INTO $id
    FROM emEmploy;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'emID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'emID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(entry_id)
    INTO $id
    FROM ast_ivr_entries;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'entry_id'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'entry_id'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(fclID)
    INTO $id
    FROM fsClient;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'fclID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'fclID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(ffID)
    INTO $id
    FROM fsFile;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'ffID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'ffID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(fiID)
    INTO $id
    FROM fmFormItem;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'fiID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'fiID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(ftID)
    INTO $id
    FROM fsTemplate;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'ftID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'ftID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(ftiID)
    INTO $id
    FROM fsTemplateItem;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'ftiID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'ftiID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(id_autodial)
    INTO $id
    FROM ast_autodial_process;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'id_autodial'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'id_autodial'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(id_ivr_config)
    INTO $id
    FROM ast_ivr_config;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'id_ivr_config'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'id_ivr_config'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(id_scenario)
    INTO $id
    FROM ast_scenario;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'id_scenario'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'id_scenario'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(iiID)
    INTO $id
    FROM sfInvoiceItem;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'iiID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'iiID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(msID)
    INTO $id
    FROM usMeasure;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'msID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'msID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(pctID)
    INTO $id
    FROM stCategory;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'pctID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'pctID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(plID)
    INTO $id
    FROM ast_pool_list;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'plID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'plID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(pnID)
    INTO $id
    FROM crmPerson;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'pnID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'pnID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(poolID)
    INTO $id
    FROM ast_pools;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'poolID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'poolID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(psID)
    INTO $id
    FROM stProduct;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'psID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'psID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(qID)
    INTO $id
    FROM fmQuestion;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'qID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'qID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(qiID)
    INTO $id
    FROM fmQuestionItem;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'qiID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'qiID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(queID)
    INTO $id
    FROM ast_queues;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'queID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'queID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(quemID)
    INTO $id
    FROM ast_queue_members;
    --
    SET @s = CONCAT(REPLACE($sql, 's3', ''), ($id+1), ';');
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'quemID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'quemID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(clID)
    INTO $id
    FROM crmClient;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'clID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'clID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(record_id)
    INTO $id
    FROM ast_record;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'record_id'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'record_id'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(region_id)
    INTO $id
    FROM reg_regions;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'region_id'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'region_id'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(roID)
    INTO $id
    FROM ast_route_outgoing;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'roID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'roID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(roiID)
    INTO $id
    FROM ast_route_outgoing_items;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'roiID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'roiID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(roleID)
    INTO $id
    FROM emRole;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'roleID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'roleID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(rtID)
    INTO $id
    FROM ast_route_incoming;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'rtID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'rtID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(sipID)
    INTO $id
    FROM ast_sippeers;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'sipID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'sipID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(tagID)
    INTO $id
    FROM crmTag;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'tagID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'tagID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(tgID)
    INTO $id
    FROM ast_time_group;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'tgID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'tgID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(tgiID)
    INTO $id
    FROM ast_time_group_items;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'tgiID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'tgiID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(tpID)
    INTO $id
    FROM fmFormType;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'tpID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'tpID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(trID)
    INTO $id
    FROM ast_trunk;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'trID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'trID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(ttsID)
    INTO $id
    FROM ast_tts;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'ttsID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'ttsID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $id = 1;
    --
    SELECT MAX(mpiID)
    INTO $id
    FROM mp_IntegrationInstall;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'mpiID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'mpiID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    --
    SET $id = 1;
    --
    SELECT MAX(mpiID)
    INTO $id
    FROM mp_IntegrationInstall;
    --
    IF($id IS NULL) THEN
        SET @s = CONCAT(REPLACE($sql, 's3', 'mpID'), '1', ';');
    ELSE
        SET @s = CONCAT(REPLACE($sql, 's3', 'mpID'), ($id+1), ';');
    END IF;
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
END $$
DELIMITER ;
--
