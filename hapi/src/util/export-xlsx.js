module.exports = function exportXLSX(worksheets, cb)  {
  const fileName = 'uploads/export.xlsx';
  fs.exists('uploads', function(exists) {
    if (exists === false)
      fs.mkdirSync('uploads');
  });
  fs.stat(fileName, (err, stats) => {
    if (err) {
      try {
        json2xlsx.write(fileName, undefined, o);
        return cb(fileName);
      } catch (err) {
        return cb(err, null);
      }
    } else {
      fs.unlink(fileName, err => {
        if (err) return cb(err, null);
        json2xlsx.write(fileName, undefined, o);
        cb(fileName);
      });
    }
  });
}
