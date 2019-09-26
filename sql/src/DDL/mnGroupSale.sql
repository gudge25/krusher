CREATE TABLE IF NOT EXISTS mnGroupSale (
   HIID         bigint            NOT NULL -- 'версия'
  ,gsID         int               NOT NULL -- 'ID записи'
  ,gsName       varchar(100)      NOT NULL -- 'название'
  ,isActive     bit               NOT NULL -- 'признак активности' DEFAULT 0
  ,ParentID     int                   NULL -- 'родитель'
  ,draID        int                   NULL -- 'ID направления деятельности'
  ,CreatedAt    datetime          NOT NULL -- 'дата создания'
  ,CreatedBy    int               NOT NULL -- 'автор создания'
  ,EditedAt     datetime              NULL -- 'дата изменения'
  ,EditedBy     int                   NULL -- 'автор изменений'
  ,PRIMARY KEY (gsID)
  ,INDEX IX_mnGroupSale_draID (draID)
  ,INDEX IX_mnGroupSale_ParentID (ParentID)
  ,INDEX IX_mnGroupSale_CreatedBy (CreatedBy)
  ,INDEX IX_mnGroupSale_EditedBy (EditedBy)
);
-- 'Группы продаж';
--
