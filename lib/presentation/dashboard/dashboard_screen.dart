import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_elevation.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text.dart';
import '../../core/constants/app_typography.dart';
import '../../data/repositories/complaint_repository.dart';
import '../complaints/complaint_list_screen.dart';
import '../profile/profile_screen.dart';
import '../widgets/status_badge.dart';

// =========================================================================
// MAIN CONTAINER SCREEN (Mengontrol navigasi tab bawah dengan IndexedStack)
// =========================================================================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardContentTab(), // Tab 0: Konten Utama Dashboard & Statistik
    const ComplaintListScreen(),  // Tab 1: Halaman Daftar Pengaduan
    const ProfileScreen(),        // Tab 2: Halaman Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.ink400,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: 'Pengaduan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// DASHBOARD CONTENT TAB (Mengelola Logika Data Kebutuhan Instan & Cepat)
// =========================================================================
class DashboardContentTab extends StatefulWidget {
  const DashboardContentTab({super.key});

  @override
  State<DashboardContentTab> createState() => _DashboardContentTabState();
}

class _DashboardContentTabState extends State<DashboardContentTab> {
  final ComplaintRepository repository = ComplaintRepository();
  
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

  Future<void> getDashboardData() async {
    try {
      final data = await repository.getComplaints();
      
      if (mounted) {
        calculateStatus(data);
        setState(() {
          complaints = data;
          loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  // 🚀 FUNGSI FIX: Menyesuaikan parameter wajib dari ComplaintRepository
  Future<void> uploadPengaduanInstan({
    required String title,
    required String description,
    required int categoryId,
    required String location,
    required bool isAnonymous,
    String categoryName = 'Umum',
  }) async {
    // Buat objek pengaduan tiruan sementara untuk UI lokal
    final temporaryComplaint = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'description': description,
      'status': AppText.waiting,
      'category': {'name': categoryName},
      'location': location,
      'is_anonymous': isAnonymous,
      'isSending': true,
    };

    // LANGKAH 1: Langsung masukkan ke UI tanpa nunggu API Laragon merespon
    setState(() {
      complaints.insert(0, temporaryComplaint);
      calculateStatus(complaints);
    });

    try {
      // LANGKAH 2: Kirim asli ke server menggunakan named parameters sesuai kebutuhan repository
      final serverResult = await repository.createComplaint(
        title: title,
        description: description,
        categoryId: categoryId,
        location: location,
        isAnonymous: isAnonymous,
      );
      
      // LANGKAH 3: Jika sukses, ganti data tiruan tadi dengan data asli dari database
      if (mounted) {
        setState(() {
          int index = complaints.indexWhere((element) => element['id'] == temporaryComplaint['id']);
          if (index != -1) {
            complaints[index] = serverResult;
          }
        });
      }
    } catch (e) {
      // LANGKAH 4: Jika server error/gagal koneksi, batalkan dan kembalikan statistik
      if (mounted) {
        setState(() {
          complaints.removeWhere((element) => element['id'] == temporaryComplaint['id']);
          calculateStatus(complaints);
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Koneksi terputus atau backend error! Pengaduan gagal diupload.'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  void calculateStatus(List data) {
    waiting = data.where((item) => item['status'] == AppText.waiting).length;
    processing = data.where((item) => item['status'] == AppText.processing).length;
    completed = data.where((item) => item['status'] == AppText.completed).length;
    rejected = data.where((item) => item['status'] == AppText.rejected).length;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.primary,
      //   child: const Icon(Icons.add_comment_rounded, color: Colors.white),
      //   onPressed: () {
      //     // Simulasi memicu fungsi kirim instan dengan Named Arguments yang valid
      //     uploadPengaduanInstan(
      //       title: 'Fasilitas Rusak di Lab',
      //       description: 'Pendingin ruangan mati membuat ruangan pengap.',
      //       categoryId: 1,
      //       location: 'Gedung Laboratorium Komputer lantai 2',
      //       isAnonymous: false,
      //       categoryName: 'Infrastruktur',
      //     );
      //   },
      // ),
      body: RefreshIndicator(
        onRefresh: () => getDashboardData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space5,
            AppSpacing.space12,
            AppSpacing.space5,
            AppSpacing.space5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.space6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang 👋',
                      style: AppTypography.body.copyWith(color: AppColors.blue100),
                    ),
                    const SizedBox(height: AppSpacing.space2),
                    // Wordmark logo — satu-satunya pengecualian Bold (700).
                    Text(
                      'KELUH.IN',
                      style: AppTypography.heading1.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space3,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Text(
                        'Total Pengaduan: ${complaints.length}',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.space8),

              // STATISTIK TITLE
              Text(
                'Statistik Pengaduan',
                style: AppTypography.heading3,
              ),
              const SizedBox(height: AppSpacing.space4),

              // GRID STATISTIK
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: AppSpacing.space3,
                mainAxisSpacing: AppSpacing.space3,
                childAspectRatio: 1.3,
                children: [
                  buildStatCard(
                    title: 'Menunggu',
                    total: waiting.toString(),
                    color: AppColors.warning,
                    icon: Icons.access_time_rounded,
                  ),
                  buildStatCard(
                    title: 'Diproses',
                    total: processing.toString(),
                    color: AppColors.info,
                    icon: Icons.sync_rounded,
                  ),
                  buildStatCard(
                    title: 'Selesai',
                    total: completed.toString(),
                    color: AppColors.success,
                    icon: Icons.check_circle_rounded,
                  ),
                  buildStatCard(
                    title: 'Ditolak',
                    total: rejected.toString(),
                    color: AppColors.danger,
                    icon: Icons.cancel_rounded,
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.space8),

              // RECENT TITLE
              Text(
                'Pengaduan Terbaru',
                style: AppTypography.heading3,
              ),
              const SizedBox(height: AppSpacing.space4),

              // LIST PENGADUAN TERBARU
              complaints.isEmpty
                  ? SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.space6),
                          child: Center(
                            child: Text(
                              AppText.noData,
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.ink500),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: complaints.take(5).map((item) {
                        final bool isSending = item['isSending'] ?? false;

                        return Card(
                          margin: const EdgeInsets.only(bottom: AppSpacing.space3),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.space4,
                              vertical: AppSpacing.space1,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: isSending
                                  ? AppColors.ink100
                                  : AppColors.primary.withValues(alpha: 0.1),
                              child: Icon(
                                Icons.assignment_outlined,
                                color: isSending
                                    ? AppColors.ink400
                                    : AppColors.primary,
                              ),
                            ),
                            title: Text(
                              item['title'] ?? '-',
                              style: AppTypography.body.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isSending
                                    ? AppColors.ink400
                                    : AppColors.ink900,
                              ),
                            ),
                            subtitle: Text(
                              item['category']?['name'] ?? item['description'] ?? '-',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.ink500),
                            ),
                            trailing: isSending
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.ink400,
                                    ),
                                  )
                                : StatusBadge(status: item['status'] ?? '-'),
                          ),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: AppSpacing.space5),
            ],
          ),
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
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: AppElevation.shadow1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(
            total,
            style: AppTypography.heading2,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: AppTypography.caption.copyWith(color: AppColors.ink500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}