CREATE TABLE IF NOT EXISTS slOrder
(
   HIID           timestamp         NOT NULL -- 'временная метка'
	,dcID           int               NOT NULL -- 'ID документа'
  ,ptID           int               NOT NULL -- 'ID типа оплаты'
  ,Address        varchar(200)      NOT NULL -- 'адрес доставки'
	,SubTotal       decimal(14,2)     NOT NULL -- 'сумма заказа'
  ,Freight        decimal(14,2)     NOT NULL -- 'стоимость доставки'
  ,TotalDue       decimal(14,2)     NOT NULL -- 'сумма к оплате'
	,TaxAmt         decimal(14,2)     NOT NULL -- 'пошленый сбор'
  ,WeightTotal    decimal(14,2)         NULL -- 'вес посылки'
  ,TrackingNum    nvarchar(25)          NULL -- 'номер'
  ,INDEX IX_slOrders_PtID (ptID)
);
--
