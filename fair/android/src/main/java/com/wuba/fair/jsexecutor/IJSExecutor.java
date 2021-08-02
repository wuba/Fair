/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
package com.wuba.fair.jsexecutor;

import com.wuba.fair.callback.JsResultCallback;

/**
 * 需要js处理的动作
 */
public interface IJSExecutor {

    void init();

    /**
     * 释放 js引擎，目前Android端采用的是google的v8引擎
     */
    void release();

    /**
     * 加载本地js文件，该文件可能是assert目录下的文件或者是用户下载的文件存储在
     * 缓存中的文件地址
     *
     * @param js       文件地址
     * @param complete 加载结果的回调
     */
    void loadJS(String name, String js, JsResultCallback<String> complete);

    /**
     * 执行js的操作，这个操作包括获取js侧变量、方法、js脚本结果等，
     * js侧只通过一个方法分发其它操作
     *
     * @param src js侧需要的参数，一般是一个json格式的字符串
     * @return 结果
     */
    Object invokeJSChannel(Object src);

    /**
     * 释放指定的js文件资源
     */
    void releaseV8Object(String pageName);

}
