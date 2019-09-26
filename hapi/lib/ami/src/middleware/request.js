const request = require('request');

module.exports = (options, callback) => {
    request(options, (error, response, body) => {
        if (error) {
            console.log(`error response`);
            console.log(error);
            return callback(error);
        }
        if (response.statusCode !== 200) {
            if(body){ console.log(`body in response`); console.log(body); }
            let mes = body ? body.message : null;
            return callback(mes);
        }
        return callback(null, body);
    });
};