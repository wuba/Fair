package com.wuba.fair.thread;

import android.os.Handler;
import android.os.Looper;

import java.util.concurrent.Executor;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;

public class FairThread implements Executor {
    public static final Handler mHandler = new Handler(Looper.getMainLooper());

    public static boolean runOnUI(Runnable runnable) {
        return mHandler.post(runnable);
    }

    //保证单一线程存活
    private final ScheduledExecutorService service;

    public FairThread() {
        service = Executors.newSingleThreadScheduledExecutor();
    }

    public static class INSTANCE {
        public static final FairThread thread = new FairThread();
    }

    public static FairThread get() {
        return INSTANCE.thread;
    }

    public void run(Runnable runnable) {
        execute(runnable);
    }

    @Override
    public void execute(Runnable command) {
        service.execute(command);
    }
}
