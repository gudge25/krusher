/*jshint node:true*/
'use strict';
const _ = require('lodash');
const Joi = require('joi');
const model = require('./astUpdateSchema');

function AstUpdateValidate() {}
AstUpdateValidate.prototype = (() => {
    return {
        PHPexec: {
            payload: (() => new model().scheme )()
        },
    };
})();
const validate = new AstUpdateValidate();
module.exports = validate;
