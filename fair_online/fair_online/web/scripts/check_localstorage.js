/**
 * Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */

// This function is used by lib/check_localstorage.dart
function checkLocalStorage() {
    try {
        let key = 'O09DGzSpoH';
        localStorage.setItem(key, 'test');
        localStorage.removeItem(key);
        return true;
    } catch(e) {
        return false;
    }
}
