library;

export 'src/domain/profile_repository.dart';
export 'src/domain/user_profile.dart';
export 'src/domain/usecases.dart';
export 'src/data/profile_local_datasource.dart';
export 'src/data/profile_remote_datasource.dart';
export 'src/data/profile_repository_impl.dart';
export 'src/di/profile_module.dart';
export 'src/presentation/bloc/profile_bloc.dart';
export 'src/presentation/onboarding/profile_onboarding_wizard.dart';
export 'src/presentation/onboarding/onboarding_components.dart';
export 'src/presentation/profile_screen.dart';
export 'src/presentation/widgets/user_avatar.dart';
export 'src/presentation/routes/profile_routes.dart'
    show
        CompleteProfileRoute,
        LinkInstitutionProfileRoute,
        PasswordSettingsRoute,
        ProfileRoute,
        ProfileRoutePages,
        routes;
