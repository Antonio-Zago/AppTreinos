import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class BackgroundCamada3Default extends StatefulWidget {
  BackgroundCamada3Default({super.key, required this.children, this.scrollController});

  final List<Widget> children;
  ScrollController? scrollController;

  @override
  State<BackgroundCamada3Default> createState() => _BackgroundCamada3DefaultState();
}

class _BackgroundCamada3DefaultState extends State<BackgroundCamada3Default> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
            child: Opacity(
              opacity: 0.85,
              child: Container(
                color: Color(ColorConstants.fundoApp),
                height: double.infinity,
                child: Padding(
                   padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                  child: SingleChildScrollView(
                    controller: widget.scrollController,
                    child: Column(
                      children:  widget.children
                    )
                  ),
                )
              ),
            )
    );
  }
}