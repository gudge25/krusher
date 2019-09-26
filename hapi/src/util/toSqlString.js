/*jshint node:true, esnext:true*/
'use strict';
module.exports = (storedProc, params) => {
  let p, sql;
  sql = `call ${storedProc}(${p});`;
  return sql;
};

function escape(param) {
  let p;
  if (typeof param === `undefined`) {
    p = '';
  } else if (typeof param === `string`) {
    p = `'${param}'`;
  } else if (param instanceof Date) {
    p = `'${param.toISOString()}'`;
  } else {
    p = param;
  }
  return p;
}