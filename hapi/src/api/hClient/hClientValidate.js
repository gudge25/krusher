/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./hClientSchema');

function HClientValidate() {
}

HClientValidate.prototype = (() => {

    return {
        findPost: {
            payload: (() => new model().schemaFindPost())()
        },
    };
})();

const validate = new HClientValidate();
module.exports = validate;
