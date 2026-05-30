import 'package:flutter/material.dart';
import 'package:flutter_aplication_1/core/constants/app_colors.dart';
import 'package:flutter_aplication_1/core/constants/app_text.dart';

import 'package:flutter_aplication_1/core/utils/helper.dart';

import '../../data/repositories/complaint_repository.dart';

import '../../presentation/complaints/edit_complaint_screen.dart';

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

  Widget buildStatus(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
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
        ),
      ),
    );
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
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // TITLE
            Text(
              complaint!['title'] ??
                  '-',
              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // STATUS
            buildStatus(status),

            const SizedBox(height: 25),

            // CATEGORY
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.category,
                  color:
                      AppColors.primary,
                ),
                title: const Text(
                  AppText.category,
                ),
                subtitle: Text(
                  complaint!['category']?['name'] ??
                      '-',
                ),
              ),
            ),

            const SizedBox(height: 15),

            // LOCATION
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color:
                      AppColors.primary,
                ),
                title: const Text(
                  AppText.location,
                ),
                subtitle: Text(
                  complaint!['location'] ??
                      '-',
                ),
              ),
            ),

            const SizedBox(height: 15),

            // DATE
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.calendar_today,
                  color:
                      AppColors.primary,
                ),
                title: const Text(
                  'Tanggal',
                ),
                subtitle: Text(
                  Helper.formatDate(
                    complaint!['created_at'],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // DESCRIPTION
            const Text(
              AppText.description,
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  16,
                ),
                child: Text(
                  complaint!['description'] ??
                      '-',
                ),
              ),
            ),

            const SizedBox(height: 30),

            // RESPONSES
            const Text(
              'Tanggapan Admin',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            responses.isEmpty
                ? const Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(
                      20,
                    ),
                    child: Center(
                      child: Text(
                        'Belum ada tanggapan',
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
                        bottom: 12,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(
                          16,
                        ),
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
                                      AppColors
                                          .primary,
                                  child: Icon(
                                    Icons
                                        .admin_panel_settings,
                                    color:
                                        Colors
                                            .white,
                                    size: 18,
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
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
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        Helper.formatDate(
                                          item['created_at'],
                                        ),
                                        style:
                                            const TextStyle(
                                          fontSize:
                                              12,
                                          color:
                                              Colors
                                                  .grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Text(
                              item['message'] ??
                                  '-',
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
