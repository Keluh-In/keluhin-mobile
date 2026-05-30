import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';
import '../../data/repositories/complaint_repository.dart';
import '../complaints/complaint_list_screen.dart';
import '../profile/profile_screen.dart';

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
        unselectedItemColor: Colors.grey,
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
            backgroundColor: Colors.red,
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
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selamat Datang 👋',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'KELUH.IN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Total Pengaduan: ${complaints.length}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // STATISTIK TITLE
              const Text(
                'Statistik Pengaduan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // GRID STATISTIK
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.3,
                children: [
                  buildStatCard(
                    title: 'Menunggu',
                    total: waiting.toString(),
                    color: Colors.orange,
                    icon: Icons.access_time_rounded,
                  ),
                  buildStatCard(
                    title: 'Diproses',
                    total: processing.toString(),
                    color: Colors.blue,
                    icon: Icons.sync_rounded,
                  ),
                  buildStatCard(
                    title: 'Selesai',
                    total: completed.toString(),
                    color: Colors.green,
                    icon: Icons.check_circle_rounded,
                  ),
                  buildStatCard(
                    title: 'Ditolak',
                    total: rejected.toString(),
                    color: Colors.red,
                    icon: Icons.cancel_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // RECENT TITLE
              const Text(
                'Pengaduan Terbaru',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // LIST PENGADUAN TERBARU
              complaints.isEmpty
                  ? const SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: Text(
                              AppText.noData,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: complaints.take(5).map((item) {
                        final bool isSending = item['isSending'] ?? false;

                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(color: Colors.grey.withValues(alpha: 0.15)),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            leading: CircleAvatar(
                              backgroundColor: isSending 
                                  ? Colors.grey.shade100 
                                  : AppColors.primary.withValues(alpha: 0.1),
                              child: Icon(
                                Icons.assignment_outlined,
                                color: isSending ? Colors.grey : AppColors.primary,
                              ),
                            ),
                            title: Text(
                              item['title'] ?? '-',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSending ? Colors.grey : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              item['category']?['name'] ?? item['description'] ?? '-',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: isSending
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.grey),
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      item['status'] ?? '-',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 20),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}