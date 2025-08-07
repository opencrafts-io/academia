import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
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
  final _urlController = TextEditingController();
  DateTime? _selectedDateTime;
  File? _selectedImage;
  List<String> _selectedGenres = [];

  final List<String> _availableGenres = [
    'Meetup', 'Party', 'Official', 'Physical', 'Social', 'Sports',
    'Conference', 'Workshop', 'Seminar', 'Webinar', 'Festival', 'Exhibition',
    'Charity', 'Gaming', 'Music', 'Arts & Culture', 'Food & Drink',
    'Networking', 'Education', 'Technology', 'Health & Wellness', 'Other'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _dateTimeController.dispose();
    _aboutController.dispose();
    _locationController.dispose();
    _urlController.dispose();
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
      }
    );
    if (!context.mounted) return;
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
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
        }
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year, pickedDate.month, pickedDate.day,
            pickedTime.hour, pickedTime.minute,
          );
          _dateTimeController.text = _formatDateTime(_selectedDateTime!);
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showGenreSelectionDialog() {
    List<String> tempSelectedGenres = List.from(_selectedGenres);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(builder: (context, StateSetter setStateDialog) {
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
        });
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
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an event image")),
        );
        return;
      }
      if (_selectedGenres.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select at least one genre")),
        );
        return;
      }
      if (_urlController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a URL for a user to learn more")),
        );
        return;
      }

      final parts = _dateTimeController.text.split(' ');
      final datePart = parts[0];
      final timePart = parts[1];

      final event = Event(
        id: '',
        name: _nameController.text.trim(),
        description: _aboutController.text.trim(),
        url: _urlController.text.trim(),
        location: _locationController.text.trim(),
        time: timePart,
        date: datePart,
        organizer: 'PornHub', //Pull this from Verisafe
        imageUrl: '',
        organizerId: '696969', // Pull from Verisafe
        numberOfAttendees: 1,
        genre: _selectedGenres,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      context.read<CreateEventBloc>().add(SubmitNewEvent(event: event, imageFile: _selectedImage));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields correctly")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Event',
         style: TextStyle(fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      body: BlocListener<CreateEventBloc, CreateEventState>(
        listener: (context, state) {
          if (state is CreateEventSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Event created successfully!")),
            );
            final eventBloc = context.read<EventBloc>();
            eventBloc.add(FetchAllEvents());

            if (context.canPop()) {
              context.pop();
            }
          } else if (state is CreateEventFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to create event: ${state.message}')),
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
                      selectedImage: _selectedImage,
                      onTap: _pickImage,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: buildModernInputDecoration(context: context, labelText: 'Event Name', hintText: 'Enter the name of your event'),
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
                    TextFormField(
                      readOnly: true,
                      controller: _dateTimeController,
                      decoration: buildModernInputDecoration(
                        context: context,
                        labelText: 'Date & Time',
                        hintText: 'Select date and time',
                        suffixIcon: Icon(Icons.calendar_today_outlined, color: Theme.of(context).colorScheme.primary),
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
                      decoration: buildModernInputDecoration(context: context, labelText: 'Location', hintText: 'e.g., Conference Hall A'),
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
                      decoration: buildModernInputDecoration(context: context, labelText: 'About Event', hintText: 'Tell us more about your event...'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please provide details about the event';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _urlController,
                      maxLines: 4,
                      minLines: 2,
                      decoration: buildModernInputDecoration(context: context, labelText: 'Event URL', hintText: 'Input an event URL'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please provide a url for the event';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<CreateEventBloc, CreateEventState>(
                      builder: (context, state) {
                        if (state is CreateEventLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: _submitForm,
                          child: const Text('Create Event', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () => context.pop(),
                        child: Text('Cancel', style: TextStyle(color: Theme.of(context).hintColor)),
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
    );
  }
}
