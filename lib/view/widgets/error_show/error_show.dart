
import 'package:flutter/material.dart';

import '../../../model/utils/resource/style_resource.dart';
class ErrorMessage extends StatelessWidget {
  final FlutterErrorDetails? errorDetails;
  const ErrorMessage({
    Key? key,
    @required this.errorDetails,
  })  : assert(errorDetails != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Something is not right here...",
            style: StyleResource.instance.styleMedium(14, Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            child: Text(
              errorDetails!.exception.toString(),
              style: StyleResource.instance.styleMedium(12, Colors.grey),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
