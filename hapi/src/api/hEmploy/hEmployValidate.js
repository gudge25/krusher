/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./hEmploySchema');

function HEmployValidate() {
}

HEmployValidate.prototype = (() => {

    return {
        findPost: {
            payload: (() => new model().schemaFindPost())()
        },
    };
})();

const validate = new HEmployValidate();
module.exports = validate;
