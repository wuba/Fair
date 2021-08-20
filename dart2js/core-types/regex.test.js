/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

require("./regex");

function pre() {
  global.print = console.log.bind(console);
}

function run() {
  let re = RegExp(String.raw`quick\s(brown).+?(?<xg>jumps)`, {
    caseSensitive: false,
  });
  print(`
        ${re.pattern} ${re.isMultiLine} ${re.isCaseSensitive} ${re.isUnicode} ${re.isDotAll}
    `);
  print("\r\n");

  let result = re.firstMatch("The Quick Brown Fox Jumps Over The Lazy Dog");
  function printMatch(result) {
    print(`
            ${result.start} 
            ${result.end} 

            ${result.groupCount}
            ${result.group(0)}
            ${result.group(1)}
            ${result.group(2)}

            ${result.groupNames}
            ${result.namedGroup("xg")}
        `);
  }
  printMatch(result);

  print("\r\n");
  print(re.hasMatch("The Quick Brown Fox Jumps Over The Lazy Dog"));

  print("\r\n");
  let result1 = re.allMatches(
    "The Quick Brown Fox Jumps Over The Lazy Dog The Quick Brown Fox Jumps Over The Lazy Dog"
  );
  result1.forEach(printMatch);

  print("\r\n");
  let result2 = re.matchAsPrefix(
    "The Quick Brown Fox Jumps Over The Lazy Dog",
    4
  );
  printMatch(result2);

  print("\r\n");
  print(re.stringMatch("The Quick Brown Fox Jumps Over The Lazy Dog"));
}

pre();
run();
