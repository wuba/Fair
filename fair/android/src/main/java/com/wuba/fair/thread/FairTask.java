/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
package com.wuba.fair.thread;

import com.wuba.fair.logger.FairLogger;

public abstract class FairTask implements Runnable {

    @Override
    public void run() {

        runTask();

    }

    public abstract void runTask();
}
