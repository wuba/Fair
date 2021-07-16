part of 'sample_logic_page.dart';

@FairProps()
var fairProps;

final String _platform = 'Fair v$fairVersion';

int _count = 0;

String getTitle() {
  return fairProps['pageName'];
}

void onTapText() {
  setData({_count++});
}

void setData(Set<int> set) {}
