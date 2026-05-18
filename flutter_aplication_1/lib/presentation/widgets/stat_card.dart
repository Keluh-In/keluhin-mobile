import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;

  final String total;

  final Color color;

  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.total,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color:
                // ignore: deprecated_member_use
                Colors.grey.withOpacity(
              0.1,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          CircleAvatar(
            radius: 22,

            backgroundColor:
                // ignore: deprecated_member_use
                color.withOpacity(0.12),

            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),

          const Spacer(),

          Text(
            total,
            style: const TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}