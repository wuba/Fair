part of 'sample_logic_page.dart';

@FairProps()
var fairProps;

int _count = 0;

String getTitle() {
  return fairProps['pageName'];
}

void onTapText() {
  setData(fairProps['pageName'], {_count: _count++});
}
