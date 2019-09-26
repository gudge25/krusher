'use strict';

const externals = {};

exports.create = (err,data) => {
  if (err) return;
  this.emmit('create-contact',data);
};

module.exports = externals;