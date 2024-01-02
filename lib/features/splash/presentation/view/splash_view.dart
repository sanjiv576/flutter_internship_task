import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_routes.dart';
import '../../../../core/utils/device_size.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  late DeviceSize deviceSize;

  // send size of data to the DeviceSize class
  _initializeDeviceSize({required double height, required double width}) {
    deviceSize = DeviceSize(height: height, width: width);
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, AppRoutes.navigationRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    // get sizes of the device, then, send to device size class
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    _initializeDeviceSize(width: width, height: height);

    return const Scaffold(
      body: Center(
        child: Text('Online Store'),
      ),
    );
  }
}
