import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/event_card.dart';

class ShereheHome extends StatefulWidget {
  const ShereheHome({super.key});

  @override
  State<ShereheHome> createState() => _ShereheHomeState();
}

class _ShereheHomeState extends State<ShereheHome> {
  final events = [
    {
      "imagePath": 'assets/images/gaelle-marcel-vrkSVpOwchk-unsplash.jpg',
      "title": 'Gender Reveal Party',
      "location": 'Kryptons Apartments, Athi River',
      "date": 'Sat, Jul 20',
      "time": '2:00 PM',
    },
    {
      "imagePath": 'assets/images/scott-warman-rrYF1RfotSM-unsplash.jpg',
      "title": 'Cocktail Thursday',
      "location": 'Pine Breeze Gateway, Athi River',
      "date": 'Thu, Jul 25',
      "time": '7:30 PM',
    },
    {
      "imagePath": 'assets/images/lee-blanchflower-1dW1vEJLlCQ-unsplash.jpg',
      "title": 'Freshas Night',
      "location": 'Sabina Joy, Nairobi CBD',
      "date": 'Fri, Jul 26',
      "time": '9:00 PM',
    },
    {
      "imagePath": 'assets/images/al-elmes-ULHxWq8reao-unsplash.jpg',
      "title": 'Beach Festival',
      "location": 'Heri Homes, Athi River',
      "date": 'Sun, Aug 4',
      "time": '12:00 PM',
    },
    {
      "imagePath": 'assets/images/lavi-perchik-FCPV_n0lOxc-unsplash.jpg',
      "title": 'Singles Night',
      "location": 'Nairobi Street Kitchen, Westlands',
      "date": 'Fri, Aug 9',
      "time": '8:00 PM',
    },
    {
      "imagePath": 'assets/images/med-mhamdi-mH_E0K581Yk-unsplash.jpg',
      "title": 'AfroBeats Night',
      "location": 'Captains Lounge, Mombasa Rd',
      "date": 'Sat, Aug 10',
      "time": '10:00 PM',
    },
  ];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/diversity.jpg',
                fit: BoxFit.cover,
              ),
              title: Text("Sherehe"),
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
          // SliverToBoxAdapter(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 16.0,
          //           vertical: 8.0,
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               'Trending Events',
          //               style: theme.textTheme.headlineSmall?.copyWith(
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             TextButton(
          //               onPressed: () {},
          //               child: Text(
          //                 "View all",
          //                 style: theme.textTheme.labelLarge,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       CarouselSlider(
          //         options: CarouselOptions(
          //           height: 400.0,
          //           enlargeCenterPage: true,
          //           enableInfiniteScroll: false,
          //           viewportFraction: 0.8,
          //         ),
          //         items: [
          //           EventCard(
          //             imagePath:
          //                 'assets/images/gaelle-marcel-vrkSVpOwchk-unsplash.jpg',
          //             title: 'Gender Reveal Party',
          //             location: 'Kryptons Apartments, Athi River',
          //             date: 'Sat, Jul 20',
          //             time: '2:00 PM',
          //           ),
          //           EventCard(
          //             imagePath:
          //                 'assets/images/scott-warman-rrYF1RfotSM-unsplash.jpg',
          //             title: 'Cocktail Thursday',
          //             location: 'Pine Breeze Gateway, Athi River',
          //             date: 'Thu, Jul 25',
          //             time: '7:30 PM',
          //           ),
          //           EventCard(
          //             imagePath:
          //                 'assets/images/lee-blanchflower-1dW1vEJLlCQ-unsplash.jpg',
          //             title: 'Freshas Night',
          //             location: 'Sabina Joy, Nairobi CBD',
          //             date: 'Fri, Jul 26',
          //             time: '9:00 PM',
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index == 0) {
                  return Text(
                    'Upcoming Events',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }

                final  event = events[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12.0,
                  ), // space between cards
                  child: EventCard(
                    imagePath: event['imagePath'] ?? "Unknown Image",
                    title: event['title'] ?? "Unknown title",
                    location: event['location'] ?? "Unknown Location",
                    date: event['date'] ?? "Unknown date",
                    time: event['time'] ?? "Unknown time",
                  ),
                );
              }, childCount: events.length + 1),
            ),
          ),
        ],
      ),
    );
  }
}
