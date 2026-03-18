import 'package:flutter/material.dart';

class TitleLarge extends StatelessWidget {
  final String data;
  const TitleLarge({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleLarge,
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}

class TitleSmall extends StatelessWidget {
  final String data;
  const TitleSmall({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall,
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}

class BodyText extends StatelessWidget {
  final String data;
  const BodyText({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium,
      softWrap: true,
      // overflow: TextOverflow.visible,
    );
  }
}

class DescText extends StatelessWidget {
  final String data;
  const DescText({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall,
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
