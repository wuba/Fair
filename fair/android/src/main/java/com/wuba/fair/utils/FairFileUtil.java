package com.wuba.fair.utils;

import android.text.TextUtils;

import androidx.annotation.Nullable;

import com.wuba.fair.constant.FairConstant;
import com.wuba.fair.logger.FairLogger;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

/**
 * 文件处理
 */
public class FairFileUtil {

    public static String getScript(String file) {
        if (TextUtils.isEmpty(file)) {
            throw new NullPointerException("文件路径不能为空");
        }

        if (file.startsWith(FairConstant.AndroidConfig.ASSERT)) {
            return null;
        }

        return getScriptFromPath(file);
    }

    /**
     * 获取本地的js文件
     */
    public static String getScriptFromPath(String path) {
        InputStream input = null;
        try {
            input = new FileInputStream(new File(path));
        } catch (FileNotFoundException e) {
            printError(e);
        }
        return getScript(input);
    }


    @Nullable
    private static String getScript(InputStream input) {
        if (input == null) {
            return null;
        }
        ByteArrayOutputStream output = null;
        try {
            output = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int len;
            while ((len = input.read(buffer)) != -1) {
                output.write(buffer, 0, len);
            }
            output.flush();
            return output.toString();
        } catch (IOException e) {
            printError(e);
        } finally {
            try {
                if (output != null) {
                    output.close();
                }
                input.close();
            } catch (IOException e) {
                printError(e);
            }
        }
        return null;
    }


    private static void printError(Exception e) {
        FairLogger.e("FairUtils", e.getMessage());
    }
}
