import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/featuers/profile/logic/profile_cubit.dart';
import 'package:iti_moqaf/featuers/profile/screens/widgets/logout_button.dart';
import 'package:iti_moqaf/featuers/profile/screens/widgets/profile_header.dart';
import 'package:iti_moqaf/featuers/profile/screens/widgets/section_card.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            loginScreen,
            (route) => false,
          );
        }
        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final user = state is ProfileLoaded ? state.user : null;
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 180, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: state is ProfileLoading
                        ? const CircularProgressIndicator()
                        : ProfileHeader(user: user),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "الادارة",
                    style: TextStyle(fontSize: 12, color: AppColors.subtitle),
                  ),
                  const SizedBox(height: 8),
                  const SectionCard(
                    icon: Icons.directions_car,
                    title: "سجل الحجوزات",
                    subtitle: "يمكنك معرفة سجل حجوزاتك من هنا",
                  ),
                  const SectionCard(
                    icon: Icons.credit_card,
                    title: "طرق الدفع",
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "التخصيصات",
                    style: TextStyle(fontSize: 12, color: AppColors.subtitle),
                  ),
                  const SizedBox(height: 8),
                  SectionCard(
                    icon: Icons.settings,
                    title: "الاعدادات",
                    subtitle: "اعدادات التطبيق",
                  ),
                  SectionCard(
                    icon: Icons.notifications,
                    title: "الاشعارات",
                    trailing: Switch(
                      value: true,
                      onChanged: (_) {},
                      activeColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "المساعدة",
                    style: TextStyle(fontSize: 12, color: AppColors.subtitle),
                  ),
                  const SizedBox(height: 8),
                  const SectionCard(
                    icon: Icons.help_outline,
                    title: "المساعدة والدعم الفني",
                  ),
                  const LogoutButton(),
                  const Center(
                    child: Text(
                      "الاصدار 1.0.0",
                      style: TextStyle(fontSize: 12, color: AppColors.subtitle),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
