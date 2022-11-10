import '../../convertorV2.dart';

String a = convertFunction('''
void main(){
do {
  printLine();
} while (!atEndOfPage());

while (true) {
  if (shutDownRequested()) break;
  processIncomingRequests();
}

for (int i = 0; i < candidates.length; i++) {
  var candidate = candidates[i];
  if (candidate.yearsExperience < 5) {
    continue;
  }
  candidate.interview();
}

}
    ''');

void main() {
  print(a);
}
