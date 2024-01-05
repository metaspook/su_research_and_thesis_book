// Copyright 2023 MEtaspook. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;

/// {@template connectivator}
/// Network connectivity checker.
/// {@endtemplate}
class Connectivator {
  /// {@macro connectivator}
  // Connectivator();

  //-- Config
  final _connectivity = Connectivity();
  // final _errorMsg = "Couldn't fetch the connectivity result!";
  // String? _statusMsg;

  //-- Parse connectivity result.
  (String?, bool) _parseConnectivityResult(
    ConnectivityResult connectivityResult,
  ) =>
      [
        ConnectivityResult.wifi,
        ConnectivityResult.mobile,
        ConnectivityResult.vpn,
      ].contains(connectivityResult)
          ? ('Connected to the internet!', true)
          : ('Not connected to the internet!', false);

  //-- Public APIs
  /// Status message of connectivity results and errors.
  /// * Value `null` indicates successful operation.
  // String? get statusMsg => _statusMsg;

  /// Get connectivity result snapshot.
  /// {@template false_indication}
  /// * Value `false`  indicates error or negative result, you can call
  /// [statusMsg] method in this case.
  /// {@endtemplate}
  // Future<bool> isNetConnected() => _connectivity
  //         .checkConnectivity()
  //         .then(_parseConnectivityResult)
  //         .onError<PlatformException>((e, s) {
  //       _statusMsg = _errorMsg;
  //       log(_errorMsg, error: e, stackTrace: s);
  //       return false;
  //     });

  /// Get real-time connectivity result.
  /// {@macro false_indication}
  Stream<(String?, bool)> onConnected() => _connectivity.onConnectivityChanged
      .map<(String?, bool)>(_parseConnectivityResult);
  Future<(String?, bool)> isConnected() => onConnected().first;
}
