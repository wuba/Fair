package com.wuba.fair;

import com.eclipsesource.v8.JavaCallback;
import com.eclipsesource.v8.V8;
import com.eclipsesource.v8.V8Array;
import com.eclipsesource.v8.V8Function;
import com.eclipsesource.v8.V8Object;
import com.wuba.fair.constant.FairConstant;
import com.wuba.fair.logger.FairLogger;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

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
                try {
                    FairLogger.d("用户的js文件地址" + call.arguments);
                    JSONObject jsonObject = new JSONObject(String.valueOf(call.arguments));
                    String jsLocalPath = jsonObject.getString("path");
                    String jsName = jsonObject.getString("pageName");
                    FairPlugin.get().getJsExecutor().loadJS(jsName, jsLocalPath, (r) -> {
                        result.success("success");
                    });
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case FairConstant.RELEASE_MAIN_JS:
                try {
                    JSONObject jsonObject = new JSONObject(String.valueOf(call.arguments));
                    String pageName = jsonObject.getString("pageName");
                    FairPlugin.get().getJsExecutor().releaseV8Object(pageName);
                } catch (Exception e) {
                    e.printStackTrace();
                }

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
                //todo 指定的v8object
                callback.call(FairPlugin.get().getV8Object(""), v8Array);
            });

        }, FairConstant.JS_INVOKE_FLUTTER_CHANNEL);


        //setData
        v8.registerJavaMethod((receiver, parameters) -> {
            V8Object call = (V8Object) parameters.get(0);
            String[] keys = call.getKeys();

            Map<Object, Object> obj = new HashMap<>();
            for (String key : keys) {
                Object vObject = call.get(key);
                obj.put(key, vObject);
            }

            JSONObject jsonObject = new JSONObject(obj);

            //通知消息到dart侧
            FairPlugin.get().getJsFlutterEngine().invokeFlutterChannel(jsonObject.toString(), (v) -> {

            });

        }, FairConstant.SET_DATA);

    }

}

