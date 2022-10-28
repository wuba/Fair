String? addCommaAsNeeded(String? statement) {
  if (statement?.endsWith(';') == true) {
    return statement;
  }
  return (statement ?? '') + ';';
}