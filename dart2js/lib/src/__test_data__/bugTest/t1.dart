import '../../convertorV2.dart';

String a = convertClassString('''

class _HotelListViewState extends State<HotelListView> {
  @FairProps()
  var fairProps;
}
    ''');

void main() {
  print(a);
}