CREATE TABLE IF NOT EXISTS crmEvent (
   dcID       int               NULL
  ,metaID     int           NOT NULL
  ,title      varchar(200)  NOT NULL
  ,endsAt     datetime          NULL
  ,location   varchar(200)      NULL
  ,repeats    int               NULL
  ,isClosed   bit           NOT NULL DEFAULT 0
  ,PRIMARY KEY(dcID)
);
--
