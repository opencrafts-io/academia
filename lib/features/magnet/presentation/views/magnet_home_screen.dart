import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MagnetHomeScreenAction {
  final String title;
  final String subtitle;
  final String assetImagePath;
  final VoidCallback ontap;

  MagnetHomeScreenAction({
    required this.title,
    required this.subtitle,
    required this.ontap,
    required this.assetImagePath,
  });
}

class MagnetHomeScreen extends StatelessWidget {
  const MagnetHomeScreen({super.key, required this.institutionID});

  final int institutionID;

  List<MagnetHomeScreenAction> get _magnetHomeScreenActions {
    return [
      MagnetHomeScreenAction(
        title: "School profile",
        subtitle: "View and manage your school profile",
        ontap: () {},
        assetImagePath: "assets/illustrations/authenticate.jpg",
      ),
      MagnetHomeScreenAction(
        title: "Classes",
        subtitle: "Never miss a class",
        ontap: () {},
        assetImagePath: "assets/illustrations/classes.jpg",
      ),
      MagnetHomeScreenAction(
        title: "Your grades",
        subtitle: "Check your grades",
        ontap: () {},
        assetImagePath: "assets/illustrations/grades.jpg",
      ),
      MagnetHomeScreenAction(
        title: "Fees statements",
        subtitle: "Your finances simplified",
        ontap: () {},
        assetImagePath: "assets/illustrations/school-fees.jpg",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        child: BlocBuilder<InstitutionBloc, InstitutionState>(
          builder: (context, state) {
            Institution? institution;

            if (state is InstitutionLoadedState) {
              institution = state.institutions.firstWhere(
                (ins) => ins.institutionId == institutionID,
              );
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(institution?.name ?? "Unknown"),
                      if (institution?.domains?.isNotEmpty ?? false)
                        Text(
                          institution!.domains!.first,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        // context.read<InstitutionBloc>().add(
                        //   LoadInstitutionEvent(),
                        // );
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: _magnetHomeScreenActions.length,
                    itemBuilder: (context, index) {
                      final item = _magnetHomeScreenActions[index];
                      return Card.outlined(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: item.ontap,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  item.assetImagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.subtitle,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Hello
                SliverPadding(
                  padding: EdgeInsets.all(12),
                  sliver: MultiSliver(
                    children: [
                      Card.outlined(
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          trailing: Icon(Icons.open_in_new),
                          title: Text("Visit Institution's Official Site"),
                          onTap: () {},
                        ),
                      ),

                      SizedBox(height: 22),
                      Text(
                        "Hello",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

