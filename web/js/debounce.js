function debounce(func, wait, immediate) {
  let timeout;
  wait = wait ? wait : 500;
  //console.dir(func);
  return function(...args) {
  	//console.dir(args);
    clearTimeout(timeout);
    timeout = setTimeout(() => {
      timeout = null;
      if (!immediate) func.apply(this, args);
    }, wait);
    if (immediate && !timeout) func.apply(this, [...args]);
  };
}

// function debounce(func, wait) {
//   let timeout
//   return function(...args) {
//     const context = this
//     clearTimeout(timeout)
//     timeout = setTimeout(() => func.apply(context, args), wait)
//   }
// }

// Returns a function, that, as long as it continues to be invoked, will not
// be triggered. The function will be called after it stops being called for
// N milliseconds. If `immediate` is passed, trigger the function on the
// leading edge, instead of the trailing.
// function debounce(func, wait, immediate) {
// 	var timeout;
// 	wait = wait ? wait : 1500;
// 	console.dir(func);
// 	return function() {
// 		var context = this, args = arguments;

// 		console.dir(args);

// 		var later = function() {
// 			timeout = null;
// 			if (!immediate) func.apply(context, args);
// 		};
// 		var callNow = immediate && !timeout;
// 		clearTimeout(timeout);
// 		timeout = setTimeout(later, wait);
// 		if (callNow) func.apply(context, args);
// 	};
// }