import "package:flutter/cupertino.dart";

import "../../export.dart";

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({
    super.key,
    this.linearGradient = _shimmerGradient,
    this.child,
  });

  final LinearGradient linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

// code-excerpt-closing-bracket

  LinearGradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform:
            _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size {
    final renderObject = context.findRenderObject() as RenderBox?;
    return renderObject?.size ?? Size.zero;
  }

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox?;
    return shimmerBox?.localToGlobal(offset, ancestor: shimmerBox) ??
        Offset.zero;
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }

  _emptyData() => Container(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print('$index');
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius_8),
                    border: Border.all(
                        color: AppColors.borderColor, width: width_1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height_130,
                      child: NetworkImageWidget(
                        imageUrl: iconsSplashIcon??"",
                        imageHeight: height_150,
                        imageWidth: width_130,
                        imageFitType: BoxFit.fill,
                        radiusAll: radius_4,
                      ),
                    ),
                    Center(
                        child: TextView(
                      text: "data",
                      textStyle: textStyleTitleLarge().copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ).paddingOnly(top: 16))
                  ],
                ).paddingAll(margin_4),
              ),
            );
          },
        ).paddingOnly(top: 20),
      ).paddingSymmetric(horizontal: margin_20);
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
    this.isImage,
  });

  final bool isLoading;
  final Widget child;
  final bool? isImage;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;
  bool isLoadingData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        isLoadingData = true; // Set isLoadingData to true to show loading data
      });
    } else {
      setState(() {
        isLoadingData =
            false; // Set isLoadingData to false to hide loading data
      });
    }
  }

// code-excerpt-closing-bracket

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }
    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final renderObject = context.findRenderObject() as RenderBox?;
    if (renderObject != null) {
      final offsetWithinShimmer = shimmer.getDescendantOffset(
        descendant: context.findRenderObject() as RenderBox,
      );
      return ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          return gradient.createShader(
            Rect.fromLTWH(
              -offsetWithinShimmer.dx,
              -offsetWithinShimmer.dy,
              shimmerSize.width,
              shimmerSize.height,
            ),
          );
        },
        child: isLoadingData
            ? ((widget.isImage ?? false)
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    color: Colors.grey,
                  )
                : const LoadingData())
            : widget.child,
      );
    } else {
      return const SizedBox();
    }
  }
}

class CircleListItem extends StatelessWidget {
  final double? circleSize;

  const CircleListItem({super.key, this.circleSize});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: margin_8),
              child: Container(
                width: circleSize ?? height_60,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ));
  }
}

class LoadingData extends StatelessWidget {
  const LoadingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin_20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 0.75,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_8),
                border:
                    Border.all(color: AppColors.borderColor, width: width_1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height_130,
                  width: height_160,
                  color: Colors.grey,
                ),
                Center(
                    child: TextView(
                  text: "     ",
                  textStyle: textStyleTitleLarge().copyWith(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ).paddingOnly(top: 16))
              ],
            ).paddingAll(margin_4),
          );
        },
      ),
    );
  }
}
