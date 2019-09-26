"use strict";

/*jslint node: true */
var fs = require('fs');
var path = require('path');

var prc, pfx, Entity;

prc = process.argv[2];
pfx = process.argv[3];
Entity = process.argv[4];

//console.log(process.argv);
addCode(prc, pfx, Entity);

function addCode(prc, pfx, Entity) {
  if (prc === undefined || pfx === undefined || Entity === undefined) {
    throw new Error("Error argument");
  }
  var pathTmpl = path.join(__dirname, 'app/TemplatePrc/');
  var pathOut = path.join(__dirname, 'src/Code/');
  var fileTmpl = fs.readdirSync(pathTmpl);
  var dirOut = pathOut + '/' + prc + Entity;
  if (!fs.existsSync(dirOut)) {
    fs.mkdirSync(dirOut);
  }
  fileTmpl.forEach(function(fileName) {
    var name, sql, filePath;
    name = fileName.replace(/prc/g, prc);
    name = name.replace(/Entity/g, Entity);
    sql = fs.readFileSync(pathTmpl + fileName, 'utf8');
    sql = sql.replace(/prc/g, prc);
    sql = sql.replace(/pfx/g, pfx);
    sql = sql.replace(/Entity/g, Entity);
    filePath = path.join(dirOut, name);
    fs.writeFile(filePath, sql, function(err) {
        if (err) throw err;
        console.log(name + ' is saved!');
      }

    );
  });
}

//  return fileOut;
