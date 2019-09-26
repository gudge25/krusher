/*ALTER TABLE slDeal
   ADD CONSTRAINT FK_slDeal_dcDoc FOREIGN KEY (dcID) REFERENCES dcDoc (dcID);
--
ALTER TABLE slDealItem
   ADD CONSTRAINT FK_slDealItem_slDeal FOREIGN KEY (dcID) REFERENCES slDeal (dcID)
  ,ADD CONSTRAINT FK_slDealItem_stProduct FOREIGN KEY (psID) REFERENCES stProduct (psID);
--*/

-- ALTER TABLE slOrder
--    ADD CONSTRAINT PK_slOrders PRIMARY KEY (dcID)
--   ,ADD CONSTRAINT FK_slOrders_dcDoc FOREIGN KEY (dcID) REFERENCES dcDoc (dcID)
--   ,ADD CONSTRAINT FK_slOrder_slPayType FOREIGN KEY (ptID) REFERENCES sl_paytype (ptID);
-- --
