import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class AudioButton extends StatelessWidget {
  final String textToSpeak;
  final Color? color;

  const AudioButton({super.key, required this.textToSpeak, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.volume_up,
        color: color ?? Theme.of(context).primaryColor,
      ),
      onPressed: () {
        Provider.of<AppProvider>(
          context,
          listen: false,
        ).playScript(textToSpeak);
      },
    );
  }
}
