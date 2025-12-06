import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/core/services/service_locator.dart';
import 'package:rentverse/role/tenant/presentation/cubit/get_user/cubit.dart';
import 'package:rentverse/role/tenant/presentation/cubit/get_user/state.dart';
import 'package:rentverse/role/tenant/presentation/cubit/list_property/cubit.dart';
import 'package:rentverse/role/tenant/presentation/widget/city_carousel.dart';
import 'package:rentverse/role/tenant/presentation/widget/list_property.dart';
import 'package:rentverse/role/tenant/presentation/widget/search_and_sort_widget.dart';
import 'package:rentverse/features/property/domain/usecase/get_properties_usecase.dart';

import '../widget/carousel_custom.dart';

class TenantHomePage extends StatelessWidget {
  const TenantHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetUserCubit(sl())..load(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFF5F5F5),

          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: BlocBuilder<GetUserCubit, GetUserState>(
              builder: (context, state) {
                final displayName = state.user?.name?.isNotEmpty == true
                    ? state.user!.name!
                    : 'User';
                return AppBar(
                  backgroundColor: Color(0xFFF5F5F5),
                  elevation: 0,
                  toolbarHeight: 60,
                  leadingWidth: 68,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade200,
                      child: Text(
                        displayName.isNotEmpty
                            ? displayName[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  centerTitle: true,
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Selamat Datang',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.notifications_none,
                            color: Colors.black87,
                            size: 28,
                          ),
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          body: BlocProvider(
            create: (_) =>
                ListPropertyCubit(sl<GetPropertiesUseCase>())..load(),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scroll) {
                if (scroll.metrics.pixels >=
                        scroll.metrics.maxScrollExtent - 120 &&
                    scroll is ScrollUpdateNotification) {
                  final cubit = scroll.context?.read<ListPropertyCubit>();
                  cubit?.loadMore();
                }
                return false;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(height: 8),
                      CarouselCustom(),
                      SizedBox(height: 6),
                      SearchAndSortWidget(),
                      SizedBox(height: 12),
                      CityCarousel(),
                      SizedBox(height: 12),
                      ListPropertyWidget(),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
