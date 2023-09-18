// Copyright 2023 MEtaspook. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:developer' show log;

import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;
import 'package:flutter/services.dart' show PlatformException;

/// {@template connectivator}
/// Network connectivity checker.
/// {@endtemplate}
class Connectivator {
  /// {@macro connectivator}
  const Connectivator();

  //-- Config
  static final _connectivity = Connectivity();
  static String? _statusMsg;
  static const _errorMsg = "Couldn't fetch the connectivity result!";

  //-- Parse connectivity result.
  bool _parseConnectivityResult(ConnectivityResult connectivityResult) {
    if (connectivityResult
        case ConnectivityResult.wifi ||
            ConnectivityResult.mobile ||
            ConnectivityResult.vpn) {
      _statusMsg = 'Connected to the internet!';
      return true;
    }
    _statusMsg = 'Not connected to the internet!';
    return false;
  }

  //-- Public APIs
  /// Status message of connectivity results and errors.
  /// * Value `null` indicates successful operation.
  String? get statusMsg => _statusMsg;

  /// Get connectivity result snapshot.
  /// {@template false_indication}
  /// * Value `false`  indicates error or negative result, you can call
  /// [statusMsg] method in this case.
  /// {@endtemplate}
  Future<bool> isNetConnected() async => await _connectivity
          .checkConnectivity()
          .then(_parseConnectivityResult)
          .onError<PlatformException>((e, s) {
        _statusMsg = _errorMsg;
        log(_errorMsg, error: e, stackTrace: s);
        return false;
      });

  /// Get real-time connectivity result.
  /// {@macro false_indication}
  Stream<bool> onNetConnected() =>
      _connectivity.onConnectivityChanged.map<bool>(_parseConnectivityResult);
}
