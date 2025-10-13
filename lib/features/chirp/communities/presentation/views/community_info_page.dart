import 'package:academia/features/chirp/communities/communities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CommunityInfoPage extends StatelessWidget {
  final int communityId;
  const CommunityInfoPage({super.key, required this.communityId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityHomeBloc, CommunityHomeState>(
      builder: (context, state) {
        if (state is CommunityHomeLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is CommunityHomeLoaded) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(),
                SliverPadding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  sliver: MultiSliver(
                    children: [
                      CircleAvatar(radius: 60),
                      SizedBox(height: 12),
                      Text(
                        state.community.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 8),
                      Text(
                        state.community.description ??
                            'No description available',
                        // style: Theme.of(context).textTheme.bodySmall,
                      ),

                      SizedBox(height: 8),
                      Divider(height: 0.5),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Card(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(22),
                              child: Text(
                                state.community.memberCount.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Card.filled(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Creator"),
                            ListTile(
                              leading: CircleAvatar(),
                              title: Text("hello"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 160,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.orange,
                        ),
                      ),

                      SizedBox(height: 22),
                      Text(state.community.visibility),

                      Text(state.community.verified.toString()),

                      Card.filled(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        clipBehavior: Clip.hardEdge,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: CheckboxListTile(
                          value: true,
                          onChanged: (value) {},
                          title: Text("Visibility"),
                        ),
                      ),
                      SizedBox(height: 22),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.edit),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
