import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_lt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('lt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'ROMÙ'**
  String get appTitle;

  /// No description provided for @welcomeGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get welcomeGetStarted;

  /// No description provided for @welcomeHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get welcomeHaveAccount;

  /// No description provided for @welcomeSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get welcomeSignIn;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboardingStoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Your day demands a lot from you'**
  String get onboardingStoryTitle;

  /// No description provided for @onboardingStoryBody.
  ///
  /// In en, this message translates to:
  /// **'Between work, people, and everything happening around you, there’s rarely a moment that’s truly just for you.'**
  String get onboardingStoryBody;

  /// No description provided for @onboardingStoryTitle2.
  ///
  /// In en, this message translates to:
  /// **'Don’t know how to calm down?'**
  String get onboardingStoryTitle2;

  /// No description provided for @onboardingStoryBody2.
  ///
  /// In en, this message translates to:
  /// **'Sometimes your body stays tense while your thoughts keep racing. And you don’t always know how to break out of that cycle.'**
  String get onboardingStoryBody2;

  /// No description provided for @onboardingStoryTitle3.
  ///
  /// In en, this message translates to:
  /// **'You don’t have to figure everything out at once'**
  String get onboardingStoryTitle3;

  /// No description provided for @onboardingStoryBody3.
  ///
  /// In en, this message translates to:
  /// **'Sometimes, all it takes is a few minutes to pause, slow down, and reconnect with yourself.'**
  String get onboardingStoryBody3;

  /// No description provided for @onboardingStoryTitle4.
  ///
  /// In en, this message translates to:
  /// **'Start with one simple step'**
  String get onboardingStoryTitle4;

  /// No description provided for @onboardingStoryBody4.
  ///
  /// In en, this message translates to:
  /// **'Tell us how you’re feeling right now, and we’ll help you quickly find what you need most.'**
  String get onboardingStoryBody4;

  /// No description provided for @onboardingBegin.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get onboardingBegin;

  /// No description provided for @intentTitle.
  ///
  /// In en, this message translates to:
  /// **'What brings you to Romu?'**
  String get intentTitle;

  /// No description provided for @intentAnxietyTitle.
  ///
  /// In en, this message translates to:
  /// **'Anxiety'**
  String get intentAnxietyTitle;

  /// No description provided for @intentAnxietySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find calm\nand ease'**
  String get intentAnxietySubtitle;

  /// No description provided for @intentPanicTitle.
  ///
  /// In en, this message translates to:
  /// **'Panic'**
  String get intentPanicTitle;

  /// No description provided for @intentPanicSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ease the tension,\ncome back to your body'**
  String get intentPanicSubtitle;

  /// No description provided for @intentRacingTitle.
  ///
  /// In en, this message translates to:
  /// **'Racing thoughts'**
  String get intentRacingTitle;

  /// No description provided for @intentRacingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quiet the mind,\nfind some clarity'**
  String get intentRacingSubtitle;

  /// No description provided for @intentAngerTitle.
  ///
  /// In en, this message translates to:
  /// **'Anger / tension'**
  String get intentAngerTitle;

  /// No description provided for @intentAngerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let it go and\nrestore your balance'**
  String get intentAngerSubtitle;

  /// No description provided for @intentSleepTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get intentSleepTitle;

  /// No description provided for @intentSleepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Wind down and\nsink into rest'**
  String get intentSleepSubtitle;

  /// No description provided for @intentBreathworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Breathwork'**
  String get intentBreathworkTitle;

  /// No description provided for @intentBreathworkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quick calm,\nany time of day'**
  String get intentBreathworkSubtitle;

  /// No description provided for @intentBrowse.
  ///
  /// In en, this message translates to:
  /// **'I’d rather just browse'**
  String get intentBrowse;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get signUpTitle;

  /// No description provided for @signUpBody.
  ///
  /// In en, this message translates to:
  /// **'Keep your workouts, favorites, and progress perfectly in sync across all your devices.'**
  String get signUpBody;

  /// No description provided for @continueApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueApple;

  /// No description provided for @continueGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueGoogle;

  /// No description provided for @continueEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue with email'**
  String get continueEmail;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account ?'**
  String get alreadyHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @signUpLegalPrefix.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to out '**
  String get signUpLegalPrefix;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @legalBody.
  ///
  /// In en, this message translates to:
  /// **'This is a preview of the policy. Store billing and account rules stay with Apple and Google.'**
  String get legalBody;

  /// No description provided for @legalClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get legalClose;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountTitle;

  /// No description provided for @createAccountBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the following details carefully to create your account'**
  String get createAccountBody;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Full Name'**
  String get nameHint;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get passwordHint;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get nameRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordRequired;

  /// No description provided for @passwordShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 6 characters'**
  String get passwordShort;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @termsRequired.
  ///
  /// In en, this message translates to:
  /// **'Agree to the terms to continue'**
  String get termsRequired;

  /// No description provided for @createAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountAction;

  /// No description provided for @agreePrefix.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get agreePrefix;

  /// No description provided for @agreeAnd.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get agreeAnd;

  /// No description provided for @welcomeBackTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBackTitle;

  /// No description provided for @welcomeBackBody.
  ///
  /// In en, this message translates to:
  /// **'Pickup where you left off'**
  String get welcomeBackBody;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @newHere.
  ///
  /// In en, this message translates to:
  /// **'New here ?'**
  String get newHere;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// No description provided for @resetSent.
  ///
  /// In en, this message translates to:
  /// **'If this email is registered, a reset link is on its way.'**
  String get resetSent;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Code'**
  String get enterCode;

  /// No description provided for @otpSent.
  ///
  /// In en, this message translates to:
  /// **'Your temporary login code was sent to'**
  String get otpSent;

  /// No description provided for @otpSampleEmail.
  ///
  /// In en, this message translates to:
  /// **'j••••••@gmail.com'**
  String get otpSampleEmail;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend the code in 00:{seconds}'**
  String resendIn(Object seconds);

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code'**
  String get otpInvalid;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @allSetTitle.
  ///
  /// In en, this message translates to:
  /// **'You’re all set'**
  String get allSetTitle;

  /// No description provided for @allSetBody.
  ///
  /// In en, this message translates to:
  /// **'Your account is ready. Let’s find you something calming to start with.'**
  String get allSetBody;

  /// No description provided for @startPractice.
  ///
  /// In en, this message translates to:
  /// **'Start your first practice'**
  String get startPractice;

  /// No description provided for @exploreAlone.
  ///
  /// In en, this message translates to:
  /// **'Explore on my own'**
  String get exploreAlone;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get navLibrary;

  /// No description provided for @navBreathwork.
  ///
  /// In en, this message translates to:
  /// **'Breathwork'**
  String get navBreathwork;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @homeHello.
  ///
  /// In en, this message translates to:
  /// **'Hello,'**
  String get homeHello;

  /// No description provided for @homeDaySoFar.
  ///
  /// In en, this message translates to:
  /// **'Your day so far'**
  String get homeDaySoFar;

  /// No description provided for @homeStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'5 days in a row'**
  String get homeStreakTitle;

  /// No description provided for @homeStreakCaption.
  ///
  /// In en, this message translates to:
  /// **'Gently does it.'**
  String get homeStreakCaption;

  /// No description provided for @homeTodaysPick.
  ///
  /// In en, this message translates to:
  /// **'Today\'s pick'**
  String get homeTodaysPick;

  /// No description provided for @homeFeaturedTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming back to yourself'**
  String get homeFeaturedTitle;

  /// No description provided for @homeFeaturedMeta.
  ///
  /// In en, this message translates to:
  /// **'Meditation · 14 min'**
  String get homeFeaturedMeta;

  /// No description provided for @homeFeeling.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling?'**
  String get homeFeeling;

  /// No description provided for @feelingCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm down'**
  String get feelingCalm;

  /// No description provided for @feelingOverthinking.
  ///
  /// In en, this message translates to:
  /// **'Overthinking'**
  String get feelingOverthinking;

  /// No description provided for @feelingSleep.
  ///
  /// In en, this message translates to:
  /// **'For sleep'**
  String get feelingSleep;

  /// No description provided for @feelingMornings.
  ///
  /// In en, this message translates to:
  /// **'For mornings'**
  String get feelingMornings;

  /// No description provided for @homeRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended for you'**
  String get homeRecommended;

  /// No description provided for @recSteady.
  ///
  /// In en, this message translates to:
  /// **'Steady Mind'**
  String get recSteady;

  /// No description provided for @recSteadyDetail.
  ///
  /// In en, this message translates to:
  /// **'Stress · 10 min'**
  String get recSteadyDetail;

  /// No description provided for @recMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning Clam'**
  String get recMorning;

  /// No description provided for @recMorningDetail.
  ///
  /// In en, this message translates to:
  /// **'Anxiety · 10 min'**
  String get recMorningDetail;

  /// No description provided for @recSleep.
  ///
  /// In en, this message translates to:
  /// **'Deep Sleep'**
  String get recSleep;

  /// No description provided for @recSleepDetail.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get recSleepDetail;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since March 2026'**
  String get profileMemberSince;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profileEdit;

  /// No description provided for @profileDayStreak.
  ///
  /// In en, this message translates to:
  /// **'Day streak'**
  String get profileDayStreak;

  /// No description provided for @profileMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get profileMinutes;

  /// No description provided for @profileSessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get profileSessions;

  /// No description provided for @profileActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get profileActive;

  /// No description provided for @profileRenews.
  ///
  /// In en, this message translates to:
  /// **'Renews 12 Oct 2026 · €9.99 / month'**
  String get profileRenews;

  /// No description provided for @profileManage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get profileManage;

  /// No description provided for @profileEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEditProfile;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profileOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get profileOn;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get profileHelp;

  /// No description provided for @profilePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & terms'**
  String get profilePrivacy;

  /// No description provided for @profileLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogOut;

  /// No description provided for @profileDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get profileDelete;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The app switches straight away — no restart needed.'**
  String get languageSubtitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageEnglishCurrent.
  ///
  /// In en, this message translates to:
  /// **'English — current'**
  String get languageEnglishCurrent;

  /// No description provided for @languageLithuanian.
  ///
  /// In en, this message translates to:
  /// **'Lietuvių'**
  String get languageLithuanian;

  /// No description provided for @languageLithuanianPlain.
  ///
  /// In en, this message translates to:
  /// **'Lithuanian'**
  String get languageLithuanianPlain;

  /// No description provided for @languageLithuanianCurrent.
  ///
  /// In en, this message translates to:
  /// **'Lithuanian — current'**
  String get languageLithuanianCurrent;

  /// No description provided for @libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryTitle;

  /// No description provided for @libraryPopular.
  ///
  /// In en, this message translates to:
  /// **'Popular Practices'**
  String get libraryPopular;

  /// No description provided for @librarySeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get librarySeeAll;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @favoritesAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get favoritesAll;

  /// No description provided for @favoritesMeditations.
  ///
  /// In en, this message translates to:
  /// **'Meditations'**
  String get favoritesMeditations;

  /// No description provided for @favoritesBreathing.
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get favoritesBreathing;

  /// No description provided for @favoritesSaved.
  ///
  /// In en, this message translates to:
  /// **'{count} saved'**
  String favoritesSaved(Object count);

  /// No description provided for @favoritesEmptyFilter.
  ///
  /// In en, this message translates to:
  /// **'Nothing saved in this filter'**
  String get favoritesEmptyFilter;

  /// No description provided for @favoritesEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Sessions you save will live here'**
  String get favoritesEmptyHint;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing saved yet'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesBrowse.
  ///
  /// In en, this message translates to:
  /// **'Browse the library'**
  String get favoritesBrowse;

  /// No description provided for @breathworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Breathwork'**
  String get breathworkTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'lt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'lt':
      return AppLocalizationsLt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
