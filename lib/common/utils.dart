import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('certificates/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

enum TypeCinema { Movie, TvSeries }

extension Dialog on BuildContext {
  Future<void> dialog(String errMessage, Function tryAgain) async {
    await showDialog(
        context: this,
        builder: (context) => AlertDialog(
          content: Text(errMessage),
          actions: [
            ElevatedButton(
                onPressed: () {
                  tryAgain();
                },
                child: Text('Retry'))
          ],
        ));
  }
}