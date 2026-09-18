import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/property_details_entity.dart';
import '../cubit/property_cubit.dart';
import '../cubit/property_state.dart';
import '../widgets/property_bottom_action.dart';
import '../widgets/property_features.dart';
import '../widgets/property_gallery.dart';
import '../widgets/property_header.dart';
import '../widgets/property_info.dart';

class PropertyView extends StatefulWidget {
  final String propertyId;

  final VoidCallback? onFavorite;
  final VoidCallback? onShare;
  final void Function(PropertyDetailsEntity property)? onRequestViewing;

  const PropertyView({
    super.key,
    required this.propertyId,
    this.onFavorite,
    this.onShare,
    this.onRequestViewing,
  });

  @override
  State<PropertyView> createState() => _PropertyViewState();
}

class _PropertyViewState extends State<PropertyView> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          if (state.status == PropertyStatus.loading ||
              state.status == PropertyStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == PropertyStatus.failure) {
            return _ErrorView(
              message: state.errorMessage ?? 'Something went wrong.',
              onRetry: () {
                context.read<PropertyCubit>().loadProperty(widget.propertyId);
              },
            );
          }

          final property = state.property;

          if (property == null) {
            return const Center(child: Text('Property not found'));
          }

          isFavorite = property.isFavorite;

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        PropertyGallery(images: property.images),

                        PropertyHeader(
                          onBack: () {
                            Navigator.pop(context);
                          },
                          onFavorite: () {
                            widget.onFavorite?.call();
                          },
                          onShare: () {
                            widget.onShare?.call();
                          },
                          isFavorite: isFavorite,
                        ),
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(child: PropertyInfo(property: property)),

                  SliverToBoxAdapter(
                    child: PropertyFeatures(property: property),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 110)),
                ],
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: PropertyBottomAction(
                  onRequestViewing: () {
                    widget.onRequestViewing?.call(property);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home_work_outlined, size: 50, color: AppColors.gray400),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium12.copyWith(color: AppColors.gray600),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Try Again')),
          ],
        ),
      ),
    );
  }
}
