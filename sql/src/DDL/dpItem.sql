CREATE TABLE IF NOT EXISTS dpItem (
   HIID           bigint        NOT NULL  -- версия
  ,dpiID          int           NOT NULL  -- ID пункта складского документа
  ,dcID           int           NOT NULL  -- Ид. документа
  ,psID           int           NOT NULL  -- ID продукта
  ,dpQty          decimal(14,2) NOT NULL  -- Количество материала
  ,dpPrice        decimal(14,2)     NULL  -- Цена
  ,dpVAT          decimal(14,2)     NULL  -- НДС
  ,dpComment      varchar(255)      NULL  -- Комментарии
);
-- 'Складские документы';
--
