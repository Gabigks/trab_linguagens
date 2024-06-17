(function (x) {
	return function (y) {
		return console.log(x + y);
	};
})(2)(3);

(function (x) {
	return console.log(x === 1 ? x + 10 : x + 20);
})(2);
