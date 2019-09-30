import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_derp/common/common.dart';
import 'package:flutter_derp/util/log_util.dart';
import 'package:rxdart/rxdart.dart';
import 'base_entity.dart';
import 'error_handle.dart';
import 'intercept.dart';

class DioUtils {
  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal() {
    var options = BaseOptions(
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.plain,
      validateStatus: (status) {
        return true;
      },
      baseUrl: "https://api/github.com/"
    );
    _dio = Dio(options);

    // 统一添加身份验证请求头
    _dio.interceptors.add(AuthInterceptor());

    // 刷新token
    //_dio.interceptors.add(TokenInterceptor());

    // 打印log， 开发模式
    if (!Contant.inProduction) {
      //_dio.interceptors.add(LoggingInterceptor());
    }

    // 适配数据
    //_dio.interceptors.add(AdapterInterceptor());
  }

  Future<BaseEntity<T>> _request<T>(String method, String url, {
    dynamic data, Map<String, dynamic> queryParameters,
    CancelToken cancelToken, Options options
  }) async {
    var response = await _dio.request(url, data: data, queryParameters: queryParameters, options: _checkOptions(method, options), cancelToken: cancelToken);
    
    try {
      Map<String, dynamic> _map = Contant.isTest ? parseData(response.data.toString()) : await compute(parseData, response.data.toString());

      return BaseEntity.formJson(_map);
    } catch(e) {
      return e;
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future requestNetwork<T>(Method method, String url, {
    Function(T t) onSuccess,
    Function(List<T> list) onSuccessList,
    Function(int code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters,
    CancelToken cancelToken, Options options, bool isList: false
  }) async {
    String m = _getRequestMethod(method);
    return await _request<T>(m, url, data: params, queryParameters: queryParameters, options: options, cancelToken: cancelToken).then((BaseEntity<T> result) {
      if (result.code == 0) {
        if (isList) {
          onSuccessList(result.data);
        } else {
          if (onSuccess != null) {
            onSuccess(result.data);
          }
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  // 统一处理(onSuccess返回T对象，onSeccessList返回List<T>)
  asyncRequestNetwork<T>(Method method, String url, {
    Function(T t) onSuccess,
    Function(List<T> list) onSuccessList,
    Function(int code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters,
    CancelToken cancelToken, Options options, bool isList: false
  }) {
    String m = _getRequestMethod(method);
    Observable.fromFuture(_request<T>(m, url, data: params, queryParameters: queryParameters, options: options, cancelToken: cancelToken))
      .asBroadcastStream()
      .listen((result) {
        if (result.code == 0) {
          if (isList) {
            if (onSuccessList != null) {
              onSuccessList(result.listData);
            }
          } else {
            if (onSuccess != null) {
              onSuccess(result.data);
            }
          }
        } else {
          _onError(result.code, result.message, onError);
        }
      }, onError: (e) {
        _cancelLogPrint(e, url) {
          NetError error = ExceptionHandle.handleException(e);
          _onError(error.code, error.msg, onError);
        }
      });
  }

  _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.i("取消请求接口： $url");
    }
  }

  _onError(int code, String msg, Function(int code, String mag) onError){
    Log.e("接口请求异常： code: $code, mag: $msg");
    if (onError != null) {
      onError(code, msg);
    }
  }

  String _getRequestMethod(Method method) {
    String m;
    switch(method) {
      case Method.get:
        m = "GET";
        break;
      case Method.post:
        m = "POST";
        break;
      case Method.put:
        m = "PUT";
        break;
      case Method.patch:
        m = "PATCH";
        break;
      case Method.delete:
        m = "DELETE";
        break;
      case Method.head:
        m = "HEAD";
        break;
    }
    return m;
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data);
}

enum Method {
  get,
  post,
  put,
  delete,
  head,
  patch
}