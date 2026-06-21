import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
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

  File? imageFile;

  @override
  void initState() {
    super.initState();

    setData();

    getCategories();
  }

  Future pickImage() async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
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

      attachment: imageFile?.path,
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
    // Border/radius mengikuti inputDecorationTheme (token radius-md).
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
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
            const EdgeInsets.all(AppSpacing.space5),

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

            const SizedBox(height: AppSpacing.space5),

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

            const SizedBox(height: AppSpacing.space5),

            TextField(
              controller:
                  descriptionController,

              maxLines: 5,

              decoration: decoration(
                'Deskripsi',
                Icons.description,
              ),
            ),

            const SizedBox(height: AppSpacing.space5),

            TextField(
              controller:
                  locationController,

              decoration: decoration(
                'Lokasi',
                Icons.location_on,
              ),
            ),

            const SizedBox(height: AppSpacing.space5),

            // IMAGE
            if (imageFile != null)
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppRadius.lg),
                child: Image.file(
                  imageFile!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else if (widget.complaint['image_url'] != null)
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppRadius.lg),
                child: Image.network(
                  widget.complaint['image_url'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: AppColors.ink100,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: AppColors.ink400,
                      ),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: AppSpacing.space3),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Ganti Gambar'),
              ),
            ),

            const SizedBox(height: AppSpacing.space8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : updateComplaint,
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Update Pengaduan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}