module.exports = function toJSONLocal (date,isFull) {
  var local = new Date(date);
  local.setMinutes(date.getMinutes() - date.getTimezoneOffset());
  if (isFull === true) return local.toJSON().slice(0, 19);
  return local.toJSON().slice(0, 10);
};