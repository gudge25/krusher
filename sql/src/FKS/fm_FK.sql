/*ALTER TABLE fmForm
   ADD CONSTRAINT FK_fmForm_dcDoc FOREIGN KEY (dcID) REFERENCES dcDoc (dcID)
  ,ADD CONSTRAINT FK_fmForm_fmFormType FOREIGN KEY (tpID) REFERENCES fmFormType (tpID);
--
ALTER TABLE fmFormItem
   ADD CONSTRAINT FK_fmFormItem_fmForm FOREIGN KEY (dcID) REFERENCES fmForm (dcID);
  -- ,ADD CONSTRAINT FK_fmFormItem_fmQuestionItem FOREIGN KEY (qiID) REFERENCES fmQuestionItem (qiID);
  -- ,ADD CONSTRAINT FK_fmFormItem_fmQuestion FOREIGN KEY (qID) REFERENCES fmQuestion (qID);
ALTER TABLE fmQuestionItem
   ADD CONSTRAINT FK_fmQuestionItem_fmQuestion FOREIGN KEY (qID) REFERENCES fmQuestion (qID);
--
ALTER TABLE fmQuestion
   ADD CONSTRAINT FK_fmQuestion_fmFormType FOREIGN KEY (tpID) REFERENCES fmFormType(tpID);


*/