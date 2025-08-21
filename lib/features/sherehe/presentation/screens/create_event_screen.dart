import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/profile/domain/domain.dart';
import 'package:academia/injection_container.dart';
import 'package:confetti/confetti.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _locationController = TextEditingController();
  final _aboutController = TextEditingController();
  DateTime? _selectedDateTime;
  File? _selectedPosterImage;
  File? _selectedBannerImage;
  File? _selectedCardImage;
  List<String> _selectedGenres = [];
  final List<String> _availableGenres = [
    'Meetup', 'Party', 'Official', 'Physical', 'Social', 'Sports', 'Conference',
    'Workshop', 'Seminar', 'Webinar', 'Festival', 'Exhibition', 'Charity',
    'Gaming', 'Music', 'Arts & Culture', 'Food & Drink', 'Networking',
    'Education', 'Technology', 'Health & Wellness', 'Other',
  ];
  UserProfile? _userProfile;
  bool _isLoadingProfile = true;
  String? _profileLoadError;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoadingProfile = true;
      _profileLoadError = null;
    });

    try {
      final profileUseCase = sl<GetCachedProfileUsecase>();
      final result = await profileUseCase(NoParams());
      await result.fold(
            (failure) async {
          String errorMessage = 'Could not load profile data.';
          if (failure is CacheFailure) {
            errorMessage = 'Failed to load profile from cache: ${failure.message}';
          } else if (failure is NoDataFoundFailure) {
            errorMessage = 'No profile found. Please create your profile first.';
          } else if (failure is ServerFailure) {
            errorMessage = 'Server error loading profile: ${failure.message}';
          } else {
            errorMessage = 'An unexpected error occurred while loading profile: ${failure.toString()}';
          }
          debugPrint("Profile Load Error: $errorMessage");
          debugPrint("Failure details: ${failure.toString()}");

          setState(() {
            _isLoadingProfile = false;
            _profileLoadError = errorMessage;
          });
        },
            (profile) async {
          setState(() {
            _userProfile = profile;
            _isLoadingProfile = false;
            _profileLoadError = null;
          });
        },
      );
    } catch (e, stackTrace) {
      debugPrint("Unexpected error in _loadUserProfile: $e");
      debugPrintStack(stackTrace: stackTrace);
      setState(() {
        _isLoadingProfile = false;
        _profileLoadError = 'An unexpected error occurred while loading your profile.';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateTimeController.dispose();
    _aboutController.dispose();
    _locationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    final date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    final time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return '$date $time';
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext dialogContext, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(),
            dialogTheme: Theme.of(context).dialogTheme.copyWith(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (!context.mounted) return;
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          _selectedDateTime ?? DateTime.now(),
        ),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(),
              dialogTheme: Theme.of(context).dialogTheme.copyWith(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            child: child!,
          );
        },
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
          _dateTimeController.text = _formatDateTime(_selectedDateTime!);
        });
      }
    }
  }

  Future<void> _pickPosterImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _selectedPosterImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickBannerImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _selectedBannerImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickCardImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _selectedCardImage = File(pickedFile.path);
      });
    }
  }

  void _showGenreSelectionDialog() {
    List<String> tempSelectedGenres = List.from(_selectedGenres);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, StateSetter setStateDialog) {
            return AlertDialog(
              title: const Text('Select Genres'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: _availableGenres.map((genre) {
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
                TextButton(
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
    if (_formKey.currentState!.validate()) {
      if (_selectedDateTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a date and time")),
        );
        return;
      }
      // Validate ALL required images
      if (_selectedPosterImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a poster image")),
        );
        return;
      }
      if (_selectedBannerImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a banner image (16:9)")),
        );
        return;
      }
      if (_selectedCardImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a card image (1:1)")),
        );
        return;
      }
      if (_selectedGenres.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select at least one genre")),
        );
        return;
      }
      if (_isLoadingProfile) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Still loading profile data, please wait."), backgroundColor: Colors.orange),
        );
        return;
      }
      if (_userProfile == null) {
        final errorMessage = _profileLoadError ?? "Profile data not loaded. Please try again or create your profile.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
        return;
      }

      final parts = _dateTimeController.text.split(' ');
      final datePart = parts[0];
      final timePart = parts[1];
      final defaultUrl = 'https://academia.opencrafts.io/${_userProfile!.email}';
      final event = Event(
        id: '',
        name: _nameController.text.trim(),
        description: _aboutController.text.trim(),
        url: defaultUrl,
        location: _locationController.text.trim(),
        time: timePart,
        date: datePart,
        organizer: _userProfile!.name,
        imageUrl: '',
        organizerId: _userProfile!.id.hashCode,
        numberOfAttendees: 1,
        genre: _selectedGenres,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        bannerImageUrl: '',
        posterImageUrl: '',
      );
      context.read<CreateEventBloc>().add(
        SubmitNewEvent(
          event: event,
          imageFile: _selectedPosterImage!,
          bannerImageFile: _selectedBannerImage!,
          cardImageFile: _selectedCardImage!,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields correctly"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar.large(title: const Text("Create an event")),
              SliverToBoxAdapter(
                child: BlocListener<CreateEventBloc, CreateEventState>(
                  listener: (context, state) {
                    if (state is CreateEventSuccess) {
                      _confettiController.play();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Event created successfully!"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      final eventBloc = context.read<ShereheHomeBloc>();
                      eventBloc.add(FetchAllEvents());
                      if (context.canPop()) {
                        context.pop();
                      }
                    } else if (state is CreateEventFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to create event: ${state.message}'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              EventImagePickerWidget(
                                selectedImage: _selectedCardImage,
                                onTap: _pickCardImage,
                                label: 'Card Image (1:1) *',
                              ),
                              const SizedBox(height: 20),
                              EventImagePickerWidget(
                                selectedImage: _selectedBannerImage,
                                onTap: _pickBannerImage,
                                label: 'Banner Image (16:9) *',
                              ),
                              const SizedBox(height: 20),
                              EventImagePickerWidget(
                                selectedImage: _selectedPosterImage,
                                onTap: _pickPosterImage,
                                label: 'Poster Image *',
                              ),
                              const SizedBox(height: 32),

                              TextFormField(
                                controller: _nameController,
                                decoration: buildModernInputDecoration(
                                  context: context,
                                  labelText: 'Event Name',
                                  hintText: 'Enter the name of your event',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter an event name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              GenreSelectorWidget(
                                selectedGenres: _selectedGenres,
                                onSelectGenresPressed: _showGenreSelectionDialog,
                                onGenreDeleted: (genre) {
                                  setState(() {
                                    _selectedGenres.remove(genre);
                                  });
                                },
                                screenContext: context,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                readOnly: true,
                                controller: _dateTimeController,
                                decoration: buildModernInputDecoration(
                                  context: context,
                                  labelText: 'Date & Time',
                                  hintText: 'Select date and time',
                                  suffixIcon: Icon(
                                    Icons.calendar_today_outlined,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                onTap: () => _selectDateAndTime(context),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a date and time';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _locationController,
                                decoration: buildModernInputDecoration(
                                  context: context,
                                  labelText: 'Location',
                                  hintText: 'e.g., Conference Hall A',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a location';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _aboutController,
                                maxLines: 4,
                                minLines: 2,
                                decoration: buildModernInputDecoration(
                                  context: context,
                                  labelText: 'About Event',
                                  hintText: 'Tell us more about your event...',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please provide details about the event';
                                  }
                                  return null;
                                },
                              ),
                              // Remove URL TextFormField
                              const SizedBox(height: 30),

                              if (_isLoadingProfile)
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(child: CircularProgressIndicator()),
                                )
                              else if (_profileLoadError != null)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(_profileLoadError!, style: const TextStyle(color: Colors.red)),
                                      TextButton(
                                        onPressed: _loadUserProfile,
                                        child: const Text("Retry Load Profile"),
                                      )
                                    ],
                                  ),
                                )
                              else if (_userProfile != null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      "Creating event as: ${_userProfile!.name}",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      textAlign: TextAlign.center, // Center the text
                                    ),
                                  ),

                              // --- Submit Button Section ---
                              BlocBuilder<CreateEventBloc, CreateEventState>(
                                builder: (context, state) {
                                  if (state is CreateEventLoading) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0), // Padding around loader
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  final isButtonDisabled = _isLoadingProfile ||
                                      _userProfile == null ||
                                      _selectedPosterImage == null ||
                                      _selectedBannerImage == null ||
                                      _selectedCardImage == null;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0), // Vertical padding
                                    child: FilledButton(
                                      onPressed: isButtonDisabled ? null : _submitForm,
                                      style: FilledButton.styleFrom(
                                        // Optional: Make disabled button style more distinct
                                        // backgroundColor: isButtonDisabled ? Theme.of(context).disabledColor : null,
                                        // foregroundColor: isButtonDisabled ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38) : null,
                                      ),
                                      child: const Text('Create Event'),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              // Optional: Center the pricing text
                              Center(
                                child: Text(
                                  "Posting events may be subject to changes. Please stay tuned for updates.",
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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