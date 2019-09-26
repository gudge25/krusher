/*jshint node:true*/
'use strict';
const Joi = require('joi');
const db = require('src/middleware/db');

function UserDAO() {}
UserDAO.prototype = (() => {

    return {
        findUrl(loginName, password, url, cb) {
            const params = [
                `'${ loginName }'`,
                `'${ password }'`,
                `'${ url }'`
            ];
            const s = `call em_Auth(${ params.join() });`;
            //console.log(s);
            db.query({
                sql: s,
                callback: cb
            });
        }
    };
})();

const basicAuth = (request, username, password, callback) => {
    const userDAO = new UserDAO();
    userDAO.findUrl(username, password, request.info.host, (err, data) => {
        if (err) return callback(err.message, false);
        const credentials = data[0][0];
        const isValid = validate(credentials);
        db.setConn();
        callback(null, isValid, credentials);
    });
};

const validate = credentials => {
    credentials = credentials || {};
    const schema = {
        emID: Joi.number().integer().required(),
        loginName: Joi.string().required(),
        Token: Joi.string().required()
    };
    const err = Joi.validate(credentials, schema, {
        allowUnknown: true
    }).error;
    return err === null;
};

exports.register = (plugin, options, next) => {
    plugin.auth.strategy('simple', 'basic', {
        validateFunc: basicAuth,
        unauthorizedAttributes: true
    });
    plugin.auth.default('simple');
    next();
};

exports.register.attributes = {
    name: 'auth',
    dependencies: ['hapi-auth-basic']
};