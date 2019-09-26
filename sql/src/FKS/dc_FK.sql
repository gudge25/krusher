/*ALTER TABLE dcDoc
   ADD CONSTRAINT FK_dcDoc_emEmploy_emID FOREIGN KEY (emID) REFERENCES emEmploy (emID)
  ,ADD CONSTRAINT FK_dcDoc_emEmploy_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES emEmploy (emID)
  ,ADD CONSTRAINT FK_dcDoc_emEmploy_EditedBy  FOREIGN KEY (EditedBy) REFERENCES  emEmploy (emID)
  ,ADD CONSTRAINT FK_dcDoc_crmClient FOREIGN KEY (clID) REFERENCES crmClient (clID)
  ,ADD CONSTRAINT FK_dcDoc_dcType FOREIGN KEY (dctID) REFERENCES dcType (dctID)
  ,ADD CONSTRAINT FK_dcDoc_mnCentre FOREIGN KEY (pcID) REFERENCES mnCentre (pcID);
--   ,ADD CONSTRAINT FK_dcDoc_mnDirActivity FOREIGN KEY (draID) REFERENCES mnDirActivity (draID)
--   ,ADD CONSTRAINT FK_dcDoc_usCurrency FOREIGN KEY (crID) REFERENCES usCurrency (crID);
--
ALTER TABLE dcDocTemplate
  ADD CONSTRAINT FK_dcDocTemplate_dcType FOREIGN KEY (dcTypeID) REFERENCES dcType (dctID);
--
*/