'use strict';
const _ = require('lodash');
exports.capitalize = function (string) {
    const capitalized = string.replace(/^./g, (char, pos) => {
        return char.toUpperCase();
    });
    return capitalized.replace(/\-(.)/g, (_, char) => {
        return char.toUpperCase();
    });
};
