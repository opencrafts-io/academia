import 'package:academia/config/config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/constants/constants.dart';
import '../widgets/event_card.dart';

class ShereheHome extends StatefulWidget {
  const ShereheHome({super.key});

  @override
  State<ShereheHome> createState() => _ShereheHomeState();
}

class _ShereheHomeState extends State<ShereheHome> {
  final List<Map<String, dynamic>> events = [
    {
      "imagePath": 'assets/images/gaelle-marcel-vrkSVpOwchk-unsplash.jpg',
      "title": 'Gender Reveal Party',
      "location": 'Kryptons Apartments, Athi River',
      "date": 'Sat, Jul 20',
      "time": '2:00 PM',
      "attendees": ['Alice Mwende', 'Brian Kimani', 'Cynthia Otieno'],
      "attendeesCount": 23,
      "genres": ['Family', 'Celebration', 'Casual'],
    },
    {
      "imagePath": 'assets/images/scott-warman-rrYF1RfotSM-unsplash.jpg',
      "title": 'Cocktail Thursday',
      "location": 'Pine Breeze Gateway, Athi River',
      "date": 'Thu, Jul 25',
      "time": '7:30 PM',
      "attendees": ['David Wanjiru', 'Emily Kihara', 'Felix Oloo'],
      "attendeesCount": 58,
      "genres": ['Social', 'Networking', 'Drinks'],
    },
    {
      "imagePath": 'assets/images/lee-blanchflower-1dW1vEJLlCQ-unsplash.jpg',
      "title": 'Freshas Night',
      "location": 'Sabina Joy, Nairobi CBD',
      "date": 'Fri, Jul 26',
      "time": '9:00 PM',
      "attendees": ['Grace Njeri', 'Hassan Omar', 'Irene Mutiso'],
      "attendeesCount": 120,
      "genres": ['Party', 'Dance', 'University'],
    },
    {
      "imagePath": 'assets/images/al-elmes-ULHxWq8reao-unsplash.jpg',
      "title": 'Beach Festival',
      "location": 'Heri Homes, Athi River',
      "date": 'Sun, Aug 4',
      "time": '12:00 PM',
      "attendees": ['James Kariuki', 'Kendi Muthoni', 'Leonard Mwangi'],
      "attendeesCount": 87,
      "genres": ['Outdoor', 'Festival', 'Music'],
    },
    {
      "imagePath": 'assets/images/lavi-perchik-FCPV_n0lOxc-unsplash.jpg',
      "title": 'Singles Night',
      "location": 'Nairobi Street Kitchen, Westlands',
      "date": 'Fri, Aug 9',
      "time": '8:00 PM',
      "attendees": ['Miriam Wambui', 'Nathan Njenga', 'Olivia Adhiambo'],
      "attendeesCount": 43,
      "genres": ['Dating', 'Party', 'Social'],
    },
    {
      "imagePath": 'assets/images/med-mhamdi-mH_E0K581Yk-unsplash.jpg',
      "title": 'AfroBeats Night',
      "location": 'Captains Lounge, Mombasa Rd',
      "date": 'Sat, Aug 10',
      "time": '10:00 PM',
      "attendees": ['Peter Ndungu', 'Queenie Muli', 'Raymond Kipkoech'],
      "attendeesCount": 76,
      "genres": ['Music', 'Dance', 'Nightlife'],
    },
  ];

  int _getCrossAxisCount(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) {
      return 1;
    } else if (ResponsiveBreakPoints.isTablet(context)) {
      return 2;
    } else {
      return 3;
    }
  }

  double _getMainAxisExtent(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) {
      return 440;
    } else if (ResponsiveBreakPoints.isTablet(context)) {
      return 600;
    } else if (ResponsiveBreakPoints.isDesktop(context)) {
      return 700;
    } else {
      return 800; // large desktop
    }
  }

  double _getAppBarHeight(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) {
      return 200;
    } else if (ResponsiveBreakPoints.isTablet(context)) {
      return 300;
    } else if (ResponsiveBreakPoints.isDesktop(context)) {
      return 350;
    } else {
      return 400; // large desktop
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: _getAppBarHeight(context),
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text("Sherehe"),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/diversity.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withValues(
                      alpha: 0.4,
                    )
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      'Find Your Vibe',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search events, places...',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      // Clear search logic to be implemented later
                    },
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Text(
                'Upcoming Events',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: 0.7,
                mainAxisExtent: _getMainAxisExtent(context),
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final event = events[index];
                return EventCard(
                  imagePath: event['imagePath'],
                  title: event['title'],
                  location: event['location'],
                  date: event['date'],
                  time: event['time'],
                  genres: List<String>.from(event['genres']),
                  attendees: List<String>.from(event['attendees']),
                  attendeesCount: event['attendeesCount'],
                  onTap: () => ShereheDetailsRoute().push(context),
                );
              }, childCount: events.length),
            ),
          ),
        ],
      ),
    );
  }
}
