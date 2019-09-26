CREATE TABLE IF NOT EXISTS pmEntity (
   HIID           bigint        NOT NULL -- 'версия'
  ,enID           int           NOT NULL -- 'ID сущности'
  ,enName         varchar(50)   NOT NULL -- 'Название сущности'
  ,ParentID       int           NOT NULL -- 'ID родительской сущности'
  ,Responsible    varchar(100)  NOT NULL -- 'Ответственный'
  ,CreatedAt      datetime      NOT NULL -- 'дата создания'
  ,CreatedBy      int           NOT NULL -- 'автор создания'
  ,EditedAt       datetime          NULL -- 'дата изменения'
  ,EditedBy       int               NULL -- 'автор изменений'
);
--
