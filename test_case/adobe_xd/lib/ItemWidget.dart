import 'package:fair/fair.dart';
import 'package:flutter/widgets.dart';

@FairBinding()//
class ItemWidget extends StatelessWidget {
  final String value;
  final String label;

  const ItemWidget({Key key, this.value, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.5, 0.5),
      child:
      // Adobe XD layer: 'group' (group)
      SizedBox(
        width: 85.0,
        height: 48.0,
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(16.5, 8.0),
              child:
              // Adobe XD layer: 'numbers' (text)
              SizedBox(
                width: 47.0,
                height: 20.0,
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 20,
                    color: const Color(0xff00a9de),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(16.5, 33.0),
              child:
              // Adobe XD layer: 'text' (text)
              SizedBox(
                width: 47.0,
                height: 11.0,
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 11,
                    color: const Color(0xffa2a2a2),
                    letterSpacing: 0.22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(83.0, 0.0),
              child: Container(
                width: 2.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: const Color(0xffececec),
                ),
              ),
            ),
            Container(
              width: 2.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: const Color(0xffececec),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
