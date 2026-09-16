import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';

class LocationSearchField extends StatefulWidget {
  final LocationCubit cubit;

  const LocationSearchField({super.key, required this.cubit});

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listenWhen: (previous, current) =>
          previous.searchQuery != current.searchQuery &&
          current.searchQuery.isEmpty,
      listener: (context, state) {
        _controller.clear();
      },
      child: TextField(
        controller: _controller,
        onChanged: widget.cubit.updateSearchQuery,
        textInputAction: TextInputAction.search,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hintText: 'Search city or area...',
          hintStyle: const TextStyle(color: AppColors.gray400),
          prefixIcon: const Icon(Icons.search_rounded, color: AppColors.gray500),
          suffixIcon: IconButton(
            onPressed: () {
              _controller.clear();
              FocusScope.of(context).unfocus();
              widget.cubit.updateSearchQuery('');
            },
            icon: const Icon(Icons.close_rounded, color: AppColors.gray500),
          ),
          filled: true,
          fillColor: AppColors.gray50,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary500, width: 1.5),
          ),
        ),
      ),
    );
  }
}
