import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_theme/text_theme.dart';

class TitleAndDesc extends StatelessWidget {
  const TitleAndDesc({super.key, required this.title, required this.desc});

  final String title;
  final List<String> desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.font20BlackColorSemiBold),
        SizedBox(height: 18.h),
        RichText(
          text: TextSpan(
            children: [
              if (desc.isNotEmpty)
                TextSpan(
                  text: desc[0],
                  style: AppTextStyle.font18GreyColorSemiBold,
                ),
              if (desc.length > 1)
                TextSpan(
                  text: desc[1],
                  style: AppTextStyle.font18BlackColorSemiBold.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (desc.length > 2)
                TextSpan(
                  text: desc[2],
                  style: AppTextStyle.font18GreyColorSemiBold,
                ),
              // لو عايز تضيف عناصر زيادة ممكن تكمل بنفس الطريقة
            ],
          ),
        ),
      ],
    );
  }
}
