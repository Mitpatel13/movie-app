import 'package:flutter/material.dart';

class CustomItemView extends StatelessWidget {
  final String image;
  final String title;

  const CustomItemView({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(
           image,fit: BoxFit.contain,
          // borderRadius: BorderRadius.circular(5),
          // boxFit: BoxFit.contain,
        ),
        Container(
          // width:context.,
          // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                // bottomLeft: Radius.circular(5),
                // bottomRight: Radius.circular(5)
            ),
            color: Colors.transparent.withOpacity(0.8),
            // color: AppColor.transparent.withOpacity(0.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    // fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
