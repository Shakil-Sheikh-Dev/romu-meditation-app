import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/features/auth/views/all_set_view.dart';
import 'package:romu/features/auth/views/create_account_view.dart';
import 'package:romu/features/auth/views/login_view.dart';
import 'package:romu/features/auth/views/otp_view.dart';
import 'package:romu/features/auth/views/sign_up_view.dart';
import 'package:romu/features/auth/views/welcome_view.dart';
import 'package:romu/features/onboarding/models/onboarding_story.dart';
import 'package:romu/features/onboarding/views/intent_view.dart';
import 'package:romu/features/breathwork/views/breath_complete_view.dart';
import 'package:romu/features/breathwork/views/breath_session_view.dart';
import 'package:romu/features/breathwork/views/breath_setup_view.dart';
import 'package:romu/features/breathwork/views/breath_start_view.dart';
import 'package:romu/features/breathwork/views/breathwork_list_view.dart';
import 'package:romu/features/favorites/views/favorites_view.dart';
import 'package:romu/features/home/views/home_view.dart';
import 'package:romu/features/library/views/category_view.dart';
import 'package:romu/features/library/views/library_view.dart';
import 'package:romu/features/meditation/views/meditation_detail_view.dart';
import 'package:romu/features/onboarding/views/onboarding_flow_view.dart';
import 'package:romu/features/player/views/player_view.dart';
import 'package:romu/features/player/views/session_complete_view.dart';
import 'package:romu/features/profile/views/change_password_view.dart';
import 'package:romu/features/profile/views/delete_account_view.dart';
import 'package:romu/features/profile/views/edit_profile_view.dart';
import 'package:romu/features/profile/views/help_view.dart';
import 'package:romu/features/profile/views/language_view.dart';
import 'package:romu/features/profile/views/manage_subscription_view.dart';
import 'package:romu/features/profile/views/notifications_view.dart';
import 'package:romu/features/profile/views/privacy_view.dart';
import 'package:romu/features/profile/views/profile_view.dart';
import 'package:romu/features/subscription/views/subscription_view.dart';
import 'package:romu/l10n/app_localizations.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return WelcomeView(
            onGetStarted: () => context.go('/onboarding'),
            onSignIn: () => context.go('/sign-up'),
          );
        },
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: '/create-account',
        builder: (context, state) => const CreateAccountView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpView(),
      ),
      GoRoute(
        path: '/all-set',
        builder: (context, state) => const AllSetView(),
      ),
      GoRoute(
        path: '/intent',
        builder: (context, state) {
          return IntentView(onBrowse: () => context.go('/sign-up'));
        },
      ),
      GoRoute(
        path: '/subscription',
        builder: (context, state) => const SubscriptionView(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/library',
        builder: (context, state) => const LibraryView(),
      ),
      GoRoute(
        path: '/breathwork',
        builder: (context, state) => const BreathworkListView(),
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesView(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordView(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsView(),
      ),
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageView(),
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) => const HelpView(),
      ),
      GoRoute(
        path: '/privacy',
        builder: (context, state) => const PrivacyView(),
      ),
      GoRoute(
        path: '/manage-subscription',
        builder: (context, state) => const ManageSubscriptionView(),
      ),
      GoRoute(
        path: '/delete-account',
        builder: (context, state) => const DeleteAccountView(),
      ),
      GoRoute(
        path: '/breath-setup',
        builder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? 'Calm down';
          final pattern = state.uri.queryParameters['pattern'] ?? '4-6';
          return BreathSetupView(title: title, patternId: pattern);
        },
      ),
      GoRoute(
        path: '/breath-start',
        builder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? 'Box breathing';
          final pattern = state.uri.queryParameters['pattern'] ?? '4-4-4-4';
          final minutes = int.tryParse(state.uri.queryParameters['minutes'] ?? '') ?? 3;
          return BreathStartView(title: title, patternId: pattern, minutes: minutes);
        },
      ),
      GoRoute(
        path: '/breath-complete',
        builder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? 'Calm down';
          final pattern = state.uri.queryParameters['pattern'] ?? '4-6';
          final minutes = int.tryParse(state.uri.queryParameters['minutes'] ?? '') ?? 3;
          final cycles = int.tryParse(state.uri.queryParameters['cycles'] ?? '') ?? 1;
          return BreathCompleteView(
            title: title,
            patternId: pattern,
            minutes: minutes,
            cycles: cycles,
          );
        },
      ),
      GoRoute(
        path: '/meditation',
        builder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? 'Letting go of the day';
          final narrator = state.uri.queryParameters['narrator'] ?? 'Elena Rostova';
          final topic = state.uri.queryParameters['topic'] ?? 'Sleep';
          final minutes = int.tryParse(state.uri.queryParameters['minutes'] ?? '') ?? 14;
          return MeditationDetailView(
            title: title,
            narrator: narrator,
            minutes: minutes,
            topic: topic,
          );
        },
      ),
      GoRoute(
        path: '/session-complete',
        builder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? 'Letting go of the day';
          final subtitle = state.uri.queryParameters['subtitle'] ?? '';
          final minutes = int.tryParse(state.uri.queryParameters['minutes'] ?? '') ?? 14;
          return SessionCompleteView(
            title: title,
            minutes: minutes,
            subtitle: subtitle,
          );
        },
      ),
      GoRoute(
        path: '/player',
        builder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? 'Coming back to yourself';
          final subtitle = state.uri.queryParameters['subtitle'] ?? 'Meditation';
          final minutes = int.tryParse(state.uri.queryParameters['minutes'] ?? '') ?? 12;
          return PlayerView(title: title, minutes: minutes, subtitle: subtitle);
        },
      ),
      GoRoute(
        path: '/category/:id',
        builder: (context, state) {
          return CategoryView(
            category: PracticeCategory.byId(state.pathParameters['id'] ?? 'calm'),
          );
        },
      ),
      GoRoute(
        path: '/breath-session',
        builder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? 'Box Breathing';
          final pattern = state.uri.queryParameters['pattern'] ?? '4-4-4-4';
          final minutes = int.tryParse(state.uri.queryParameters['minutes'] ?? '') ?? 3;
          return BreathSessionView(
            title: title,
            patternId: pattern,
            minutes: minutes,
          );
        },
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) {
          return OnboardingFlowView(
            stories: OnboardingStory.pages(AppLocalizations.of(context)),
            onBegin: () => context.go('/intent'),
          );
        },
      ),
    ],
  );
});
