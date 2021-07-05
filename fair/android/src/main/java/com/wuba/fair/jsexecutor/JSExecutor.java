package com.wuba.fair.jsexecutor;

import com.eclipsesource.v8.V8Object;

import java.util.HashMap;
import java.util.Map;

public abstract class JSExecutor implements IJSExecutor {

    //用于暂存dart对应js生成的对象，用于资源的释放，适用于V8引擎
    protected final Map<String, V8Object> v8ObjectMap = new HashMap<>();

    public V8Object getV8ObjectByName(String pageName) {
        return v8ObjectMap.get(pageName);
    }
}
