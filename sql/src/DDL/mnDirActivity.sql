CREATE TABLE IF NOT EXISTS mnDirActivity (
   HIID         bigint            NOT NULL -- 'версия'
  ,draID        int               NOT NULL -- 'ID записи'
  ,draName      varchar(100)      NOT NULL -- 'название'
  ,isActive     bit               NOT NULL -- 'признак активности' DEFAULT 0
  ,ParentID     int                   NULL -- 'родитель'
  ,pcID         int               NOT NULL -- 'ID профитцентра'
  ,CreatedAt    datetime          NOT NULL -- 'дата создания'
  ,CreatedBy    int               NOT NULL -- 'автор создания'
  ,EditedAt     datetime              NULL -- 'дата изменения'
  ,EditedBy     int                   NULL -- 'автор изменений'
  ,PRIMARY KEY (draID)
  ,INDEX IX_mnDirActivity_ParentID (ParentID ASC)
  ,INDEX IX_mnDirActivity_pcID (pcID)
  ,INDEX IX_mnDirActivity_CreatedBy (CreatedBy)
  ,INDEX IX_mnDirActivity_EditedBy (EditedBy)
);
-- 'Направление деятельности';
--
