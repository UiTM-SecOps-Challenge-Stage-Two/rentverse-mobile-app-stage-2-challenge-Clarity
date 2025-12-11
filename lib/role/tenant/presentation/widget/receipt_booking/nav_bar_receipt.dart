import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/common/screen/navigation_container.dart';
import 'package:rentverse/features/auth/presentation/pages/profile_pages.dart';
import 'package:rentverse/role/tenant/presentation/cubit/receipt_booking/cubit.dart';
import 'package:rentverse/role/tenant/presentation/cubit/receipt_booking/state.dart';
import 'package:rentverse/role/tenant/presentation/pages/nav/chat.dart';
import 'package:rentverse/role/tenant/presentation/pages/nav/home.dart';
import 'package:rentverse/role/tenant/presentation/pages/nav/rent.dart';
import 'package:rentverse/role/tenant/presentation/pages/property/property.dart';

class NavBarReceipt extends StatelessWidget {
  const NavBarReceipt({super.key, required this.amountLabel});

  final String amountLabel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBookingCubit, ReceiptBookingState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  amountLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF00B0FF),
                  ),
                ),
                const SizedBox(height: 12),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1CD8D2), Color(0xFF0097F6)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: state.isPaying
                          ? null
                          : () => _goToRentHome(context),
                      child: state.isPaying
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Back to Home Page',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _goToRentHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => _tenantNavigation(initialIndex: 2)),
    (route) => false,
  );
}

NavigationContainer _tenantNavigation({int initialIndex = 0}) {
  return NavigationContainer(
    initialIndex: initialIndex,
    pages: const [
      TenantHomePage(),
      TenantPropertyPage(),
      TenantRentPage(),
      TenantChatPage(),
      ProfilePage(),
    ],
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.grey),
        activeIcon: GradientIcon(icon: Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.apartment, color: Colors.grey),
        activeIcon: GradientIcon(icon: Icons.apartment),
        label: 'Property',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.receipt_long, color: Colors.grey),
        activeIcon: GradientIcon(icon: Icons.receipt_long),
        label: 'Rent',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat, color: Colors.grey),
        activeIcon: GradientIcon(icon: Icons.chat),
        label: 'Chat',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person, color: Colors.grey),
        activeIcon: GradientIcon(icon: Icons.person),
        label: 'Profile',
      ),
    ],
  );
}
