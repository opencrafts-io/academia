import 'dart:io';
import 'package:academia/features/sherehe/sherehe.dart';
import 'package:flutter/material.dart';


class CreateEventPageBuilder extends StatelessWidget {
  final int pageIndex;
  final GlobalKey<FormState> stage1FormKey;
  final GlobalKey<FormState> stage2FormKey;
  final TextEditingController nameController;
  final TextEditingController dateTimeController;
  final TextEditingController locationController;
  final TextEditingController aboutController;
  final List<String> selectedGenres;
  final VoidCallback onSelectDateAndTime;
  final VoidCallback moveToNextPage;
  final VoidCallback moveToPreviousPage;
  final VoidCallback showGenreSelectionDialog;
  final ScrollController stage3ScrollController;
  final File? selectedCardImage;
  final File? selectedBannerImage;
  final File? selectedPosterImage;
  final VoidCallback pickCardImage;
  final VoidCallback pickBannerImage;
  final VoidCallback pickPosterImage;
  final VoidCallback submitForm;
  final DateTime? selectedDateTime;
  final String? organizerName;
  final BuildContext context;

  const CreateEventPageBuilder({
    super.key,
    required this.pageIndex,
    required this.stage1FormKey,
    required this.stage2FormKey,
    required this.nameController,
    required this.dateTimeController,
    required this.locationController,
    required this.aboutController,
    required this.selectedGenres,
    required this.onSelectDateAndTime,
    required this.moveToNextPage,
    required this.moveToPreviousPage,
    required this.showGenreSelectionDialog,
    required this.stage3ScrollController,
    required this.selectedCardImage,
    required this.selectedBannerImage,
    required this.selectedPosterImage,
    required this.pickCardImage,
    required this.pickBannerImage,
    required this.pickPosterImage,
    required this.submitForm,
    required this.selectedDateTime,
    required this.organizerName,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    switch (pageIndex) {
      case 0:
        return BasicEventDetailsPage(
          formKey: stage1FormKey,
          nameController: nameController,
          dateTimeController: dateTimeController,
          locationController: locationController,
          onSelectDateAndTime: onSelectDateAndTime,
          onNext: () {
            if (stage1FormKey.currentState!.validate()) {
              if (selectedDateTime == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select a date and time"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              moveToNextPage();
            }
          },
          context: context,
        );

      case 1:
        return EventDescriptionPage(
          formKey: stage2FormKey,
          aboutController: aboutController,
          selectedGenres: selectedGenres,
          onShowGenreSelectionDialog: showGenreSelectionDialog,
          onGenreDeleted: (genre) {
            selectedGenres.remove(genre);
          },
          onPrevious: moveToPreviousPage,
          onNext: () {
            if (stage2FormKey.currentState!.validate()) {
              if (selectedGenres.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select at least one genre"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              moveToNextPage();
            }
          },
          context: context,
        );

      case 2:
        return ImageUploadPage(
          controller: stage3ScrollController,
          selectedCardImage: selectedCardImage,
          onPickCardImage: pickCardImage,
          selectedBannerImage: selectedBannerImage,
          onPickBannerImage: pickBannerImage,
          selectedPosterImage: selectedPosterImage,
          onPickPosterImage: pickPosterImage,
          onPrevious: moveToPreviousPage,
          onNext: () {
            if (selectedPosterImage == null ||
                selectedBannerImage == null ||
                selectedCardImage == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please select all required images"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }
            moveToNextPage();
          },
          context: context,
        );

      case 3:
        return Stage4ReviewAndSubmit(
          onSubmit: submitForm,
          onPrevious: moveToPreviousPage,
          userName: organizerName ?? "Unknown",
          context: context,
        );

      default:
        return const Center(child: Text("Page Not Found"));
    }
  }
}
