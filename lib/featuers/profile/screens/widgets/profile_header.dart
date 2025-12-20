import 'package:flutter/material.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;
  const ProfileHeader({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage:
                  user?.avatarUrl != null && user!.avatarUrl.isNotEmpty
                  ? NetworkImage(user!.avatarUrl)
                  : const AssetImage('assets/avatar.png') as ImageProvider,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.camera_alt, size: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "${user?.firstName ?? ''} ${user?.lastName ?? ''}".trim().isEmpty
              ? "المستخدم"
              : "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          user?.email ?? "",
          style: const TextStyle(color: AppColors.subtitle),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "مستخدم",
            style: TextStyle(
              fontSize: 12,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
