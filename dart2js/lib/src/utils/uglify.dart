String uglify(String str) {
  // 不用处理注释
  var buf = StringBuffer();
  var isInString = false;
  var lastCh = '';
  void writeCh(String s) {
    buf.write(s);
    lastCh = s;
    assert(!(s == '\r' || s == '\n'));
  }

  for (var i = 0; i < str.length; i++) {
    if (isInString) {
      writeCh(str[i]);
      if ((str[i] == '\'' || str[i] == '"' || str[i] == '`') &&
          (i < 1 || str[i - 1] != '\\')) {
        isInString = false;
      }
    } else {
      if ((str[i] == '\'' || str[i] == '"' || str[i] == '`') &&
          (str[i - 1] != '\\')) {
        isInString = true;
        writeCh(str[i]);
      } else {
        if (str[i] == '\r' || str[i] == '\n') {
          continue;
        } else if (str[i] == ' ') {
          do {
            i++;
          } while (i < str.length && str[i] == ' ');
          if (buf.isNotEmpty) {
            if (i < str.length) {
              var pat = RegExp(r'^[a-zA-Z_\d]$');
              if (pat.hasMatch(lastCh) && pat.hasMatch(str[i])) {
                writeCh(' ');
              }
              i--;
            } else {
              break;
            }
          } else {
            if (i < str.length) {
              i--;
            } else {
              break;
            }
          }
        } else {
          writeCh(str[i]);
        }
      }
    }
  }
  return buf.toString();
}
