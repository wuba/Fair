package com.wuba.fair.core;

import android.text.TextUtils;

import com.eclipsesource.v8.V8;
import com.eclipsesource.v8.V8Array;
import com.eclipsesource.v8.V8Function;
import com.eclipsesource.v8.V8Object;
import com.wuba.fair.FairPlugin;
import com.wuba.fair.callback.JsResultCallback;
import com.wuba.fair.constant.Constant;
import com.wuba.fair.constant.FairConstant;
import com.wuba.fair.core.base.FairJsLoader;
import com.wuba.fair.logger.Console;
import com.wuba.fair.logger.FairLogger;
import com.wuba.fair.thread.FairTask;
import com.wuba.fair.thread.FairThread;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * 注册js端方法，js引擎的加载释放
 */
public class FairV8JsLoader extends FairJsLoader {

    public FairV8JsLoader() {
        super();
    }

    @Override
    public void registerJavaMethods(Object arguments) {
        /*
         * js 同步调用,js会调用该注册的方法
         */
        getV8().registerJavaMethod((receiver, parameters) -> {
            String callJson = parameters.get(0).toString();
            return null;
        }, FairConstant.JS_INVOKE_FLUTTER_CHANNEL_SYNC);

        /*
         * 异步调用,js会调用该注册的方法
         */
        getV8().registerJavaMethod((receiver, parameters) -> {
            String call = parameters.get(0).toString();
            V8Function callback = (V8Function) parameters.get(1);

            if (TextUtils.isEmpty(call)) {
                return;
            }

            final String[] r = {""};
            try {
                JSONObject jsonObject = new JSONObject(call);
                r[0] = jsonObject.getString(Constant.PAGE_NAME);
            } catch (JSONException e) {
                e.printStackTrace();
            }

            if (TextUtils.isEmpty(r[0]) && FairPlugin.get().getJsExecutor().getV8ObjectByName(r[0]) == null) {
                return;
            }
            /*
             * 获取flutter的结果成功之后，返回给js的回调函数
             */
            FairPlugin.get().getJsFlutterEngine().invokeFlutterChannel(call, (v) -> {
                FairThread.get().run(new FairTask() {
                    @Override
                    public void runTask() {
                        V8Array v8Array = new V8Array(getV8());
                        v8Array.push(v);

                        if (callback != null) {
                            callback.call(FairPlugin.get().getJsExecutor().getV8ObjectByName(r[0]), v8Array);
                        }
                    }
                });

            });

        }, FairConstant.JS_INVOKE_FLUTTER_CHANNEL);
    }

    @Override
    public void registerJavaClass(Object arguments) {
        //注册 console
        Console console = new Console();
        V8Object v8Console = new V8Object(getV8());
        getV8().add("console", v8Console);
        v8Console.registerJavaMethod(console, "log", "log", new Class[]{Object[].class});
        v8Console.registerJavaMethod(console, "error", "error", new Class[]{Object[].class});
        v8Console.registerJavaMethod(console, "warn", "warn", new Class[]{Object[].class});
    }

    @Override
    public void loadMainJs(Object arguments, JsResultCallback<String> callback) {
        try {
            FairLogger.d("用户的js文件地址" + arguments);
            JSONObject jsonObject = new JSONObject(String.valueOf(arguments));
            String jsLocalPath = jsonObject.getString("path");
            String jsName = jsonObject.getString("pageName");
            getV8JsExecutor().loadJS(jsName, jsLocalPath, callback);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void releaseJsObject(Object arguments) {
        FairThread.get().run(new FairTask() {
            @Override
            public void runTask() {
                getV8JsExecutor().releaseV8Object(String.valueOf(arguments));
            }
        });
    }

    @Override
    public void release() {
        FairThread.get().run(new FairTask() {
            @Override
            public void runTask() {
                getV8JsExecutor().release();
            }
        });
    }

    private V8 v8;

    private V8 getV8() {
        if (v8 == null) {
            v8 = getV8JsExecutor().getV8();
        }
        return v8;
    }

    private FairV8JsExecutor v8JsExecutor;

    private FairV8JsExecutor getV8JsExecutor() {
        if (v8JsExecutor == null) {
            v8JsExecutor = ((FairV8JsExecutor) FairPlugin.get().getJsExecutor());
        }
        return v8JsExecutor;
    }
}
