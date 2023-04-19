class FairLog {
   static log(params) {
      let requestParameter = {};
      requestParameter['className'] = "FairLog#log";
      requestParameter['funcName'] = 'invokePlugin';
      requestParameter['args'] = params;
      requestParameter['pageName'] = '#FairKey#';
      let map = JSON.stringify(requestParameter);
      invokeFlutterCommonChannel(map, (resultStr) => {
      })
  }
}