package com.wuba.fair;

import com.eclipsesource.v8.JavaCallback;
import com.eclipsesource.v8.V8;
import com.eclipsesource.v8.V8Array;
import com.eclipsesource.v8.V8Function;
import com.wuba.fair.constant.FairConstant;

import io.flutter.plugin.common.MethodChannel;

/**
 * 处理dart 发送的请求，用于加载js，释放js引擎等操作,完成操作之后
 * 通知dart侧更新
 */
public class FairApp {
    private MethodChannel methodChannel;

    public FairApp() {
        registerJSLoaderMessageChannel();
        initMethod();
    }

    /**
     * 注册本地方法到js中
     */
    public void registerMethod(JavaCallback callback, String jsFunctionName) {
        FairPlugin.get().getV8().registerJavaMethod(callback, jsFunctionName);
    }


    private void registerJSLoaderMessageChannel() {
        methodChannel = new MethodChannel(FairPlugin.get().getBinaryMessenger(),
                FairConstant.FLUTTER_LOADER_MESSAGE_CHANNEL);
        methodChannel.setMethodCallHandler(methodHandler);
    }


    private MethodChannel.MethodCallHandler methodHandler = (call, result) -> {
        switch (call.method) {
            case FairConstant.LOAD_MAIN_JS:
                FairPlugin.get().getJsExecutor().loadJS("用户的js文件", (r) -> {
                    result.success("success");
                });
                break;
            case FairConstant.RELEASE_MAIN_JS:
                FairPlugin.get().getJsExecutor().release();
                break;
            default:
                break;
        }
    };

    private void initMethod() {
        V8 v8 = FairPlugin.get().getV8();

        //js 同步调用,js会调用该注册的方法
        v8.registerJavaMethod((receiver, parameters) -> {
            String callJson = parameters.get(0).toString();
            return null;
        }, FairConstant.JS_INVOKE_FLUTTER_CHANNEL_SYNC);

        //异步调用,js会调用该注册的方法
        v8.registerJavaMethod((receiver, parameters) -> {
            String call = parameters.get(0).toString();
            V8Function callback = (V8Function) parameters.get(1);
            //通知消息到dart侧
            FairPlugin.get().getJsFlutterEngine().invokeFlutterChannel(call, (v) -> {
                V8Array v8Array = new V8Array(v8);
                v8Array.push(v);
                callback.call(FairPlugin.get().getV8Object(), v8Array);
            });

        }, FairConstant.JS_INVOKE_FLUTTER_CHANNEL);

    }

}

