import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/property_entity.dart';

class PropertyCard extends StatelessWidget {
  final PropertyEntity property;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final bool compact;

  const PropertyCard({
    super.key,
    required this.property,
    this.onTap,
    this.onFavoriteTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 374 / 428.5,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.gray200),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                _ImageHeader(property: property, onFavoriteTap: onFavoriteTap),

                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property.priceLabel,
                        style: AppTextStyle.bold16.copyWith(
                          color: AppColors.gray900,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        property.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.semiBold14.copyWith(
                          color: AppColors.gray800,
                        ),
                      ),

                      const SizedBox(height: 6),

                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.bed_outlined,
                              size: 14,
                              color: AppColors.gray500,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${property.bedrooms} Beds',
                              style: AppTextStyle.regular12.copyWith(
                                color: AppColors.gray500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.bathtub_outlined,
                              size: 14,
                              color: AppColors.gray500,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${property.bathrooms} Baths',
                              style: AppTextStyle.regular12.copyWith(
                                color: AppColors.gray500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.square_foot_rounded,
                              size: 14,
                              color: AppColors.gray500,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${property.areaSqft.toInt()} sqft',
                              style: AppTextStyle.regular12.copyWith(
                                color: AppColors.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (property.smartMatch != null) ...[
                        const SizedBox(height: 9),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.aiAccent50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                size: 13,
                                color: AppColors.aiAccent600,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  property.smartMatch!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.medium10.copyWith(
                                    color: AppColors.aiAccent700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageHeader extends StatelessWidget {
  final PropertyEntity property;
  final VoidCallback? onFavoriteTap;

  const _ImageHeader({required this.property, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            property.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                color: AppColors.gray100,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.home_work_outlined,
                  size: 42,
                  color: AppColors.gray400,
                ),
              );
            },
          ),

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
                  ],
                ),
              ),
            ),
          ),

          if (property.matchPercentage > 0)
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  '+${property.matchPercentage}% Intent Match',
                  style: AppTextStyle.medium12.copyWith(
                    color: AppColors.aiAccent700,
                  ),
                ),
              ),
            ),

          if (property.badge != null)
            Positioned(
              left: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gray900.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  property.badge!,
                  style: AppTextStyle.medium12.copyWith(color: AppColors.white),
                ),
              ),
            ),

          Positioned(
            right: 8,
            top: 8,
            child: GestureDetector(
              onTap: onFavoriteTap,
              child: Container(
                width: 31,
                height: 31,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.92),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  property.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_rounded,
                  size: 18,
                  color: property.isFavorite
                      ? AppColors.favoriteActive
                      : AppColors.gray700,
                ),
              ),
            ),
          ),

          Positioned(
            right: 8,
            bottom: 8,
            child: Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: AppColors.ratingStar,
                ),
                const SizedBox(width: 2),
                Text(
                  '${property.rating}',
                  style: AppTextStyle.semiBold10.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
