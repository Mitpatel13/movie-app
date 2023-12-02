import 'package:flutter/material.dart';

class Containerview extends StatelessWidget {
  final String assetName;
  final String text;
  final Function()? onTap;

  const Containerview(
      {Key? key,
        required this.assetName,
        required this.text,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          width: 100,
          height: 161,
          child: Stack(
            children: [
              Image.network(
                assetName,
              ),
              Flexible(
                child: Text(
                  text,
                  maxLines: 2,
                  softWrap: true,overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
