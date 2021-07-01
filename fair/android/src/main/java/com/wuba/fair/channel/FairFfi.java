package com.wuba.fair.channel;

import com.wuba.fair.FairPlugin;
import com.wuba.fair.thread.FairTask;
import com.wuba.fair.thread.FairThread;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import androidx.annotation.Keep;

/**
 * dart ffi
 */
public class FairFfi {

    private boolean isSoLoadSuccess;

    public FairFfi() {
        isSoLoadSuccess = LibraryLoader
                .load(FairPlugin.get().getContext(), "fairflutter");
        if (isSoLoadSuccess) {
            init(this);
        }
    }

    /**
     * 释放native全局变量
     */
    public void onAppClose() {
        if (isSoLoadSuccess) {
            release();
        }
    }

    /**
     * native 调用
     */
    @Keep
    public String invokeJSCommonFuncSync(String args) {
        if (isSoLoadSuccess) {
            final Object[] result = new Object[1];
            //线程等待
            CountDownLatch countDownLatch = new CountDownLatch(1);
            FairThread.get().run(new FairTask() {
                @Override
                public void runTask() {
                    //获取js中的值
                    result[0] = FairPlugin.get().getJsExecutor().invokeJSChannel(args);
                    countDownLatch.countDown();
                }
            });

            try {
                countDownLatch.await(3, TimeUnit.SECONDS);
            } catch (Exception e) {
                e.printStackTrace();
                return " exception";
            }

            return result[0].toString();
        }

        return "jsAppObj is null";
    }

    private native void init(FairFfi ffi);

    private native void release();
}
