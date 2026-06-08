import 'package:flutter/material.dart';

import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_radius.dart';
import 'package:keluhin_mobile_app/core/constants/app_spacing.dart';
import 'package:keluhin_mobile_app/core/constants/app_typography.dart';
import 'package:keluhin_mobile_app/core/utils/helper.dart';
import 'package:keluhin_mobile_app/presentation/widgets/status_badge.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaint;

  final VoidCallback? onTap;

  const ComplaintCard({
    super.key,
    required this.complaint,
    this.onTap,
  });

  Widget _metaRow(IconData icon, String text, {bool expand = false}) {
    final label = Text(
      text,
      style: AppTypography.bodySmall.copyWith(color: AppColors.ink500),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.ink400),
        const SizedBox(width: AppSpacing.space2),
        if (expand) Expanded(child: label) else label,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.space4),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP SECTION — judul (H3) + badge status
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      complaint['title'] ?? '-',
                      style: AppTypography.heading3,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space3),
                  StatusBadge(status: complaint['status'] ?? '-'),
                ],
              ),

              const SizedBox(height: AppSpacing.space4),

              // CATEGORY
              _metaRow(
                Icons.category,
                complaint['category']?['name'] ?? '-',
              ),

              const SizedBox(height: AppSpacing.space2),

              // LOCATION
              _metaRow(
                Icons.location_on,
                complaint['location'] ?? '-',
                expand: true,
              ),

              const SizedBox(height: AppSpacing.space2),

              // DATE
              _metaRow(
                Icons.calendar_today,
                Helper.formatDate(complaint['created_at']),
              ),

              const SizedBox(height: AppSpacing.space3),

              // DESCRIPTION
              Text(
                complaint['description'] ?? '-',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySmall.copyWith(color: AppColors.ink600),
              ),

              const SizedBox(height: AppSpacing.space4),

              // FOOTER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.comment,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.space1),
                      Text(
                        '${complaint['responses_count'] ?? 0} Tanggapan',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.ink400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
