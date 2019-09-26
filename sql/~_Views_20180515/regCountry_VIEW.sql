DROP VIEW IF EXISTS regCountry;
CREATE VIEW regCountry as
SELECT
  `reg_country`.`countryID`         `rcID`
  , `reg_country`.`countryName`     `rcName`
  , `reg_country`.`countryCode`     `rcCode`
  , `reg_country`.`countryShort`    `rcShort`
  , `reg_country`.`LenNumber`       `LenNumber`
  , `reg_country`.`countryNameEng`  `rcNameEng`
  , `reg_country`.`isCIS`           `isCIS`
FROM `reg_country`;
--
