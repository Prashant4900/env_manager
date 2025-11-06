import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MySettingPage extends StatefulWidget {
  const MySettingPage({super.key});

  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  String _appVersion = '1.0.0';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = 'v${packageInfo.version} (${packageInfo.buildNumber})';
      });
    } catch (e) {
      debugPrint('Failed to load app version: $e');
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        children: [
          Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),
          // App Info Section
          _buildSection(
            context,
            title: 'About',
            icon: Icons.info_outline,
            children: [
              _buildInfoRow('Version', _appVersion),
              _buildInfoRow('Developer', 'Prashant Nigam'),
              _buildInfoRow('Build', '2025-11-06'),
            ],
          ),

          // Open Source Section
          _buildSection(
            context,
            title: 'Open Source',
            icon: Icons.engineering,
            children: [
              _buildClickableTile(
                context,
                title: 'View Source Code',
                icon: Icons.open_in_new,
                onTap: () => _launchURL(
                  'https://github.com/prashant4900/env_manager',
                ),
              ),
              _buildClickableTile(
                context,
                title: 'View License',
                icon: Icons.article_outlined,
                onTap: () => _launchURL(
                  'https://github.com/prashant4900/env_manager/blob/main/LICENSE',
                ),
              ),
              _buildClickableTile(
                context,
                title: 'View Dependencies',
                icon: Icons.list_alt,
                onTap: () => showLicensePage(context: context),
              ),
            ],
          ),

          // Support Section
          _buildSection(
            context,
            title: 'Support',
            icon: Icons.help_outline,
            children: [
              _buildClickableTile(
                context,
                title: 'Help & Documentation',
                icon: Icons.help_center_outlined,
                onTap: () => _launchURL(
                  'https://github.com/prashant4900/env_manager',
                ),
              ),
              _buildClickableTile(
                context,
                title: 'Send Feedback',
                icon: Icons.feedback_outlined,
                onTap: () => _launchURL('mailto:prashantnigam490@gmail.com'),
              ),
              _buildClickableTile(
                context,
                title: 'Report an Issue',
                icon: Icons.bug_report_outlined,
                onTap: () => _launchURL(
                  'https://github.com/prashant4900/env_manager/issues',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            SizedBox(width: 8.w),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(children: children),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
    );
  }
}
