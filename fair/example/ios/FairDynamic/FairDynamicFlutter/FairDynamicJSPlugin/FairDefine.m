//
//  FairDefine.m
//  FairDynamicJSPlugin
//
//  Created by 单鹏涛 on 2021/6/8.
//

#import "FairDefine.h"

NSString * const FairMessageChannelInjectionID = @"com.wuba.fair/js_loader";

NSString * const FairMessageChannelInjectionFunction = @"loadData";

NSString * const FairMessageChannelLoadJSFileType = @"loadJsFile";

NSString * const FairMessageChannelExecuteID = @"com.wuba.fair/common_message_channel";

NSString * const FairExecuteJSFunction = @"invokeJSFunc";

NSString * const FairMessageChannelMethodType = @"method";

//NSString * const FairSyncExecuteJSFunction = @"invokeJSFuncSync";

NSString * const FairJSThreadName = @"_FairJSThreadName_";

NSString * const FairUpdateDartFunction = @"setData";

NSString * const FairExecuteDartFunctionAsync = @"jsInvokeFlutterChannel";

NSString * const FairExecuteDartFunctionSync = @"jsInvokeFlutterChannelSync";

@implementation FairDefine

@end
