'use strict';
exports.register = (plugin, options, next) => {

    plugin.ext({
        type: 'onRequest',
        method(request, reply) {

            request.plugins.createControllerParams = (requestParams, schema) => {
                let params = Object.assign({}, requestParams);
                let p = {};
                const login = request.auth.credentials ? request.auth.credentials.loginName : null;
                const emID = request.auth.credentials ? request.auth.credentials.emID : null;
                const host = request.info ? request.info.remoteAddress : null;
                const token = request.auth.credentials ? request.auth.credentials.Token : null;
                if(token)
                    p = { token: token };
                if (schema)
                {
                    for (const key in schema)
                    {
                        if(params[key] == 'NULL' || params[key] == 'null') params[key] = null;
                        p[key] = params[key] !== undefined ? params[key] : null;
                    }
                }
                else
                {
                    for (var key in params)
                    {
                        if(params[key] == 'NULL' || params[key] == 'null') params[key] = null;
                        p[key] = params[key] !== undefined ? params[key] : null;
                    }
                }
                const result = {
                    params: p,
                    loginName: login,
                    emIDEditor: emID,
                    host: host,
                    token: token
                };
                return result;
            };
            return reply.continue();
        }
    });

    next();
};

exports.register.attributes = {
    name: 'onRequest'
};