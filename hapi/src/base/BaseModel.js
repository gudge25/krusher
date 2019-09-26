/*jshint node:true, esnext:true*/
'use strict';
const AbstractEntity = require('./AbstractEntity');
//const util = require('util');
const toJSONLocal = require(`src/util/toJSONLocal`);
const _ = require('lodash');

class Get extends AbstractEntity {
  constructor(p) {
    const d = {};
    _.extend(d, p);
      //console.log(p);
    /*d.CreatedAt = d.CreatedAt ? toJSONLocal(d.CreatedAt, true) : d.CreatedAt;
    d.EditedAt = d.EditedAt ? toJSONLocal(d.EditedAt, true) : d.EditedAt;*/
    //console.log(d);
    super(d);
     // console.log(d);
  }
}
class Post extends AbstractEntity {
  constructor(p) {
    const data = {};
    super(data);
  }
}
class Put extends AbstractEntity {
  constructor(p) {
    const data = {
      HIID: p.HIID
    };
    super(data);
  }
}
module.exports = {
  Get: Get,
  Post: Post,
  Put: Put
};
