package com.wuba.fair.jsexecutor;

import com.eclipsesource.v8.V8Object;

public abstract class JSExecutor implements IJSExecutor {
    protected V8Object v8Object;

    public V8Object getV8Object() {
        return v8Object;
    }
}
