package com.wuba.fair.logger;

import android.webkit.JavascriptInterface;

public class Console {

    @JavascriptInterface
    public void log(Object... args) {
        FairLogger.i("Console [INFO] ", (args == null ? "" : args[0].toString()));
    }

    @JavascriptInterface
    public void error(Object... args) {
        FairLogger.e("Console [ERROR] ", (args == null ? "" : args[0].toString()));
    }

    @JavascriptInterface
    public void warn(Object... args) {
        FairLogger.w("Console [WARN] ", (args == null ? "" : args[0].toString()));
    }
}