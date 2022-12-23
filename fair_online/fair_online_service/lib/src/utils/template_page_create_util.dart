
class TemplatePageCreateUtil {


  static String createFeedbackTemplatePage(String pageName, String projectName) {
    String pageState = "_" + pageName + "State";
    String pageStateReturn = "_" + pageName + "State()";
    var content = ''' 
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:$projectName/fair_preview_annotation.dart';

@FairPreviewPage()
@FairPatch()
class $pageName extends StatefulWidget {
  @override
  State createState() => $pageStateReturn;
}

class $pageState extends State<$pageName> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SizedBox(
              height: Sugar.height(context),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: Sugar.paddingTop(context), left: 16, right: 16),
                    child: Image.asset('assets/images/feedbackImage.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Your FeedBack',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'Give your best time for this moment.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              offset: const Offset(4, 4),
                              blurRadius: 8),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
                          color: Colors.white,
                          child: SingleChildScrollView(
                            padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                            child: TextField(
                              maxLines: null,
                              onChanged: (String txt) {},
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF313A44),
                              ),
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your feedback...'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: Sugar.requestFocus(context),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Send',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

    ''';
    return content;
  }
}