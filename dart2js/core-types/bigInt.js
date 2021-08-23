/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
BigInt.one = 1;
BigInt.two = 2;
BigInt.zero = 0;

BigInt.from = function (num) {
  // 取整数部分
  return parseInt(num);
};

BigInt.parse = function (str) {
  // 只接受数字字符串，小数会报错
  if (str.indexOf(".") == -1 && !isNaN(Number(str))) {
    return BigInt(str);
  } else {
    throw "FormatException: Could not parse BigInt";
  }
};

BigInt.tryParse = function (str) {
  // 只接受数字字符串，小数会报错
  if (str.indexOf(".") == -1 && !isNaN(Number(str))) {
    return BigInt(str);
  } else {
    return null;
  }
};
global.BigInt = BigInt;
