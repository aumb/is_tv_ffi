import 'package:flutter/material.dart';
import 'package:is_tv_ffi/is_tv_ffi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // `isTv` is a synchronous read of a native API, so there is nothing to
    // await and no need to hold it in state.
    final isTv = const IsTvFfi().isTv;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Text('Is device a tv: $isTv')),
      ),
    );
  }
}
