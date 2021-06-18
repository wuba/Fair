package com.wuba.fair.logger;


import io.flutter.Log;
import io.flutter.plugins.urllauncher.BuildConfig;

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
            Log.d(TAG, msg);
        }
    }

    public static void e(String TAG, String msg) {
        if (isDebug) {
            Log.d(TAG, msg);
        }
    }

    public static void w(String TAG, String msg) {
        if (isDebug) {
            Log.d(TAG, msg);
        }
    }

}
