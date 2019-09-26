/*jshint node:true*/
'use strict';
const util = require('util');
const Joi = require('joi');
const Model = require('src/base/BaseModel');
const BaseScript = require('src/base/BaseScript');

class AstUpdateModel extends BaseScript {
    constructor() {
        const storedScript = {
             PHPexec: `/usr/src/KRUSHER/Asterisk/scripts/sync/start.php`
        };
        super(storedScript);
        this.PHPexec   = PHPexec;
    }
}

class PHPexec extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.script =        p.script;
    }
}

const model = new AstUpdateModel();
module.exports = model;