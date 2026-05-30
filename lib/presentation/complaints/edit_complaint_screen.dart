import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/helper.dart';

import '../../data/services/category_service.dart';
import '../../data/repositories/complaint_repository.dart';

class EditComplaintScreen
    extends StatefulWidget {
  final Map<String, dynamic>
  complaint;

  const EditComplaintScreen({
    super.key,
    required this.complaint,
  });

  @override
  State<EditComplaintScreen>
      createState() =>
          _EditComplaintScreenState();
}

class _EditComplaintScreenState
    extends State<EditComplaintScreen> {
  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final locationController =
      TextEditingController();

  final ComplaintRepository
  repository = ComplaintRepository();

  final CategoryService
  categoryService = CategoryService();

  List categories = [];

  int? selectedCategory;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    setData();

    getCategories();
  }

  void setData() {
    titleController.text =
        widget.complaint['title'];

    descriptionController.text =
        widget.complaint['description'];

    locationController.text =
        widget.complaint['location'];

    selectedCategory =
        widget
            .complaint['category']['id'];
  }

  Future getCategories() async {
    try {
      final data =
          await categoryService
              .getCategories();

      setState(() {
        categories = data;
      });
    } catch (e) {
      if (!mounted) return;

      Helper.errorMessage(
        context,
        'Gagal mengambil kategori',
      );
    }
  }

  Future updateComplaint() async {
    if (titleController.text.isEmpty ||
        descriptionController
            .text
            .isEmpty ||
        locationController.text
            .isEmpty ||
        selectedCategory == null) {
      Helper.errorMessage(
        context,
        'Semua field wajib diisi',
      );

      return;
    }

    setState(() {
      loading = true;
    });

    bool success =
        await repository.updateComplaint(
      id: widget.complaint['id'],

      title: titleController.text,

      description:
          descriptionController.text,

      categoryId: selectedCategory!,

      location:
          locationController.text,
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (success) {
      Helper.successMessage(
        context,
        'Pengaduan berhasil diperbarui',
      );

      Navigator.pop(context, true);
    } else {
      Helper.errorMessage(
        context,
        'Gagal update pengaduan',
      );
    }
  }

  InputDecoration decoration(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,

      prefixIcon: Icon(icon),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Edit Pengaduan',
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller:
                  titleController,

              decoration: decoration(
                'Judul',
                Icons.title,
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<int>(
              initialValue: selectedCategory,

              decoration: decoration(
                'Kategori',
                Icons.category,
              ),

              items:
                  categories.map((e) {
                    return DropdownMenuItem<
                      int
                    >(
                      value: e['id'],

                      child: Text(
                        e['name'],
                      ),
                    );
                  }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedCategory =
                      value;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  descriptionController,

              maxLines: 5,

              decoration: decoration(
                'Deskripsi',
                Icons.description,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  locationController,

              decoration: decoration(
                'Lokasi',
                Icons.location_on,
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed:
                    loading
                        ? null
                        : updateComplaint,

                child:
                    loading
                        ? const CircularProgressIndicator(
                          color:
                              Colors.white,
                        )
                        : const Text(
                          'Update Pengaduan',
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}