/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
package com.wuba.fair.core.base;

import com.wuba.fair.FairPlugin;
import com.wuba.fair.callback.JsResultCallback;
import com.wuba.fair.constant.FairConstant;
import com.wuba.fair.thread.FairTask;
import com.wuba.fair.thread.FairThread;

import io.flutter.plugin.common.MethodChannel;

public abstract class FairJsLoader {
    private MethodChannel methodChannel;

    public FairJsLoader() {
        registerJavaMethods(null);
        registerJavaClass(null);
        loadMsgChannel();
    }

    private void loadMsgChannel() {
        methodChannel = new MethodChannel(FairPlugin.get().getBinaryMessenger(),
                FairConstant.FLUTTER_LOADER_MESSAGE_CHANNEL);
        methodChannel.setMethodCallHandler(methodHandler);
    }

    private MethodChannel.MethodCallHandler methodHandler = (call, result) -> {
        FairThread.runOnUI(() -> {
            switch (call.method) {
                case FairConstant.LOAD_MAIN_JS:
                    FairThread.get().run(new FairTask() {
                        @Override
                        public void runTask() {
                            loadMainJs(call.arguments, s -> {
                                FairThread.runOnUI(new Runnable() {
                                    @Override
                                    public void run() {
                                        result.success(s);
                                    }
                                });
                            });
                        }
                    });
                    break;
                case FairConstant.RELEASE_MAIN_JS:
                    FairThread.get().run(new FairTask() {
                        @Override
                        public void runTask() {
                            releaseJsObject(call.arguments);
                        }
                    });
                    break;
                default:
                    break;
            }
        });
    };

    public MethodChannel.MethodCallHandler getMethodHandler() {
        return methodHandler;
    }


    public abstract void registerJavaMethods(Object arguments);

    public abstract void registerJavaClass(Object arguments);

    public abstract void loadMainJs(Object arguments, JsResultCallback<String> callback);

    public abstract void releaseJsObject(Object arguments);

    public abstract void release();

}

