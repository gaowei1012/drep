import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_derp/common/common.dart';

class Log {
  static var perform;

  static init() {
    if (perform == null) {
      perform = const MethodCall("x_log");
    }
  }

  static d(String msg, { tag: "X-LOG" }) {
    if (!Contant.inProduction) {
      perform?.invokeMethod('logD', {'tag': tag, 'msg': msg});
      _print(msg, tag: tag);
    }
  }

  static w(String msg, { tag: 'X-LOG' }) {
    if (!Contant.inProduction) {
      perform?.invokeMethod('logW', { 'tag': tag, 'msg': msg });
      _print(msg, tag: tag);
    }
  }

  static i(String msg, { tag: 'x-LOG'}) {
    if (!Contant.inProduction) {
      perform?.invokeMethod('logI', { 'tag': tag, 'msg': msg });
      _print(msg, tag: tag);
    }
  }

  static e(String msg, { tag: 'X-LOG' }) {
    if (!Contant.inProduction) {
      perform?.invokeMethod('logE', { 'tag': tag, 'msg': msg });
      _print(msg, tag: tag);
    }
  }

  static json(String msg, { tag: 'X-LOG' }) {
    if (!Contant.inProduction) {
      perform?.invokeMethod('logJSON', { 'tag': tag, 'msg': msg });
      _print(msg, tag: tag);
    }
  }

  static _print(String msg, { tag: 'X-LOG' }) {
    if (defaultTargetPlatform == TargetPlatform.iOS || perform == null) {
      LogUtil.debuggable = !Contant.inProduction;
      LogUtil.v(msg, tag: tag);
    }
  }
}