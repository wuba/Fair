/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
package com.wuba.fair.channel;

import android.content.Context;

/**
 * so 文件加载
 */
public class LibraryLoader {

    public static boolean load(Context context, String lib) {
        System.loadLibrary(lib);
        return true;
    }

}
