/*jshint node:true, esnext:true*/
'use strict';
var execPhp = require('exec-php');

class BaseScript {
  constructor(script) {
    this.script = script;
  }
  repoScript(params, callback) {
            try{
              execPhp(`${this.script.PHPexec}`, (error, php, output) => {
                  console.log(`=============PHP===============`);
                  console.log(php);
                  console.log(`=============PHP output===============`);
                  console.log(output);
                  if(php) php.quit();
                  //return callback(error, output);
              });
            } catch (err){
                  return callback(err, null);
            }

            return callback(false, `OK`);
  }
}

module.exports = BaseScript;