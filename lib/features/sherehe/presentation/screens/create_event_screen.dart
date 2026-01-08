import 'dart:io';
import 'dart:typed_data';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart' as image_editor_options;
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import 'package:intl/intl.dart';
import '../../presentation/presentation.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final PageController _pageController = PageController();
  final ScrollController _stage3ScrollController = ScrollController();
  double _progress = 0.25;

  final _stage1FormKey = GlobalKey<FormState>();
  final _stage2FormKey = GlobalKey<FormState>();
  final _stage5FormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _locationController = TextEditingController();
  final _aboutController = TextEditingController();
  final _paybillNumberController = TextEditingController();
  final _accountReferenceController = TextEditingController();
  final _tillNumberController = TextEditingController();
  final _sendMoneyPhoneController = TextEditingController();
  PaymentTypes? _selectedPaymentType;
  DateTime? _selectedDateTime;
  File? _selectedPosterImage;
  File? _selectedBannerImage;
  File? _selectedCardImage;
  List<String> _selectedGenres = [];
  List<Ticket> _tickets = [];
  String? organizerId;
  String? organizerName;
  late ConfettiController _confettiController;
  bool get _isFreeEvent {
    return _tickets.length == 1 && _tickets.first.ticketPrice == 0;
  }

  @override
  void initState() {
    super.initState();
    final userState = context.read<ProfileBloc>().state;

    if (userState is ProfileLoadedState) {
      organizerId = userState.profile.id;
      organizerName = userState.profile.username;
    } else {
      organizerId = null;
    }
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateTimeController.dispose();
    _aboutController.dispose();
    _locationController.dispose();
    _paybillNumberController.dispose();
    _accountReferenceController.dispose();
    _tillNumberController.dispose();
    _sendMoneyPhoneController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (!context.mounted) return;
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          _selectedDateTime ?? DateTime.now(),
        ),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _dateTimeController.text = DateFormat.yMMMMEEEEd().add_jm().format(
            _selectedDateTime!,
          );
        });
      }
    }
  }

  Future<void> _pickBannerImage() async {
    try {
      final XFile? picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (picked == null) {
        setState(() => _selectedBannerImage = null);
        return;
      }

      final File originalImage = File(picked.path);
      final imageData = await originalImage.readAsBytes();
      if (!mounted) return;

      // Crop the image, locked to 16:9
      final Uint8List? croppedBytes = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageCropper(
            image: imageData,
            availableRatios: [
              image_editor_options.AspectRatio(title: "16:9", ratio: 16 / 9),
            ],
          ),
        ),
      );

      if (croppedBytes == null) {
        // User cancelled cropping
        setState(() => _selectedBannerImage = null);
        return;
      }

      final String croppedPath =
          '${originalImage.parent.path}/cropped_banner.jpg';
      final File croppedFile = await File(
        croppedPath,
      ).writeAsBytes(croppedBytes);

      // Compress cropped file
      final String targetPath =
          '${originalImage.parent.path}/compressed_banner.jpg';
      final XFile? compressedFile =
          await FlutterImageCompress.compressAndGetFile(
            croppedFile.path,
            targetPath,
            quality: 70,
            minWidth: 1024,
            minHeight: 1024,
          );

      setState(() {
        _selectedBannerImage = compressedFile != null
            ? File(compressedFile.path)
            : null;
      });
    } catch (e) {
      debugPrint("Error picking or cropping banner: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to process banner image")),
        );
      }
    }
  }

  Future<void> _pickPosterImage() async {
    try {
      final XFile? picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (picked == null) {
        setState(() => _selectedPosterImage = null);
        return;
      }

      final File originalImage = File(picked.path);
      final imageData = await originalImage.readAsBytes();
      if (!mounted) return;

      // Crop the image
      final Uint8List? croppedBytes = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImageCropper(image: imageData)),
      );

      if (croppedBytes == null) {
        setState(() => _selectedPosterImage = null);
        return;
      }

      final String croppedPath =
          '${originalImage.parent.path}/cropped_poster.jpg';
      final File croppedFile = await File(
        croppedPath,
      ).writeAsBytes(croppedBytes);

      // Compress cropped file
      final String targetPath =
          '${originalImage.parent.path}/compressed_poster.jpg';
      final XFile? compressedFile =
          await FlutterImageCompress.compressAndGetFile(
            croppedFile.path,
            targetPath,
            quality: 70,
            minWidth: 512,
            minHeight: 1024,
          );

      setState(() {
        _selectedPosterImage = compressedFile != null
            ? File(compressedFile.path)
            : null;
      });
    } catch (e) {
      debugPrint("Error picking or cropping poster: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to process poster image")),
        );
      }
    }
  }

  Future<void> _pickCardImage() async {
    try {
      final XFile? picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (picked == null) {
        setState(() => _selectedCardImage = null);
        return;
      }

      final File originalImage = File(picked.path);
      final imageData = await originalImage.readAsBytes();
      if (!mounted) return;

      final Uint8List? croppedBytes = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageCropper(
            image: imageData,
            availableRatios: [
              image_editor_options.AspectRatio(title: "1:1", ratio: 1 / 1),
            ],
          ),
        ),
      );

      if (croppedBytes == null) {
        setState(() => _selectedCardImage = null);
        return;
      }

      // Save cropped bytes to temporary file
      final String croppedPath =
          '${originalImage.parent.path}/cropped_card.jpg';
      final File croppedFile = await File(
        croppedPath,
      ).writeAsBytes(croppedBytes);

      // Compress the cropped file
      final String targetPath =
          '${originalImage.parent.path}/compressed_card.jpg';
      final XFile? compressedFile =
          await FlutterImageCompress.compressAndGetFile(
            croppedFile.path,
            targetPath,
            quality: 70,
            minWidth: 512,
            minHeight: 512,
          );

      setState(() {
        _selectedCardImage = compressedFile != null
            ? File(compressedFile.path)
            : null;
      });
    } catch (e) {
      debugPrint("Error picking or cropping card: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to process cardimage")),
        );
      }
    }
  }

  void _showGenreSelectionDialog() {
    List<String> tempSelectedGenres = List.from(_selectedGenres);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, StateSetter setStateDialog) {
            return AlertDialog.adaptive(
              title: const Text('Select Genres'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: availableGenres.map((genre) {
                    return CheckboxListTile(
                      value: tempSelectedGenres.contains(genre),
                      title: Text(genre),
                      onChanged: (bool? value) {
                        setStateDialog(() {
                          if (value == true) {
                            tempSelectedGenres.add(genre);
                          } else {
                            tempSelectedGenres.remove(genre);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
                FilledButton(
                  child: const Text('Done'),
                  onPressed: () {
                    setState(() {
                      _selectedGenres = List.from(tempSelectedGenres);
                    });
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _submitForm() {
    if (_selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date and time")),
      );
      return;
    }
    if (_selectedGenres.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one genre")),
      );
      return;
    }

    context.read<CreateEventBloc>().add(
      SubmitNewEvent(
        eventName: _nameController.text.trim(),
        eventDescription: _aboutController.text.trim(),
        eventLocation: _locationController.text.trim(),
        eventDate: _selectedDateTime!.toIso8601String(),
        organizerId: organizerId ?? "N/A",
        eventCardImage: _selectedCardImage,
        eventPosterImage: _selectedPosterImage,
        eventBannerImage: _selectedBannerImage,
        eventGenre: _selectedGenres,
        tickets: _tickets,
        selectedPaymentType: _selectedPaymentType,
        paybillNumber: _paybillNumberController.text.trim().isEmpty
            ? null
            : _paybillNumberController.text.trim(),
        accountReference: _accountReferenceController.text.trim().isEmpty
            ? null
            : _accountReferenceController.text.trim(),
        tillNumber: _tillNumberController.text.trim().isEmpty
            ? null
            : _tillNumberController.text.trim(),
        sendMoneyPhoneNumber: _sendMoneyPhoneController.text.trim().isEmpty
            ? null
            : _sendMoneyPhoneController.text.trim(),
      ),
    );
  }

  // Update progress based on the current page index
  void _updateProgress(int pageIndex) {
    setState(() {
      _progress = (pageIndex + 1) / _steps.length;
    });

    if (pageIndex == 2 && _stage3ScrollController.hasClients) {
      _stage3ScrollController.jumpTo(0);
    }
  }

  void _moveToNextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _moveToPreviousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.elasticOut,
    );
  }

  List<Widget Function()> get _steps {
    return [
      () => BasicEventDetailsPage(
        formKey: _stage1FormKey,
        nameController: _nameController,
        dateTimeController: _dateTimeController,
        locationController: _locationController,
        onSelectDateAndTime: () => _selectDateAndTime(context),
        onNext: () {
          if (_stage1FormKey.currentState!.validate()) {
            if (_selectedDateTime == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please select a date and time"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }
            _moveToNextPage();
          }
        },
        context: context,
      ),
      () => EventDescriptionPage(
        formKey: _stage2FormKey,
        aboutController: _aboutController,
        selectedGenres: _selectedGenres,
        onShowGenreSelectionDialog: _showGenreSelectionDialog,
        onGenreDeleted: (genre) {
          _selectedGenres.remove(genre);
        },
        onPrevious: _moveToPreviousPage,
        onNext: () {
          if (_stage2FormKey.currentState!.validate()) {
            if (_selectedGenres.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please select at least one genre"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }
            _moveToNextPage();
          }
        },
        context: context,
      ),
      () => ImageUploadPage(
        controller: _stage3ScrollController,
        selectedCardImage: _selectedCardImage,
        onPickCardImage: _pickCardImage,
        selectedBannerImage: _selectedBannerImage,
        onPickBannerImage: _pickBannerImage,
        selectedPosterImage: _selectedPosterImage,
        onPickPosterImage: _pickPosterImage,
        onPrevious: _moveToPreviousPage,
        onNext: () {
          _moveToNextPage();
        },
        context: context,
      ),
      () => TicketSelectionPage(
        initialTickets: _tickets,
        onContinue: (tickets) {
          setState(() {
            _tickets = tickets;
            _selectedPaymentType = null; // reset payment if tickets changed
          });

          _moveToNextPage();
        },
        onSkip: _moveToNextPage,
        onPrevious: _moveToPreviousPage,
      ),

      if (!_isFreeEvent)
        () => PaymentTypeSelectionPage(
          formKey: _stage5FormKey,
          paybillNumberController: _paybillNumberController,
          accountReferenceController: _accountReferenceController,
          tillNumberController: _tillNumberController,
          sendMoneyPhoneController: _sendMoneyPhoneController,
          selectedPaymentType: _selectedPaymentType,
          onPaymentTypeChanged: (type) {
            setState(() {
              _selectedPaymentType = type;

              _paybillNumberController.clear();
              _accountReferenceController.clear();
              _tillNumberController.clear();
              _sendMoneyPhoneController.clear();
            });
          },
          onPrevious: _moveToPreviousPage,
          onNext: () {
            if (_stage5FormKey.currentState!.validate()) {
              _moveToNextPage();
            }
          },
        ),

      () => Stage4ReviewAndSubmit(
        onSubmit: _submitForm,
        onPrevious: _moveToPreviousPage,
        userName: organizerName ?? "Unknown",
        context: context,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: true,
                      title: const Text("Create an event"),
                      pinned: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: LinearProgressIndicator(
                            value: _progress,
                            valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).colorScheme.primary,
                            ),
                            // backgroundColor: Theme.of(
                            //   context,
                            // ).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ];
                },
            body: BlocListener<CreateEventBloc, CreateEventState>(
              listener: (context, state) {
                if (state is CreateEventSuccess) {
                  _confettiController.play();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Event created successfully!"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  context.read<ShereheHomeBloc>().add(FetchAllEvents(page: 1));
                  if (context.canPop()) {
                    context.pop();
                  }
                } else if (state is CreateEventFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to create event: ${state.message}'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              child: SafeArea(
                minimum: const EdgeInsets.all(12),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: _updateProgress,
                      itemBuilder: (context, index) => _steps[index](),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.01,
              numberOfParticles: 100,
              maxBlastForce: 100,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
