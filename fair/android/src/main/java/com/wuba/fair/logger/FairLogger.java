/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
package com.wuba.fair.logger;


import io.flutter.Log;
import com.wuba.fair.BuildConfig;

public class FairLogger {
    public static boolean isDebug = BuildConfig.DEBUG;
    public static final String TAG = "FairLog";

    public static void d(String msg) {
        if (isDebug) {
            Log.d(TAG, msg);
        }
    }

    public static void d(String TAG, String msg) {
        if (isDebug) {
            Log.d(TAG, msg);
        }
    }

    public static void i(String TAG, String msg) {
        if (isDebug) {
            Log.i(TAG, msg);
        }
    }

    public static void e(String TAG, String msg) {
        if (isDebug) {
            Log.e(TAG, msg);
        }
    }

    public static void w(String TAG, String msg) {
        if (isDebug) {
            Log.w(TAG, msg);
        }
    }

}
