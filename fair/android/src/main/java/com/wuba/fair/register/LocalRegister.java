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
