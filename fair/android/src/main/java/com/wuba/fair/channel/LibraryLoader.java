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
