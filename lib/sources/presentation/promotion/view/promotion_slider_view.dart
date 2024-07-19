import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/promotion_bloc.dart';
import '../widgets/slider_indicator.dart';

class PromotionSliderView extends StatelessWidget {
  const PromotionSliderView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PromotionBloc, PromotionState>(
      buildWhen: (previous, current) =>
          previous.sliderItems != current.sliderItems || previous.pageIndex != current.pageIndex,
      builder: (context, state) {
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: state.sliderItems.length,
              itemBuilder: (context, index, realIndex) {
                final item = state.sliderItems[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      item.imageString,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    const SizedBox(height: AppSize.spacedViewSpacing),
                    Text(
                      item.title,
                      style: theme.textTheme.bodyMedium?.copyWith(letterSpacing: 2.24),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSize.inset),
                    Text(
                      item.description,
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: AppSize.inset * 2),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 2,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  context.read<PromotionBloc>().add(ChangePageIndex(index));
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  state.sliderItems.length,
                  (listIndex) => SliderIndicator(
                    isOn: listIndex == state.pageIndex.toInt(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
