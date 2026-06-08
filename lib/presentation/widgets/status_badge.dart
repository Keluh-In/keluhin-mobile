import 'package:flutter/material.dart';

import 'package:keluhin_mobile_app/core/constants/app_radius.dart';
import 'package:keluhin_mobile_app/core/utils/helper.dart';

/// Badge status pengaduan — pill dengan titik berwarna + label.
/// Aturan design system: jangan andalkan warna saja (buta warna).
class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final Color color = Helper.statusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Titik berwarna (penanda non-warna untuk aksesibilitas).
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
