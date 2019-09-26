CREATE TABLE IF NOT EXISTS dpDepDoc (
   HIID         bigint  NOT NULL  -- версия
  ,dcID         int     NOT NULL  -- Ид. документа
  ,dpType       int     NOT NULL  -- тип
  ,dpID         int     NOT NULL  -- склад
  ,isConfirm    bit     NOT NULL  -- признак утверждения
);
-- 'Складские документы';
--
