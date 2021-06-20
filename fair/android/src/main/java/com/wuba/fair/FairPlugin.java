package com.wuba.fair;

import android.annotation.SuppressLint;
import android.content.Context;

import androidx.annotation.NonNull;

import com.eclipsesource.v8.V8;
import com.eclipsesource.v8.V8Object;
import com.wuba.fair.channel.FairFfi;
import com.wuba.fair.jsexecutor.JSExecutor;
import com.wuba.fair.v8.V8JSExecutor;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FairPlugin
 */
public class FairPlugin implements FlutterPlugin, MethodCallHandler {

    private V8 v8;
    private static JSExecutor mJSExecutor;
    private BinaryMessenger binaryMessenger;

    @SuppressLint("StaticFieldLeak")
    private static FairPlugin plugin;
    private JsFlutterEngine mJsFlutterEngine;
    private FairApp _FairApp;
    private Context mContext;
    private FairFfi fairFfi;

    public static FairPlugin get() {
        return plugin;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        mContext = flutterPluginBinding.getApplicationContext();
        plugin = this;
        binaryMessenger = flutterPluginBinding.getBinaryMessenger();

        if (v8 == null) {
            v8 = V8.createV8Runtime();
        }
        if (fairFfi==null) {
            fairFfi=new FairFfi();
        }

        if (mJSExecutor == null) {
            mJSExecutor = new V8JSExecutor();
        }

        if (mJsFlutterEngine == null) {
            mJsFlutterEngine = new JsFlutterEngine();
        }

        if (_FairApp == null) {
            _FairApp = new FairApp();
        }

    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    public V8 getV8() {
        return v8;
    }

    public BinaryMessenger getBinaryMessenger() {
        return binaryMessenger;
    }

    public JSExecutor getJsExecutor() {
        return mJSExecutor;
    }

    public JsFlutterEngine getJsFlutterEngine() {
        return mJsFlutterEngine;
    }

    public V8Object getV8Object() {
        return mJSExecutor.getV8Object();
    }

    public Context getContext() {
        return mContext;
    }
}
