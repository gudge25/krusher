// exports.register = (plugin, options, next) => {

//   plugin.route([
//     { method: 'GET', path: '/', config: Home.hello },
//     { method: 'GET', path: '/restricted', config: Home.restricted },
//     { method: 'GET', path: '/{path*}', config: Home.notFound }
//   ]);

//   next();
// };

// exports.register.attributes = {
//   name: 'api'
// };

// const path = require('path');
// const fs = require('fs');
// const _ = require('lodash');
// const pattern = /(?=Route)/g;
// fs.readdirSync(__dirname).forEach(file => {
//     /* If its the current file ignore it */
//     if (file === 'index.js')
//         return;
//     /* Prepare empty object to store module */
//     const mod = {};
//     const subdir = path.join(__dirname, file);
//     fs.readdirSync(subdir).forEach(file => {
//         if (file.search(pattern) < 0)
//             return;
//         mod[path.basename(file, '.js')] = require(path.join(subdir, file));
//     });
//     /* Extend module.exports (in this case - lodash.js, can be any other) */
//     _.extend(module.exports, mod);
// });
