import 'package:flutter/material.dart';
import 'package:keluhin_mobile_app/core/constants/app_colors.dart';
import 'package:keluhin_mobile_app/core/constants/app_text.dart';

import 'package:keluhin_mobile_app/core/utils/helper.dart';

import '../../data/repositories/complaint_repository.dart';

import 'complaint_detail_screen.dart';
import 'create_complaint_screen.dart';

class ComplaintListScreen
    extends StatefulWidget {
  const ComplaintListScreen({
    super.key,
  });

  @override
  State<ComplaintListScreen>
      createState() =>
          _ComplaintListScreenState();
}

class _ComplaintListScreenState
    extends State<ComplaintListScreen> {
  final ComplaintRepository repository =
      ComplaintRepository();

  List complaints = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    getComplaints();
  }

  Future getComplaints() async {
    try {
      final data =
          await repository.getComplaints();

      setState(() {
        complaints = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

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
    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        elevation: 0,
        title: const Text(
          AppText.complaints,
        ),
      ),

      body:
          loading
              ? const Center(
                child:
                    CircularProgressIndicator(),
              )
              : complaints.isEmpty
              ? const Center(
                child: Text(
                  AppText.noData,
                ),
              )
              : RefreshIndicator(
                onRefresh:
                    () => getComplaints(),

                child: ListView.builder(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  itemCount:
                      complaints.length,

                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final item =
                        complaints[index];

                    return Card(
                      elevation: 2,

                      margin:
                          const EdgeInsets.only(
                        bottom: 16,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),

                        onTap: () async {
                          final result =
                              await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      ComplaintDetailScreen(
                                complaintId:
                                    item['id'],
                              ),
                            ),
                          );

                          if (result ==
                              true) {
                            getComplaints();
                          }
                        },

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
                              // TOP
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['title'] ??
                                          '-',
                                      style:
                                          const TextStyle(
                                        fontSize:
                                            17,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                      maxLines:
                                          2,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                    ),
                                  ),

                                  buildStatus(
                                    item['status'] ??
                                        '-',
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 14,
                              ),

                              // CATEGORY
                              Row(
                                children: [
                                  const Icon(
                                    Icons.category,
                                    size: 18,
                                    color:
                                        Colors.grey,
                                  ),

                                  const SizedBox(
                                    width: 6,
                                  ),

                                  Text(
                                    item['category']?['name'] ??
                                        '-',
                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              // LOCATION
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color:
                                        Colors.grey,
                                  ),

                                  const SizedBox(
                                    width: 6,
                                  ),

                                  Expanded(
                                    child: Text(
                                      item['location'] ??
                                          '-',
                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.grey,
                                      ),
                                      maxLines:
                                          1,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              // DATE
                              Row(
                                children: [
                                  const Icon(
                                    Icons
                                        .calendar_today,
                                    size: 18,
                                    color:
                                        Colors.grey,
                                  ),

                                  const SizedBox(
                                    width: 6,
                                  ),

                                  Text(
                                    Helper.formatDate(
                                      item['created_at'],
                                    ),
                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

      floatingActionButton:
          FloatingActionButton(
            backgroundColor:
                AppColors.primary,

            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),

            onPressed: () async {
              final result =
                  await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) =>
                          const CreateComplaintScreen(),
                ),
              );

              if (result == true) {
                getComplaints();
              }
            },
          ),
    );
  }
}