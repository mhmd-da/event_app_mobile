import 'package:event_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SessionCategoryHelper {

  static Color getCategoryColor(BuildContext ctx, String category) {
    return AppColors.defaultBg(ctx);
    // return switch (category.toLowerCase()) {
    //   "panel" => AppColors.panelBg(ctx),
    //   "workshop" => AppColors.workshopBg(ctx),
    //   "roundtable" => AppColors.roundtableBg(ctx),
    //   "mentorship" => AppColors.mentorshipBg(ctx),
    //   _ => AppColors.othersBg(ctx),
    // };
  }
}
