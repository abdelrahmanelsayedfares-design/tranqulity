import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppImage extends StatefulWidget {
  final String image;
  final double? height;
  final double? width;
  final Color? color;
  final bool isCircle;
  final BoxFit? fit;
  final VoidCallback? onLottieClicked;

  const AppImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.isCircle = false,
    this.color,
    this.fit,
    this.onLottieClicked,
  });

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.onLottieClicked != null) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (widget.image.isEmpty) return SizedBox.shrink();
    if (widget.image.toLowerCase().endsWith('.svg')) {
      child = SvgPicture.asset(
        'assets/icons/${widget.image}',
        width: widget.width,
        height: widget.height,
        color: widget.color,
        fit: widget.fit ?? BoxFit.scaleDown,
      );
    } else if (widget.image.startsWith('http')) {
      child = Image.network(
        widget.image,
        width: widget.width,
        height: widget.height,
        fit: widget.fit ?? BoxFit.cover,
        color: widget.color,

        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    } else if (widget.image.toLowerCase().endsWith('.json')) {
      child= Lottie.asset(
        'assets/looties/${widget.image}',
        width: widget.width,
        height: widget.height,
        fit: widget.fit ?? BoxFit.cover,
        controller: _controller,
      );
      if (widget.onLottieClicked != null) {
        child= GestureDetector(
          onTap: () {
            if (_controller!.isCompleted) {
              _controller!.reverse();
            } else {
              _controller!.forward();
            }
            widget.onLottieClicked?.call();

          },
          child:child,
        );


      }

    } else {
      child = Image.asset(
        'assets/images/${widget.image}',
        width: widget.width,
        height: widget.height,
        color: widget.color,
        fit: widget.fit ?? BoxFit.scaleDown,
      );
    }
    if (widget.isCircle) {
      return ClipOval(child: child);
    }

    return child;
  }
}
