# Navigation with parameters

## 使用场景
    支持多个动态界面的跳转，以及界面直接的值传递

## 预置动态公共载体
    在main.dart的routes内添加公共跳转路径：
    'fair_page': (context) => FairWidget(
              name: _getParams(context, 'name'),
              path: _getParams(context, 'path'),
              data: {'fairProps': jsonEncode(_getParams(context, 'data'))}),    

## 跳转与传值

    Navigator.pushNamed(context, 'fair_page',
        arguments: {
            'name': '逻辑动态界面跳转&传值',   // 动态界面title
            'path': 'assets/bundle/lib_src_page_logic-page2page_sample_logic_page2page.fair.json',  // 界面内容数据
            'data': {'pageName': '逻辑动态界面跳转&传值'} // 界面传递的参数，不需传递需要写为'data': {}
        }
    );
    