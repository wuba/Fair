part of 'sample_logic_page.dart';

final String _platform = 'Fair v$fairVersion';

int _count = 0;

void onTapText() {
  setData({_count++});
}

String getShowText() {
  return 'Running with , click count = ';
}


void setData(Set<int> set) {}
