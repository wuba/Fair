package com.wuba.fair;

import android.content.Context;

import androidx.annotation.NonNull;

import com.wuba.fair.channel.FairFfi;
import com.wuba.fair.core.FairJsEngineProvider;
import com.wuba.fair.core.FairJsFlutterEngine;
import com.wuba.fair.core.base.FairJsLoader;
import com.wuba.fair.core.event.FairMessageEvent;
import com.wuba.fair.jsexecutor.JSExecutor;
import com.wuba.fair.thread.FairTask;
import com.wuba.fair.thread.FairThread;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;

public class FairPlugin2 implements FlutterPlugin {
    private static FairPlugin2 plugin;
    private volatile JSExecutor jsExecutor;
    private volatile FairJsLoader jsLoader;
    private BinaryMessenger binaryMessenger;
    private FairMessageEvent event;
    private Context mContext;
    private FairJsFlutterEngine engine;
    private FairFfi fairFfi;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        mContext = binding.getApplicationContext();
        plugin = this;
        binaryMessenger = binding.getBinaryMessenger();
        fairFfi=new FairFfi();
        CountDownLatch countDownLatch = new CountDownLatch(1);
        //等待js引擎加载成功
        FairThread.get().execute(new FairTask() {
            @Override
            public void runTask() {
                //初始化js引擎
                if (jsExecutor == null) {
                    jsExecutor = FairJsEngineProvider.createJsExecutor(FairJsEngineProvider.V8);
                }

                if (jsLoader == null) {
                    jsLoader = FairJsEngineProvider.createJsLoader(FairJsEngineProvider.V8);
                }

                if (engine == null) {
                    engine = new FairJsFlutterEngine();
                }
                countDownLatch.countDown();

            }
        });

        try {
            countDownLatch.await(5, TimeUnit.SECONDS);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (jsLoader != null) {
            jsLoader.release();
        }
    }

    public BinaryMessenger getBinaryMessenger() {
        return binaryMessenger;
    }

    public static FairPlugin2 get() {
        return plugin;
    }

    public JSExecutor getJsExecutor() {
        return jsExecutor;
    }

    public Context getContext() {
        return mContext;
    }

    public FairJsFlutterEngine getJsFlutterEngine() {
        return engine;
    }
}
