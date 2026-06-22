import 'package:flutter/material.dart';
import 'package:Keluhin/core/constants/app_colors.dart';
import 'package:Keluhin/core/constants/app_spacing.dart';
import 'package:Keluhin/core/constants/app_text.dart';

import '../../data/repositories/complaint_repository.dart';

import '../widgets/complaint_card.dart';
import 'complaint_detail_screen.dart';
import 'create_complaint_screen.dart';

class ComplaintListScreen extends StatefulWidget {
  const ComplaintListScreen({super.key});

  @override
  State<ComplaintListScreen> createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  final ComplaintRepository repository = ComplaintRepository();

  List complaints = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    getComplaints();
  }

  Future getComplaints() async {
    try {
      final data = await repository.getComplaints();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(elevation: 0, title: const Text(AppText.complaints)),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : complaints.isEmpty
          ? const Center(child: Text(AppText.noData))
          : RefreshIndicator(
              onRefresh: () => getComplaints(),
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.space4),
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  final item = complaints[index];

                  return ComplaintCard(
                    complaint: Map<String, dynamic>.from(item),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ComplaintDetailScreen(complaintId: item['id']),
                        ),
                      );

                      if (result == true) {
                        getComplaints();
                      }
                    },
                  );
                },
              ),
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateComplaintScreen()),
          );

          if (result == true) {
            getComplaints();
          }
        },
      ),
    );
  }
}
