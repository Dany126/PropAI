import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/ai_search_bar.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/home_section_header.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/property_card.dart';
import '../widgets/property_type_tabs.dart';

class HomeView extends StatelessWidget {
  final VoidCallback? onLocationTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAskAiTap;
  final VoidCallback? onProfileTap;
  final ValueChanged<String>? onPropertyTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onSeeAllAiMatches;
  final VoidCallback? onSeeAllNearby;
  final VoidCallback? onFilterTap;
  final ValueChanged<HomeNavItem>? onBottomNavTap;

  const HomeView({
    super.key,
    this.onLocationTap,
    this.onNotificationTap,
    this.onAskAiTap,
    this.onProfileTap,
    this.onPropertyTap,
    this.onFavoriteTap,
    this.onSeeAllAiMatches,
    this.onSeeAllNearby,
    this.onFilterTap,
    this.onBottomNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ResponsiveLayout(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatus.loading ||
                  state.status == HomeStatus.initial) {
                return const _LoadingView();
              }

              if (state.status == HomeStatus.failure) {
                return _ErrorView(
                  message: state.errorMessage ?? 'Something went wrong.',
                  onRetry: () {
                    context.read<HomeCubit>().loadHome();
                  },
                );
              }

              final data = state.data!;

              return Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return context.read<HomeCubit>().loadHome();
                      },
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: HomeTopBar(
                              location: data.locationName ?? 'Choose location',
                              onLocationTap: onLocationTap,
                              onNotificationTap: onNotificationTap,
                              onAskAiTap: onAskAiTap,
                              onProfileTap: onProfileTap,
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 12)),

                          SliverToBoxAdapter(
                            child: AiSearchBar(
                              onTap: onAskAiTap,
                              onFilterTap: onFilterTap,
                            ),
                          ),

                          SliverToBoxAdapter(child: SizedBox(height: 12)),

                          SliverToBoxAdapter(
                            child: PropertyTypeTabs(
                              types: data.propertyTypes,
                              selectedIndex: state.selectedTypeIndex,
                              onSelected: (index) {
                                context.read<HomeCubit>().selectPropertyType(
                                  index,
                                );
                              },
                            ),
                          ),

                          SliverToBoxAdapter(child: SizedBox(height: 12)),

                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                            sliver: SliverToBoxAdapter(
                              child: HomeSectionHeader(
                                title: 'AI-Matched Picks for You',
                                subtitle: 'Powered by semantic search',
                                ai: true,
                                onSeeAll: onSeeAllAiMatches,
                              ),
                            ),
                          ),

                          SliverToBoxAdapter(child: SizedBox(height: 12)),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.38,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.aiMatchedProperties.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final property =
                                      data.aiMatchedProperties[index];

                                  return PropertyCard(
                                    property: property,
                                    onTap: () =>
                                        onPropertyTap?.call(property.id),
                                    onFavoriteTap: onFavoriteTap,
                                  );
                                },
                              ),
                            ),
                          ),

                          SliverToBoxAdapter(child: SizedBox(height: 12)),
                          SliverToBoxAdapter(
                            child: HomeSectionHeader(
                              title: 'Nearby Properties',
                              subtitle:
                                  'Around ${data.locationName ?? 'your location'}',
                              onSeeAll: onSeeAllNearby,
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 12)),

                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.34,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.nearbyProperties.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final property = data.nearbyProperties[index];

                                  return PropertyCard(
                                    property: property,
                                    compact: true,
                                    onTap: () =>
                                        onPropertyTap?.call(property.id),
                                    onFavoriteTap: onFavoriteTap,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),

                  HomeBottomNav(
                    selected: HomeNavItem.home,
                    onSelected: (item) {
                      onBottomNavTap?.call(item);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary600),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 48,
              color: AppColors.gray400,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium14.copyWith(color: AppColors.gray600),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary600,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
