import 'package:env_manager/constants/app_colors.dart';
import 'package:env_manager/pages/environment_page.dart';
import 'package:env_manager/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<NavItem> _navItems = [
    NavItem(
      icon: Icons.home,
      label: 'Environments',
      page: const EnvironmentPage(),
    ),
    NavItem(
      icon: Icons.settings,
      label: 'Settings',
      page: const MySettingPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Custom Sidebar
          Container(
            width: 250.w,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Spacer
                SizedBox(height: 20.h),

                // App Title
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    'Env Manager',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Navigation Items
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    itemCount: _navItems.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedIndex == index;
                      return _buildNavItem(
                        item: _navItems[index],
                        isSelected: isSelected,
                        onTap: () => setState(() => _selectedIndex = index),
                      );
                    },
                  ),
                ),

                // Footer (optional)
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    'v1.0.0',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withAlpha((0.7 * 255).toInt()),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: _navItems[_selectedIndex].page,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required NavItem item,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.onPrimary.withAlpha((0.1 * 255).toInt())
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          item.icon,
          color: isSelected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onPrimary.withValues(alpha: 0.7),
          size: 20.sp,
        ),
        title: Text(
          item.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onPrimary.withValues(alpha: 0.7),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      ),
    );
  }
}

class NavItem {
  NavItem({
    required this.icon,
    required this.label,
    required this.page,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final Widget page;
  final bool selected;
}
