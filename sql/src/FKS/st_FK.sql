/*ALTER TABLE stCategory
  ADD CONSTRAINT FK_stCategory_stCategory FOREIGN KEY (ParentID) REFERENCES stCategory (pctID);
--
ALTER TABLE stProduct
	 ADD CONSTRAINT FK_stProduct_emEmploy_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES emEmploy (emID)
	,ADD CONSTRAINT FK_stProduct_emEmploy_EditedBy FOREIGN KEY (EditedBy) REFERENCES emEmploy (emID)
  ,ADD CONSTRAINT FK_stProduct_stProduct FOREIGN KEY (ParentID) REFERENCES stProduct (psID)
  ,ADD CONSTRAINT FK_stProduct_stCategory FOREIGN KEY (pctID) REFERENCES stCategory (pctID)
  ,ADD CONSTRAINT FK_stProduct_stBrand FOREIGN KEY (bID) REFERENCES stBrand (bID);
--
*/