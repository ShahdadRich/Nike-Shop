import 'package:flutter/material.dart';
import 'package:nike/common/exception.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final GestureTapCallback onpress;
  const AppErrorWidget({
    super.key,
    required this.exception,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exception.masssage),
          ElevatedButton(onPressed: onpress, child: const Text('تلاش دوباره'))
        ],
      ),
    );
  }
}
