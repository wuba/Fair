/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
require("./number.js");

function testNumberExtend() {
  // 绝对值
  console.log((-1).abs());
  // 向上取整
  // var a = 1.2;
  console.log((1.2).ceil());

  // 向上取浮点整
  console.log((1.2).ceilToDouble());

  // 设置最大最小值区间
  console.log((32).clamp(1, 50));

  // 比大小 -1 or 1
  console.log((32).compareTo(40));

  // 向下取整
  console.log((1.35).floor());
  // 向下取整转浮点
  console.log((1.35).floorToDouble());
  // 取余
  console.log((4).remainder(3));

  // 四舍五入
  console.log((4.5).round());

  // 四舍五入转浮点
  console.log((4.5).roundToDouble());

  // 转浮点
  console.log((4).toDouble());

  // 取整
  console.log((-11.92).toInt());

  // 转科学记数法
  console.log((12).toStringAsExponential(2));

  // 保留几位小数后精确结果的字符串
  console.log((2.5333).toStringAsPrecision(8));

  // 取整 与toInt啥区别？
  console.log((-11.92).truncate());

  // 取整返浮点
  console.log((3.9112).truncateToDouble());

  console.log(Number.tryParse("-29.22"));
  console.log(
    Number.tryParse("237462836487263478235472364782364827648632784628364")
  );
  console.log(Number.parse("2"));

  console.log((13).isEven);
  console.log((13).isOdd);
  console.log((0).sign);

  console.log((45).isFinite);

  console.log((45).isInfinite);

  console.log((23).isNaN);

  console.log((12.1).runtimeType);
}

testNumberExtend();
