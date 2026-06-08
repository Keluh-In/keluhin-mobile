import 'package:flutter/material.dart';
import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_spacing.dart';
import 'package:keluhin_mobile_app/core/constants/app_text.dart';
import 'package:keluhin_mobile_app/core/constants/app_typography.dart';

import 'package:keluhin_mobile_app/core/utils/helper.dart';

import '../../data/repositories/complaint_repository.dart';

import '../../presentation/complaints/edit_complaint_screen.dart';
import '../widgets/status_badge.dart';

class ComplaintDetailScreen
    extends StatefulWidget {
  final int complaintId;

  const ComplaintDetailScreen({
    super.key,
    required this.complaintId,
  });

  @override
  State<ComplaintDetailScreen>
      createState() =>
          _ComplaintDetailScreenState();
}

class _ComplaintDetailScreenState
    extends State<ComplaintDetailScreen> {
  final ComplaintRepository repository =
      ComplaintRepository();

  Map<String, dynamic>? complaint;

  List responses = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    getDetail();
  }

  Future getDetail() async {
    try {
      final detail =
          await repository
              .getComplaintDetail(
        widget.complaintId,
      );

      final responseData =
          await repository.getResponses(
        widget.complaintId,
      );

      setState(() {
        complaint = detail;
        responses = responseData;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Future deleteComplaint() async {
    bool success =
        await repository.deleteComplaint(
      widget.complaintId,
    );

    if (!mounted) return;

    if (success) {
      Helper.successMessage(
        context,
        'Pengaduan berhasil dihapus',
      );

      Navigator.pop(context, true);
    } else {
      Helper.errorMessage(
        context,
        'Gagal menghapus pengaduan',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (complaint == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text(
            'Data tidak ditemukan',
          ),
        ),
      );
    }

    final status =
        complaint!['status'] ?? '';

    final canEdit =
        status ==
        AppText.waiting;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppText.complaintDetail,
        ),

        actions: [
          if (canEdit)
            IconButton(
              icon: const Icon(
                Icons.edit,
              ),
              onPressed: () async {
                final result =
                    await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EditComplaintScreen(
                      complaint:
                          complaint!,
                    ),
                  ),
                );

                if (result == true) {
                  getDetail();
                }
              },
            ),

          if (canEdit)
            IconButton(
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) =>
                          AlertDialog(
                    title: const Text(
                      'Hapus Pengaduan',
                    ),
                    content: const Text(
                      'Yakin ingin menghapus pengaduan?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: const Text(
                          'Batal',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );

                          deleteComplaint();
                        },
                        child: const Text(
                          'Hapus',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(AppSpacing.space5),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // TITLE
            Text(
              complaint!['title'] ?? '-',
              style: AppTypography.heading2,
            ),

            const SizedBox(height: AppSpacing.space4),

            // STATUS
            StatusBadge(status: status),

            const SizedBox(height: AppSpacing.space6),

            // CATEGORY
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.category,
                  color: AppColors.primary,
                ),
                title: const Text(AppText.category),
                subtitle: Text(
                  complaint!['category']?['name'] ?? '-',
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space3),

            // LOCATION
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                ),
                title: const Text(AppText.location),
                subtitle: Text(
                  complaint!['location'] ?? '-',
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space3),

            // DATE
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.calendar_today,
                  color: AppColors.primary,
                ),
                title: const Text('Tanggal'),
                subtitle: Text(
                  Helper.formatDate(
                    complaint!['created_at'],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space6),

            // DESCRIPTION
            Text(
              AppText.description,
              style: AppTypography.heading3,
            ),

            const SizedBox(height: AppSpacing.space2),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.space5),
                child: Text(
                  complaint!['description'] ?? '-',
                  style: AppTypography.body.copyWith(color: AppColors.ink600),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space8),

            // RESPONSES
            Text(
              'Tanggapan Admin',
              style: AppTypography.heading3,
            ),

            const SizedBox(height: AppSpacing.space4),

            responses.isEmpty
                ? Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.space5),
                    child: Center(
                      child: Text(
                        'Belum ada tanggapan',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.ink500),
                      ),
                    ),
                  ),
                )
                : Column(
                  children:
                      responses.map((item) {
                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: AppSpacing.space3,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppSpacing.space5),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 18,
                                  backgroundColor:
                                      AppColors.primary,
                                  child: Icon(
                                    Icons.admin_panel_settings,
                                    color: AppColors.white,
                                    size: 18,
                                  ),
                                ),

                                const SizedBox(
                                  width: AppSpacing.space3,
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        item['admin']['name'] ??
                                            'Admin',
                                        style: AppTypography.body.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        Helper.formatDate(
                                          item['created_at'],
                                        ),
                                        style: AppTypography.caption.copyWith(
                                          color: AppColors.ink500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(
                              height: AppSpacing.space4,
                            ),

                            Text(
                              item['message'] ?? '-',
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.ink600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
          ],
        ),
      ),
    );
  }
}
