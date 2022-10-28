String removeCommaAsNeeded(String statement) {
  if (!statement.endsWith(';')) {
    return statement;
  }
  return statement.substring(0, statement.lastIndexOf(';'));
}