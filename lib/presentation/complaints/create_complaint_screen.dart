import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/helper.dart';

import '../../data/services/category_service.dart';
import '../../data/repositories/complaint_repository.dart';

class CreateComplaintScreen
    extends StatefulWidget {
  const CreateComplaintScreen({
    super.key,
  });

  @override
  State<CreateComplaintScreen>
      createState() =>
          _CreateComplaintScreenState();
}

class _CreateComplaintScreenState
    extends State<CreateComplaintScreen> {
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

  bool loading = false;

  bool isAnonymous = false;

  List categories = [];

  int? selectedCategory;

  File? imageFile;

  @override
  void initState() {
    super.initState();

    getCategories();
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

  Future pickImage() async {
    final picker = ImagePicker();

    final picked =
        await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  Future submitComplaint() async {
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
        await repository.createComplaint(
      title: titleController.text,
      description:
          descriptionController.text,
      categoryId: selectedCategory!,
      location:
          locationController.text,
      isAnonymous: isAnonymous,
      attachment: imageFile?.path,
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (success) {
      Helper.successMessage(
        context,
        'Pengaduan berhasil dibuat',
      );

      Navigator.pop(context, true);
    } else {
      Helper.errorMessage(
        context,
        'Gagal membuat pengaduan',
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
          'Buat Pengaduan',
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

            SwitchListTile(
              value: isAnonymous,

              activeThumbColor:
                  AppColors.primary,

              title: const Text(
                'Kirim Sebagai Anonim',
              ),

              onChanged: (value) {
                setState(() {
                  isAnonymous = value;
                });
              },
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
              ),

            const SizedBox(height: AppSpacing.space3),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: pickImage,

                icon: const Icon(
                  Icons.image,
                ),

                label: const Text(
                  'Pilih Gambar',
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : submitComplaint,
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Kirim Pengaduan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}