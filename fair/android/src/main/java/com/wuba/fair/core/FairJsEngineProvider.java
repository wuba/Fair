/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
package com.wuba.fair.core;

import com.wuba.fair.core.base.FairJsLoader;
import com.wuba.fair.jsexecutor.JSExecutor;

/**
 * 配置用户需要使用的js引擎
 */
public class FairJsEngineProvider {

    public static final String V8 = "V8";
    public static final String INNER = "INNER";

    public static JSExecutor createJsExecutor(String jsType) {
        switch (jsType) {
            case V8:
                return new FairV8JsExecutor();
            case INNER:
            default:
                return null;
        }
    }

    public static FairJsLoader createJsLoader(String jsType) {
        switch (jsType) {
            case V8:
                return new FairV8JsLoader();
            case INNER:
            default:
                return null;
        }
    }
}
