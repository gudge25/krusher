/*ALTER TABLE crmClient
   ADD CONSTRAINT FK_crmClient_fsFile FOREIGN KEY (ffID) REFERENCES fsFile (ffID)
  ,ADD CONSTRAINT FK_crmClient_crmClient FOREIGN KEY (ParentID) REFERENCES crmClient (clID)
  ,ADD CONSTRAINT FK_crmClient_emEmploy_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES emEmploy (emID)
  ,ADD CONSTRAINT FK_crmClient_emEmploy_EditedBy  FOREIGN KEY (EditedBy) REFERENCES emEmploy (emID);
--
ALTER TABLE crmClientEx
  ADD CONSTRAINT FK_crmClientEx_crmClient FOREIGN KEY (clID) REFERENCES crmClient (clID);
--
ALTER TABLE crmContact
  ADD CONSTRAINT FK_crmContacts_crmClient FOREIGN KEY (clID) REFERENCES crmClient (clID);
--
ALTER TABLE crmOrg
   ADD CONSTRAINT FK_crmOrg_crmClient FOREIGN KEY (clID) REFERENCES crmClient (clID)
  ,ADD CONSTRAINT FK_crmOrg_emEmploy_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES emEmploy (emID)
  ,ADD CONSTRAINT FK_crmOrg_emEmploy_EditedBy FOREIGN KEY (EditedBy) REFERENCES emEmploy (emID);
--
ALTER TABLE crmPerson
  ADD CONSTRAINT FK_crmPerson_crmClient
  FOREIGN KEY (clID) REFERENCES crmClient (clID);
--
ALTER TABLE crmRegion
  ADD CONSTRAINT crmRegion_crmClient FOREIGN KEY (clID) REFERENCES crmClient (clID);
--
ALTER TABLE crmStatus
  ADD CONSTRAINT FK_crmStatus_crmClient FOREIGN KEY (clID) REFERENCES crmClient (clID);
--
ALTER TABLE crmTag
   ADD CONSTRAINT FK_crmTag_crmTagList FOREIGN KEY (tagID) REFERENCES crmTagList (tagID)
  ,ADD CONSTRAINT FK_crmTag_crmClient FOREIGN KEY (clID) REFERENCES crmClient (clID);
--
ALTER TABLE crmAddress
   ADD CONSTRAINT FK_crmAddress_crmClient FOREIGN KEY (clID) REFERENCES crmClient (clID);
--
ALTER TABLE crmEvent
   ADD CONSTRAINT FK_crmEvent_dcDoc FOREIGN KEY (dcID) REFERENCES dcDoc (dcID)
  ,ADD CONSTRAINT FK_crmEvent_crmEventMeta FOREIGN KEY (metaID) REFERENCES crmEventMeta (metaID);
--
ALTER TABLE crmClientProduct
   ADD CONSTRAINT FK_crmClientProduct_stProduct FOREIGN KEY (psID) REFERENCES stProduct (psID)
  ,ADD CONSTRAINT FK_crmClientProduct_clID FOREIGN KEY (clID) REFERENCES crmClient (clID);
*/