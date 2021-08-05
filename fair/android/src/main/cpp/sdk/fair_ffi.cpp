/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
#include <fair_ffi.h>
#include <fair_app.h>
#include <jni.h>
#include <android/log.h>
#include <jni_helper.h>

/// 同步属性回调
extern "C" JNIEXPORT __attribute__((used))
const char *invokeJSCommonFuncSync(char *args) {
  if (get_fair_ffi() != nullptr) {
    int attach = 0;
    JNIEnv *env = get_env(&attach);
    jclass clazz_fair_app = env->GetObjectClass(get_fair_ffi());
    jmethodID method_syncPropsCallback = env->GetMethodID(clazz_fair_app,
                                                          "invokeJSCommonFuncSync",
                                                          "(Ljava/lang/String;)Ljava/lang/String;");
    auto result = (jstring)env->CallObjectMethod(get_fair_ffi(),
                        method_syncPropsCallback,
                        env->NewStringUTF(args));
    const char *resultString = env->GetStringUTFChars(result, nullptr);
    if (attach == 1) {
      del_env();
    }
    return resultString;
  }
  return "Fair为空";
}
