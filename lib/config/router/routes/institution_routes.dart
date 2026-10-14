part of '../routes.dart';

@TypedGoRoute<LinkInstitutionRequiredPageRoute>(
  path: '/link-institution-required',
)
class LinkInstitutionRequiredPageRoute extends GoRouteData
    with $LinkInstitutionRequiredPageRoute {
  const LinkInstitutionRequiredPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LinkInstitutionRequiredPage();
}
