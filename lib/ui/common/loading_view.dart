import 'package:flutter/material.dart';
import 'package:medical_app/data/loading_status.dart';

class LoadingView extends StatelessWidget {
  final LoadingStatus loadingStatus;
  final Widget initialContent;
  final Widget loadingContent;
  final Widget errorContent;
  final Widget successContent;

  const LoadingView({
    Key key,
    this.loadingStatus,
    this.loadingContent,
    this.errorContent,
    this.successContent,
    this.initialContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var content;

    switch (loadingStatus) {
      case LoadingStatus.initial:
        content = initialContent;
        break;
      case LoadingStatus.loading:
        content = loadingContent;
        break;
      case LoadingStatus.success:
        content = successContent;
        break;
      case LoadingStatus.error:
        content = errorContent;
        break;
    }

    return content;
  }
}
