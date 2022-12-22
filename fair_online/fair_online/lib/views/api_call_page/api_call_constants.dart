
///--------------常量 start-----------------///

//列表标题栏
const STABLE_TITLES = ['Name', 'Method', 'Url', 'Return Type'];


//get post
const METHOD_SELECTOR = ['Get', 'Post'];

//dart基本类型
const DART_TYPE_SELECTOR = ['String', 'int', 'double', 'bool'];


///--------------常量 end-----------------///



///--------------文本 start---------------///

//标题
const String API_CALL_TITLE ='API Call 配置';

//行为-公共header
const String BEHAVIOR_ADD_COMMON_HEADER ='添加公共Header';

//行为-添加api call
const String BEHAVIOR_ADD_API_CALL ='添加API Call';

//行为-添加api call
const String BEHAVIOR_API_CALL_ADD ='API Call添加';

//行为-导入json
const String BEHAVIOR_IMPORT_JSON ='从Json文件导入';

//行为-保存
const String BEHAVIOR_SAVE ='保存';
const String BEHAVIOR_ADD_PARAMS ='添加prams';

//功能提示
const String COMMON_FUNCTION_TIPS = '此功能暂未开放，敬请期待～';

//功能提示
const String COMMON_BEHAVIOR_ERROR_TIPS = '%sApiCall失败，请稍后再试~';

//空提示
const String COMMON_EMPTY_TIPS = '暂无ApiCall';

//空参数
const String COMMON_EMPTY_PARAMS_TIPS = '参数不能为空，请补充完整后添加~';

//无法识别的json
const String COMMON_UNKNOWN_JSON_TIPS = '无法识别的Json文件，请重新选择~';

const String API_NAME ='Name';
const String API_METHOD_TYPE ='Method Type';
const String API_URL='Url';
const String API_PARAMS_VALUE_TYPE='ValueType';
const String API_PARAMS_DEFAULT_VALUE='DefaultValue';

const String API_PARAMS_TITLE ='Request Params';


//json模版
const SAMPLE_JSON_TEMPLATE = '''
Json模版示例
{
   "name": "testApi",
   "method": "Post",
   "url": "https://api.58.com/v1/",
   "params": [
    {
     "key": "p1",
     "type": "String",
     "value": "111"
    },
    {
     "key": "p2",
     "type": "int",
     "value": "123"
    },
    {
     "key": "p3",
     "type": "double",
     "value": "0.1"
    }
   ]
  }
''';

///--------------文本 end---------------///