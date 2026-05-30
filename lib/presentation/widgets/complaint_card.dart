import 'package:flutter/material.dart';

import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/utils/helper.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaint;

  final VoidCallback? onTap;

  const ComplaintCard({
    super.key,
    required this.complaint,
    this.onTap,
  });

  Widget buildStatus(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: Helper.statusColor(
          status,
        // ignore: deprecated_member_use
        ).withOpacity(0.1),

        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Text(
        status,
        style: TextStyle(
          color: Helper.statusColor(
            status,
          ),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      margin: const EdgeInsets.only(
        bottom: 16,
      ),

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(16),

        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // TOP SECTION
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Text(
                      complaint['title'] ??
                          '-',
                      style:
                          const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow:
                          TextOverflow
                              .ellipsis,
                    ),
                  ),

                  const SizedBox(width: 10),

                  buildStatus(
                    complaint['status'] ??
                        '-',
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // CATEGORY
              Row(
                children: [
                  const Icon(
                    Icons.category,
                    size: 18,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    complaint['category']
                            ?['name'] ??
                        '-',
                    style:
                        const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // LOCATION
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: Text(
                      complaint['location'] ??
                          '-',
                      style:
                          const TextStyle(
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow:
                          TextOverflow
                              .ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // DATE
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    Helper.formatDate(
                      complaint[
                          'created_at'],
                    ),
                    style:
                        const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // DESCRIPTION
              Text(
                complaint['description'] ??
                    '-',
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 16),

              // FOOTER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.comment,
                        size: 18,
                        color:
                            AppColors
                                .primary,
                      ),

                      const SizedBox(
                        width: 5,
                      ),

                      Text(
                        '${complaint['responses_count'] ?? 0} Tanggapan',
                        style:
                            const TextStyle(
                          color:
                              AppColors
                                  .primary,
                          fontWeight:
                              FontWeight
                                  .w500,
                        ),
                      ),
                    ],
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
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