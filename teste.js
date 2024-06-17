//exemplo 1
(function (x) {
	return x === 1 ? x + 10 : x + 20;
})(2);

//exemplo 2
(function (x) {
	return function (y) {
		return x + y;
	};
})(2)(3);

//exemplo 3
(function (x) {
	return x === 0 ? 10 : x + 20;
})(0);

//exemplo 4
(function (x) {
	return x === 0 ? 10 : x + 20;
})(5);

//exemplo 5
(function (x) {
	return function (y) {
		console.log(x && y);
	};
})(true)(false);

//exemplo 6
(function (x) {
	return function (y) {
		return x ? y : false;
	};
})(true)(true);

//exemplo 7
(function (x) {
	return function (y) {
		return x === y ? x + y : x + y + 1;
	};
})(2)(2);

//exemplo 8
(function (x) {
	return function (y) {
		return function (z) {
			console.log(x + y === z ? true : false);
		};
	};
})(3)(2)(5);
