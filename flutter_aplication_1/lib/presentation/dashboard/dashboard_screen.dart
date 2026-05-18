import 'package:flutter/material.dart';

import 'package:flutter_aplication_1/core/constants/app_colors.dart';
import 'package:flutter_aplication_1/core/constants/app_text.dart';

import '../../data/repositories/complaint_repository.dart';

import '../complaints/complaint_list_screen.dart';
import '../profile/profile_screen.dart';

class DashboardScreen
    extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen>
      createState() =>
          _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {
  final ComplaintRepository repository =
      ComplaintRepository();

  int selectedIndex = 0;

  List complaints = [];

  bool loading = true;

  int waiting = 0;
  int processing = 0;
  int completed = 0;
  int rejected = 0;

  @override
  void initState() {
    super.initState();

    getDashboardData();
  }

  Future getDashboardData() async {
    try {
      final data =
          await repository.getComplaints();

      calculateStatus(data);

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

  void calculateStatus(List data) {
    waiting = data
        .where(
          (item) =>
              item['status'] ==
              AppText.waiting,
        )
        .length;

    processing = data
        .where(
          (item) =>
              item['status'] ==
              AppText.processing,
        )
        .length;

    completed = data
        .where(
          (item) =>
              item['status'] ==
              AppText.completed,
        )
        .length;

    rejected = data
        .where(
          (item) =>
              item['status'] ==
              AppText.rejected,
        )
        .length;
  }

  Widget dashboardContent() {
    return RefreshIndicator(
      onRefresh: () => getDashboardData(),

      child: SingleChildScrollView(
        physics:
            const AlwaysScrollableScrollPhysics(),

        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // HEADER
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                24,
              ),

              decoration: BoxDecoration(
                color:
                    AppColors.primary,

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  const Text(
                    'Selamat Datang 👋',
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'KELUH.IN',
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontSize: 28,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    'Total Pengaduan: ${complaints.length}',
                    style: const TextStyle(
                      color:
                          Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // STATUS TITLE
            const Text(
              'Statistik Pengaduan',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // GRID
            GridView.count(
              crossAxisCount: 2,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              childAspectRatio: 1.2,

              children: [
                buildStatCard(
                  title:
                      AppText.waiting,
                  total:
                      waiting.toString(),
                  color:
                      Colors.orange,
                  icon:
                      Icons.access_time,
                ),

                buildStatCard(
                  title:
                      AppText.processing,
                  total:
                      processing
                          .toString(),
                  color: Colors.blue,
                  icon:
                      Icons.sync,
                ),

                buildStatCard(
                  title:
                      AppText.completed,
                  total:
                      completed
                          .toString(),
                  color:
                      Colors.green,
                  icon:
                      Icons.check_circle,
                ),

                buildStatCard(
                  title:
                      AppText.rejected,
                  total:
                      rejected
                          .toString(),
                  color: Colors.red,
                  icon: Icons.cancel,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // RECENT TITLE
            const Text(
              'Pengaduan Terbaru',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            complaints.isEmpty
                ? const Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(
                      20,
                    ),
                    child: Center(
                      child: Text(
                        AppText.noData,
                      ),
                    ),
                  ),
                )
                : Column(
                  children:
                      complaints.take(5).map((
                    item,
                  ) {
                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),

                      child: ListTile(
                        leading:
                            CircleAvatar(
                          backgroundColor:
                              AppColors
                                  .primary
                                  // ignore: deprecated_member_use
                                  .withOpacity(
                                    0.1,
                                  ),

                          child: const Icon(
                            Icons.report,
                            color:
                                AppColors
                                    .primary,
                          ),
                        ),

                        title: Text(
                          item['title'] ??
                              '-',
                        ),

                        subtitle: Text(
                          item['category']?['name'] ??
                              '-',
                        ),

                        trailing:
                            Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal:
                                10,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: Colors
                                .grey
                                // ignore: deprecated_member_use
                                .withOpacity(
                                  0.1,
                                ),

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Text(
                            item['status'] ??
                                '-',
                            style:
                                const TextStyle(
                              fontSize:
                                  12,
                            ),
                          ),
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

  Widget buildStatCard({
    required String title,
    required String total,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding:
          const EdgeInsets.all(18),

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
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          CircleAvatar(
            backgroundColor:
                // ignore: deprecated_member_use
                color.withOpacity(0.1),

            child: Icon(
              icon,
              color: color,
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

          const SizedBox(height: 5),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      dashboardContent(),
      const ComplaintListScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor:
          AppColors.background,

      body:
          loading
              ? const Center(
                child:
                    CircularProgressIndicator(),
              )
              : screens[selectedIndex],

      bottomNavigationBar:
          BottomNavigationBar(
            currentIndex:
                selectedIndex,

            selectedItemColor:
                AppColors.primary,

            onTap: (index) {
              setState(() {
                selectedIndex =
                    index;
              });
            },

            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                ),
                label: 'Dashboard',
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  Icons.report,
                ),
                label: 'Pengaduan',
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
              ),
            ],
          ),
    );
  }
}