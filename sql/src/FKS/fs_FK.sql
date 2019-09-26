/*ALTER TABLE fsClient
  ADD CONSTRAINT FK_fsClient_fsFile FOREIGN KEY (ffID) REFERENCES fsFile (ffID);
--
ALTER TABLE fsContact
  ADD CONSTRAINT FK_fsContact_fsClient FOREIGN KEY (fclID) REFERENCES fsClient (fclID);
--
ALTER TABLE fsTemplateItem
  ADD CONSTRAINT FK_fsTemplateItem_fsTemplate FOREIGN KEY (ftID) REFERENCES fsTemplate (ftID);
--
ALTER TABLE fsTemplateItemCol
  ADD CONSTRAINT FK_fsTemplateItemCol_fsTemplateItem FOREIGN KEY (ftiID) REFERENCES fsTemplateItem (ftiID);
--
ALTER TABLE fsFile
  ADD CONSTRAINT FK_fsFile_fsBase FOREIGN KEY (dbID) REFERENCES fsBase (dbID);
--
*/