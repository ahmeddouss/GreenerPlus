import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScanner {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> _devicesList = [];
  final StreamController<List<BluetoothDevice>> _devicesStreamController =
      StreamController.broadcast();

  BluetoothScanner() {
    _flutterBlue.scanResults.listen((results) {
      bool updated = false;
      for (ScanResult r in results) {
        if (!_devicesList.contains(r.device)) {
          _devicesList.add(r.device);
          updated = true;
        }
      }
      if (updated) {
        _devicesStreamController.add(_devicesList);
      }
    });
  }

  void startScan() {
    _flutterBlue.startScan(timeout: Duration(seconds: 60)).whenComplete(() {
      _flutterBlue.stopScan();
    });
  }

  Stream<List<BluetoothDevice>> get devicesStream =>
      _devicesStreamController.stream;

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      // Do something with the service
    }
  }

  void dispose() {
    _devicesStreamController.close();
  }
}
