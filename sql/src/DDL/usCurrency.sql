CREATE TABLE IF NOT EXISTS usCurrency (
   crID           int           NOT NULL  -- 'ID записи'
  ,crName         varchar(4)    NOT NULL  -- 'название'
  ,crFullName     varchar(25)   NOT NULL  -- 'описание'
  ,isActive       bit           NOT NULL  DEFAULT 0  -- 'признак активности'
  ,CreatedAt      datetime      NOT NULL  -- 'дата создания'
  ,CreatedBy      int           NOT NULL  -- 'автор создания'
  ,EditedAt       datetime          NULL  -- 'дата изменения'
  ,EditedBy       int               NULL  -- 'автор изменений'
  ,PRIMARY KEY (crID)
  ,INDEX usCurrency_CreatedBy (CreatedBy)
  ,INDEX usCurrency_EditedBy (EditedBy)
);
--
