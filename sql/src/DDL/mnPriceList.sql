CREATE TABLE IF NOT EXISTS mnPriceList (
   psID           int           NOT NULL -- 'ID записи'
  ,crID           int           NOT NULL -- 'валюта'
  ,EntryPrice     decimal(14,4) NOT NULL -- 'входная цена'
  ,EntryCoef      decimal(14,4) NOT NULL -- 'коэффициент, по которому считается внутренняя цена'
  ,FinalCost	    decimal(14,4) NOT NULL -- 'конечная (рекомендованная) цена'
  ,WholeSale      decimal(14,2) NOT NULL -- 'оптовая цена'
);
--
