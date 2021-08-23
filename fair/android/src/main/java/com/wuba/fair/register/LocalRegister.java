/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
package com.wuba.fair.register;

import java.util.concurrent.ConcurrentHashMap;

public class LocalRegister {
    private static LocalRegister localRegister;

    private LocalRegister() {
    }

    public final ConcurrentHashMap<String, ILocalRegister> map = new ConcurrentHashMap<>();

    public static LocalRegister getInstance() {
        localRegister = new LocalRegister();
        return localRegister;
    }

    public ILocalRegister get(String key) {
        return map.get(key);
    }

    public void put(String key, ILocalRegister value) {
        map.put(key, value);
    }


}
