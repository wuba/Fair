class FairUrlLauncher {
   static makePhoneCall(params) {
      let requestParameter = {};
      requestParameter['className'] = "FairUrlLauncher#makePhoneCall";
      requestParameter['funcName'] = 'invokePlugin';
      requestParameter['args'] = params;
      requestParameter['pageName'] = '#FairKey#';
      let map = JSON.stringify(requestParameter);
      invokeFlutterCommonChannel(map, (resultStr) => {
      })
  }

  static sendSMS(params) {
        let paramsMap = {};
        if (params.phoneNumber) {
            paramsMap['phoneNumber'] = params.phoneNumber;
        }
        if (params.message) {
            paramsMap['message'] = params.message;
        }
        let requestParameter = {};
        requestParameter['className'] = "FairUrlLauncher#sendSMS";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = paramsMap;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }

  static sendMail(params) {
        let paramsMap = {};
        if (params.email) {
            paramsMap['email'] = params.email;
        }
        if (params.message) {
            paramsMap['message'] = params.message;
        }
        let requestParameter = {};
        requestParameter['className'] = "FairUrlLauncher#sendMail";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = paramsMap;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }

  static launchInBrowser(params) {
        let requestParameter = {};
        requestParameter['className'] = "FairUrlLauncher#launchInBrowser";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = params;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }

  static launchInWebViewOrVC(params) {
        let requestParameter = {};
        requestParameter['className'] = "FairUrlLauncher#launchInWebViewOrVC";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = params;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }

  static launchInWebViewWithoutJavaScript(params) {
        let requestParameter = {};
        requestParameter['className'] = "FairUrlLauncher#launchInWebViewWithoutJavaScript";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = params;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }

  static launchInWebViewWithoutDomStorage(params) {
        let requestParameter = {};
        requestParameter['className'] = "FairUrlLauncher#launchInWebViewWithoutDomStorage";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = params;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }

  static launchUniversalLinkIos(params) {
        let requestParameter = {};
        requestParameter['className'] = "FairUrlLauncher#launchUniversalLinkIos";
        requestParameter['funcName'] = 'invokePlugin';
        requestParameter['args'] = params;
        requestParameter['pageName'] = '#FairKey#';
        let map = JSON.stringify(requestParameter);
        invokeFlutterCommonChannel(map, (resultStr) => {
        })
    }
}