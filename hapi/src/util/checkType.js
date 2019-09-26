module.exports = function isBoolean(a){
	let n = false;
	if(a == 0 || a ==1) n = true;
	if(a === true)  	n = true;
	if(a === false)  	n = true;
    return n;
};