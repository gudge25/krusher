CREATE TABLE IF NOT EXISTS gnrCurrencyRate (
   gcrrID     int           NOT NULL
  ,gcrID      int           NOT NULL
  ,DateFrom   date          NOT NULL
  ,Rate       decimal(14,4) NOT NULL
  ,PRIMARY KEY (gcrrID)
);
--
