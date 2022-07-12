/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
package com.wuba.fair;

import android.annotation.SuppressLint;
import android.content.Context;

import androidx.annotation.NonNull;

import com.wuba.fair.channel.FairFfi;
import com.wuba.fair.constant.FairConstant;
import com.wuba.fair.core.FairJsEngineProvider;
import com.wuba.fair.core.FairJsFlutterEngine;
import com.wuba.fair.core.base.FairJsLoader;
import com.wuba.fair.jsexecutor.JSExecutor;
import com.wuba.fair.logger.FairLogger;
import com.wuba.fair.thread.FairTask;
import com.wuba.fair.thread.FairThread;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class FairPlugin implements FlutterPlugin {
    @SuppressLint("StaticFieldLeak")
    private static FairPlugin plugin;
    private volatile JSExecutor jsExecutor;
    private volatile FairJsLoader jsLoader;
    private BinaryMessenger binaryMessenger;
    private Context mContext;
    private FairJsFlutterEngine engine;
    private FairFfi fairFfi;
    private MethodChannel basicChannel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        logSp();
        mContext = binding.getApplicationContext();
        plugin = this;
        basicChannel = MethodChannel(FairPlugin.get().getBinaryMessenger(), FairConstant.FLUTTER_BASIC_MESSAGE_CHANNEL);

        binaryMessenger = binding.getBinaryMessenger();
        fairFfi = new FairFfi();
        CountDownLatch countDownLatch = new CountDownLatch(1);
        //等待js引擎加载成功
        FairThread.get().run(new FairTask() {
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

                basicChannel.invokeMethod("jsInitSuccess", null, null);

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

    public static FairPlugin get() {
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

    public FairFfi getFairFFi() {
        return fairFfi;
    }

    private void logSp() {
        FairLogger.d("FairPlugin", "********FairPlugin********");
        FairLogger.d("FairPlugin", "*                        *");
        FairLogger.d("FairPlugin", "*     当前平台:Android    *");
        FairLogger.d("FairPlugin", "*                        *");
        FairLogger.d("FairPlugin", "********FairPlugin********");
    }
}
