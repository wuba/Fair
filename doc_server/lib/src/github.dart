/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:io';
import 'dart:math';

import 'package:io/io.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'config.dart';
import 'git.dart' as git;
import 'state.dart';

var _syncState = State.IDLE;
var _retryCount = 0;
const _maxRetryCount = 3;

Middleware webHook() {
  var app = _router();
  return (Handler innerHandler) => (request) =>
      request.url.path.startsWith('github')
          ? app.handler(request)
          : innerHandler(request);
}

Router _router() {
  var app = Router();

  // github hook
  var handler = (Request request) {
    _pending(request)
        .then((run) => run ? _syncRepo() : Future.value(State.SKIP))
        .then((value) {
      if (value == State.PENDING) {
        print('pending sync...');
        _syncRepo();
      } else if (value == State.SKIP) {
        print('enqueue sync...');
      }
    }).catchError((e) {
      _syncState = State.FAILED;
      _retrySync();
    });
    return Response.ok('WebHook received');
  };
  // test only
  app.get('/github', handler);
  // github event
  app.post('/github', handler);
  return app;
}

void _retrySync() {
  if (_retryCount < _maxRetryCount) {
    _retryCount++;
    var seconds = 1 + pow(2, _retryCount);
    print('retry sync after $seconds s');
    Future.delayed(Duration(seconds: seconds))
        .then((value) => _syncRepo())
        .catchError((e) {
      _retrySync();
    });
  }
}

Future<bool> _pending(Request request) async {
  // skip any pending requests
  if (_syncState == State.PENDING) {
    _syncState = State.PENDING;
    return false;
  }
  // enqueue new pending request
  if (_syncState == State.RUNNING) {
    _syncState = State.PENDING;
    return false;
  }
  // otherwise sync now
  return true;
}

Future<State> _syncRepo() async {
  _syncState = State.RUNNING;

  print('start sync repo of $user/$repo');
  var dir = Directory.systemTemp.createTempSync();
  var appendix = DateTime.now().millisecondsSinceEpoch;
  var temp = '${dir.path}/$repo-$branch-$appendix';
  await git.clone('https://github.com/$user/$repo.git', temp);
  await copyPath(temp, 'public');
  // remove .git folder
  await File('public/.git/').delete(recursive: true);
  await File(temp).delete(recursive: true);
  print('complete sync repo of $user/$repo');
  _syncState = _syncState == State.RUNNING ? State.SUCCESS : _syncState;
  return _syncState;
}
