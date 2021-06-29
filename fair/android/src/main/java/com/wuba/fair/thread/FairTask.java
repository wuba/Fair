package com.wuba.fair.thread;

import com.wuba.fair.logger.FairLogger;

public abstract class FairTask implements Runnable {

    @Override
    public void run() {
        FairLogger.d("当前的线程名称" + Thread.currentThread());

        runTask();

    }

    public abstract void runTask();
}
