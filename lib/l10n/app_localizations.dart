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
  /// **'Privacy policy'**
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

  /// No description provided for @favoritesEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on any meditation or breathing exercise and it will be waiting for you here.'**
  String get favoritesEmptyBody;

  /// No description provided for @libraryCalmBody.
  ///
  /// In en, this message translates to:
  /// **'For anxiety, tension and strong emotions'**
  String get libraryCalmBody;

  /// No description provided for @libraryOverBody.
  ///
  /// In en, this message translates to:
  /// **'When your head is loud and focus is hard'**
  String get libraryOverBody;

  /// No description provided for @librarySleepBody.
  ///
  /// In en, this message translates to:
  /// **'For evenings, winding down and easier rest'**
  String get librarySleepBody;

  /// No description provided for @libraryMorningBody.
  ///
  /// In en, this message translates to:
  /// **'For evenings, winding down and easier rest'**
  String get libraryMorningBody;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All  ·  {count}'**
  String categoryAll(Object count);

  /// No description provided for @categoryUnder.
  ///
  /// In en, this message translates to:
  /// **'Under 10 min'**
  String get categoryUnder;

  /// No description provided for @categoryOver.
  ///
  /// In en, this message translates to:
  /// **'10 min +'**
  String get categoryOver;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String minutesShort(Object count);

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get minute;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @breathPractice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get breathPractice;

  /// No description provided for @breathHowLong.
  ///
  /// In en, this message translates to:
  /// **'How long ?'**
  String get breathHowLong;

  /// No description provided for @breathBegin.
  ///
  /// In en, this message translates to:
  /// **'Begin breathing'**
  String get breathBegin;

  /// No description provided for @breathStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get breathStart;

  /// No description provided for @phaseInhale.
  ///
  /// In en, this message translates to:
  /// **'Inhale'**
  String get phaseInhale;

  /// No description provided for @phaseHold.
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get phaseHold;

  /// No description provided for @phaseExhale.
  ///
  /// In en, this message translates to:
  /// **'Exhale'**
  String get phaseExhale;

  /// No description provided for @phaseInhaleCount.
  ///
  /// In en, this message translates to:
  /// **'Inhale {seconds}'**
  String phaseInhaleCount(Object seconds);

  /// No description provided for @phaseHoldCount.
  ///
  /// In en, this message translates to:
  /// **'Hold {seconds}'**
  String phaseHoldCount(Object seconds);

  /// No description provided for @phaseExhaleCount.
  ///
  /// In en, this message translates to:
  /// **'Exhale {seconds}'**
  String phaseExhaleCount(Object seconds);

  /// No description provided for @breathGuideIn.
  ///
  /// In en, this message translates to:
  /// **'Breathe in slowly through your nose'**
  String get breathGuideIn;

  /// No description provided for @breathGuideHold.
  ///
  /// In en, this message translates to:
  /// **'Stay with the breath'**
  String get breathGuideHold;

  /// No description provided for @breathGuideOut.
  ///
  /// In en, this message translates to:
  /// **'Let the breath leave'**
  String get breathGuideOut;

  /// No description provided for @breathPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get breathPause;

  /// No description provided for @breathResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get breathResume;

  /// No description provided for @breathSteady.
  ///
  /// In en, this message translates to:
  /// **'Steady again'**
  String get breathSteady;

  /// No description provided for @breathSummary.
  ///
  /// In en, this message translates to:
  /// **'{title} · {pattern} · {minutes} minutes'**
  String breathSummary(Object minutes, Object pattern, Object title);

  /// No description provided for @breathDoAgain.
  ///
  /// In en, this message translates to:
  /// **'Do it again'**
  String get breathDoAgain;

  /// No description provided for @breathDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get breathDone;

  /// No description provided for @breathBest.
  ///
  /// In en, this message translates to:
  /// **'Best 12 days'**
  String get breathBest;

  /// No description provided for @breathDayStreak.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get breathDayStreak;

  /// No description provided for @breathPattern.
  ///
  /// In en, this message translates to:
  /// **'PATTERN YOU BREATHED'**
  String get breathPattern;

  /// No description provided for @breathCycles.
  ///
  /// In en, this message translates to:
  /// **'{count} cycles completed · no pauses'**
  String breathCycles(Object count);

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpTitle;

  /// No description provided for @helpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answers first — a human if you still need one'**
  String get helpSubtitle;

  /// No description provided for @helpSearch.
  ///
  /// In en, this message translates to:
  /// **'Search help'**
  String get helpSearch;

  /// No description provided for @helpQ1.
  ///
  /// In en, this message translates to:
  /// **'Audio stops when I lock my phone'**
  String get helpQ1;

  /// No description provided for @helpA1.
  ///
  /// In en, this message translates to:
  /// **'Romù keeps playing in the background and on the lock screen. If it cuts out, check that Background App Refresh is on for Romù and that Low Power Mode is off.'**
  String get helpA1;

  /// No description provided for @helpQ2.
  ///
  /// In en, this message translates to:
  /// **'Why did my streak reset?'**
  String get helpQ2;

  /// No description provided for @helpA2.
  ///
  /// In en, this message translates to:
  /// **'A streak continues when you finish at least one session in a day. Missing a day starts the count again. Your best streak stays on your profile.'**
  String get helpA2;

  /// No description provided for @helpQ3.
  ///
  /// In en, this message translates to:
  /// **'How do I change or cancel my plan?'**
  String get helpQ3;

  /// No description provided for @helpA3.
  ///
  /// In en, this message translates to:
  /// **'Premium is billed by the App Store or Google Play. Open Manage subscription, then change or cancel the plan in the store. Romù cannot change the charge from inside the app.'**
  String get helpA3;

  /// No description provided for @helpQ4.
  ///
  /// In en, this message translates to:
  /// **'How do I delete my account?'**
  String get helpQ4;

  /// No description provided for @helpA4.
  ///
  /// In en, this message translates to:
  /// **'Profile, then Delete account. Type DELETE to confirm. Deleting the account does not cancel a store subscription.'**
  String get helpA4;

  /// No description provided for @helpQ5.
  ///
  /// In en, this message translates to:
  /// **'I’m not getting notifications'**
  String get helpQ5;

  /// No description provided for @helpA5.
  ///
  /// In en, this message translates to:
  /// **'Turn the reminder on in Notifications, and allow notifications for Romù in your phone settings.'**
  String get helpA5;

  /// No description provided for @helpPremium.
  ///
  /// In en, this message translates to:
  /// **'Already bought Premium?'**
  String get helpPremium;

  /// No description provided for @helpPremiumBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in with the same Apple ID or Google account you bought it with, then restore.'**
  String get helpPremiumBody;

  /// No description provided for @helpRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get helpRestore;

  /// No description provided for @helpEmail.
  ///
  /// In en, this message translates to:
  /// **'Email support'**
  String get helpEmail;

  /// No description provided for @helpEmailDetail.
  ///
  /// In en, this message translates to:
  /// **'hello@romu.app · replies within one working day'**
  String get helpEmailDetail;

  /// No description provided for @helpWrite.
  ///
  /// In en, this message translates to:
  /// **'Write to hello@romu.app'**
  String get helpWrite;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy & terms'**
  String get privacyTitle;

  /// No description provided for @privacyTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get privacyTerms;

  /// No description provided for @privacyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated 14 March 2026'**
  String get privacyUpdated;

  /// No description provided for @privacyCollect.
  ///
  /// In en, this message translates to:
  /// **'What we collect'**
  String get privacyCollect;

  /// No description provided for @privacyCollectBody.
  ///
  /// In en, this message translates to:
  /// **'Your name and email when you create an account, and which sessions you play so streaks and history work. That is all — no location, no contacts, no device fingerprinting.'**
  String get privacyCollectBody;

  /// No description provided for @privacyNever.
  ///
  /// In en, this message translates to:
  /// **'What we never do'**
  String get privacyNever;

  /// No description provided for @privacyNeverBody.
  ///
  /// In en, this message translates to:
  /// **'We do not sell your data, track you across other apps, or share what you listen to with advertisers. Romù has no third-party ad SDKs.'**
  String get privacyNeverBody;

  /// No description provided for @privacyStored.
  ///
  /// In en, this message translates to:
  /// **'Where it is stored'**
  String get privacyStored;

  /// No description provided for @privacyStoredBody.
  ///
  /// In en, this message translates to:
  /// **'Account data sits on servers inside the EU. Audio is streamed from a CDN; your listening history stays with your account and is never attached to an ad profile.'**
  String get privacyStoredBody;

  /// No description provided for @privacyRights.
  ///
  /// In en, this message translates to:
  /// **'Your rights'**
  String get privacyRights;

  /// No description provided for @privacyRightsBody.
  ///
  /// In en, this message translates to:
  /// **'You can see, export or erase everything from Profile → Delete account. Deletion is immediate and permanent, and we keep only what tax law requires us to keep about payments.'**
  String get privacyRightsBody;

  /// No description provided for @privacyQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get privacyQuestions;

  /// No description provided for @privacyQuestionsBody.
  ///
  /// In en, this message translates to:
  /// **'Write to privacy@romu.app and a person will answer within one working day.'**
  String get privacyQuestionsBody;

  /// No description provided for @termsUsing.
  ///
  /// In en, this message translates to:
  /// **'Using Romù'**
  String get termsUsing;

  /// No description provided for @termsUsingBody.
  ///
  /// In en, this message translates to:
  /// **'Romù is a meditation and breathwork practice. Sessions are for personal use. You need an account to keep streaks, favorites, and history.'**
  String get termsUsingBody;

  /// No description provided for @termsBilling.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get termsBilling;

  /// No description provided for @termsBillingBody.
  ///
  /// In en, this message translates to:
  /// **'Plan changes and cancellation are handled by Apple or Google. Romù can’t change your plan from inside the app.'**
  String get termsBillingBody;

  /// No description provided for @termsAccount.
  ///
  /// In en, this message translates to:
  /// **'Your account'**
  String get termsAccount;

  /// No description provided for @termsAccountBody.
  ///
  /// In en, this message translates to:
  /// **'You can erase your account from Profile → Delete account. Deletion is immediate and permanent.'**
  String get termsAccountBody;

  /// No description provided for @privacyDownload.
  ///
  /// In en, this message translates to:
  /// **'Download as PDF'**
  String get privacyDownload;

  /// No description provided for @privacyPdf.
  ///
  /// In en, this message translates to:
  /// **'PDF · 84 KB'**
  String get privacyPdf;

  /// No description provided for @privacyPdfPreview.
  ///
  /// In en, this message translates to:
  /// **'The PDF is a preview in this build.'**
  String get privacyPdfPreview;

  /// No description provided for @subTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subTitle;

  /// No description provided for @subSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your plan, billing and how to change it'**
  String get subSubtitle;

  /// No description provided for @subPrice.
  ///
  /// In en, this message translates to:
  /// **'€9.99 / month'**
  String get subPrice;

  /// No description provided for @subRenews.
  ///
  /// In en, this message translates to:
  /// **'Renews automatically'**
  String get subRenews;

  /// No description provided for @subRenewsDate.
  ///
  /// In en, this message translates to:
  /// **'12 Oct 2026'**
  String get subRenewsDate;

  /// No description provided for @subStarted.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get subStarted;

  /// No description provided for @subStartedDate.
  ///
  /// In en, this message translates to:
  /// **'12 Mar 2026'**
  String get subStartedDate;

  /// No description provided for @subBilled.
  ///
  /// In en, this message translates to:
  /// **'Billed through'**
  String get subBilled;

  /// No description provided for @subStore.
  ///
  /// In en, this message translates to:
  /// **'App Store'**
  String get subStore;

  /// No description provided for @subPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get subPayment;

  /// No description provided for @subApple.
  ///
  /// In en, this message translates to:
  /// **'Apple ID'**
  String get subApple;

  /// No description provided for @subIncluded.
  ///
  /// In en, this message translates to:
  /// **'What\'s included'**
  String get subIncluded;

  /// No description provided for @subItem1.
  ///
  /// In en, this message translates to:
  /// **'The full meditation library'**
  String get subItem1;

  /// No description provided for @subItem2.
  ///
  /// In en, this message translates to:
  /// **'Every breathing exercise'**
  String get subItem2;

  /// No description provided for @subItem3.
  ///
  /// In en, this message translates to:
  /// **'New sessions added each week'**
  String get subItem3;

  /// No description provided for @subItem4.
  ///
  /// In en, this message translates to:
  /// **'Progress, streaks and history'**
  String get subItem4;

  /// No description provided for @subManage.
  ///
  /// In en, this message translates to:
  /// **'Manage in App Store'**
  String get subManage;

  /// No description provided for @subManageBody.
  ///
  /// In en, this message translates to:
  /// **'Plan changes and cancellation are handled by Apple or Google. Romù can’t change your plan from inside the app.'**
  String get subManageBody;

  /// No description provided for @subNote.
  ///
  /// In en, this message translates to:
  /// **'Plan changes and cancellation are handled by Apple. Romù can’t change your plan from inside the app.'**
  String get subNote;

  /// No description provided for @subClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get subClose;

  /// No description provided for @notifTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifTitle;

  /// No description provided for @notifSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose what Romù can nudge you about'**
  String get notifSubtitle;

  /// No description provided for @notifDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get notifDaily;

  /// No description provided for @notifDailyBody.
  ///
  /// In en, this message translates to:
  /// **'A gentle nudge at the same time each day'**
  String get notifDailyBody;

  /// No description provided for @notifTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get notifTime;

  /// No description provided for @notifPractice.
  ///
  /// In en, this message translates to:
  /// **'PRACTICE'**
  String get notifPractice;

  /// No description provided for @notifStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak reminders'**
  String get notifStreak;

  /// No description provided for @notifNew.
  ///
  /// In en, this message translates to:
  /// **'New sessions added'**
  String get notifNew;

  /// No description provided for @notifWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly progress recap'**
  String get notifWeekly;

  /// No description provided for @notifAccount.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get notifAccount;

  /// No description provided for @notifBilling.
  ///
  /// In en, this message translates to:
  /// **'Subscription & billing'**
  String get notifBilling;

  /// No description provided for @notifNews.
  ///
  /// In en, this message translates to:
  /// **'Product news'**
  String get notifNews;

  /// No description provided for @notifNote.
  ///
  /// In en, this message translates to:
  /// **'Romù can only send these if notifications are allowed for the app on your phone.'**
  String get notifNote;

  /// No description provided for @notifSettings.
  ///
  /// In en, this message translates to:
  /// **'Open system settings'**
  String get notifSettings;

  /// No description provided for @pwTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get pwTitle;

  /// No description provided for @pwSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You’ll stay signed in on this device. Other devices will ask you to log in again.'**
  String get pwSubtitle;

  /// No description provided for @pwCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get pwCurrent;

  /// No description provided for @pwNew.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get pwNew;

  /// No description provided for @pwConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get pwConfirm;

  /// No description provided for @pwUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get pwUpdate;

  /// No description provided for @pwShow.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get pwShow;

  /// No description provided for @pwHide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get pwHide;

  /// No description provided for @pwRules.
  ///
  /// In en, this message translates to:
  /// **'NEW PASSWORD MUST HAVE'**
  String get pwRules;

  /// No description provided for @pwLength.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get pwLength;

  /// No description provided for @pwNumber.
  ///
  /// In en, this message translates to:
  /// **'One number'**
  String get pwNumber;

  /// No description provided for @pwCapital.
  ///
  /// In en, this message translates to:
  /// **'One capital letter'**
  String get pwCapital;

  /// No description provided for @editTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editTitle;

  /// No description provided for @editSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update how your account looks in Romù'**
  String get editSubtitle;

  /// No description provided for @editPhoto.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get editPhoto;

  /// No description provided for @editPhotoHint.
  ///
  /// In en, this message translates to:
  /// **'JPG or PNG, square, min 200px'**
  String get editPhotoHint;

  /// No description provided for @editChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get editChange;

  /// No description provided for @editName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get editName;

  /// No description provided for @editEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get editEmail;

  /// No description provided for @editPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get editPassword;

  /// No description provided for @editSave.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get editSave;

  /// No description provided for @editTake.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get editTake;

  /// No description provided for @editGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get editGallery;

  /// No description provided for @editPhotoError.
  ///
  /// In en, this message translates to:
  /// **'Could not use that photo'**
  String get editPhotoError;

  /// No description provided for @deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get deleteTitle;

  /// No description provided for @deleteBody.
  ///
  /// In en, this message translates to:
  /// **'This erases your Romù account and everything in it. It cannot be undone.'**
  String get deleteBody;

  /// No description provided for @deleteItem1.
  ///
  /// In en, this message translates to:
  /// **'Your profile, name and email'**
  String get deleteItem1;

  /// No description provided for @deleteItem2.
  ///
  /// In en, this message translates to:
  /// **'Streaks, minutes and session history'**
  String get deleteItem2;

  /// No description provided for @deleteItem3.
  ///
  /// In en, this message translates to:
  /// **'Everything saved in Favorites'**
  String get deleteItem3;

  /// No description provided for @deleteItem4.
  ///
  /// In en, this message translates to:
  /// **'Any audio downloaded to this phone'**
  String get deleteItem4;

  /// No description provided for @deleteBilling.
  ///
  /// In en, this message translates to:
  /// **'Your subscription is billed by Apple or Google. Deleting the account does not cancel it — cancel in the App Store or Play Store first.'**
  String get deleteBilling;

  /// No description provided for @deleteType.
  ///
  /// In en, this message translates to:
  /// **'Type DELETE to confirm'**
  String get deleteType;

  /// No description provided for @deleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get deleteCancel;

  /// No description provided for @medNarrated.
  ///
  /// In en, this message translates to:
  /// **'Narrated by {name}'**
  String medNarrated(Object name);

  /// No description provided for @medGuided.
  ///
  /// In en, this message translates to:
  /// **'Guided'**
  String get medGuided;

  /// No description provided for @medAbout.
  ///
  /// In en, this message translates to:
  /// **'ABOUT THIS PRACTICE'**
  String get medAbout;

  /// No description provided for @medAboutBody.
  ///
  /// In en, this message translates to:
  /// **'Let the day slowly loosen its hold. This gentle meditation helps you release lingering thoughts, worries, and emotions from the day.\nThrough slow breathing and soothing guidance, you’ll quiet the mind, relax the body, and create space for stillness. Let go of what can wait until tomorrow and ease naturally into a peaceful, restful sleep.'**
  String get medAboutBody;

  /// No description provided for @medHeadphones.
  ///
  /// In en, this message translates to:
  /// **'Best with headphones, somewhere quiet.'**
  String get medHeadphones;

  /// No description provided for @medBegin.
  ///
  /// In en, this message translates to:
  /// **'Begin Session'**
  String get medBegin;

  /// No description provided for @medFallback.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get medFallback;

  /// No description provided for @seekLabel.
  ///
  /// In en, this message translates to:
  /// **'10S'**
  String get seekLabel;

  /// No description provided for @completeSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to favorites'**
  String get completeSaved;

  /// No description provided for @completeDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get completeDone;

  /// No description provided for @completeBest.
  ///
  /// In en, this message translates to:
  /// **'Best 12 days'**
  String get completeBest;

  /// No description provided for @completeSessions.
  ///
  /// In en, this message translates to:
  /// **'sessions'**
  String get completeSessions;

  /// No description provided for @completeStreak.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get completeStreak;

  /// No description provided for @completeUpNext.
  ///
  /// In en, this message translates to:
  /// **'UP NEXT'**
  String get completeUpNext;

  /// No description provided for @completeBack.
  ///
  /// In en, this message translates to:
  /// **'That\'s {amount} {unit} back'**
  String completeBack(Object amount, Object unit);

  /// No description provided for @wordOne.
  ///
  /// In en, this message translates to:
  /// **'one'**
  String get wordOne;

  /// No description provided for @wordTwo.
  ///
  /// In en, this message translates to:
  /// **'two'**
  String get wordTwo;

  /// No description provided for @wordThree.
  ///
  /// In en, this message translates to:
  /// **'three'**
  String get wordThree;

  /// No description provided for @wordFour.
  ///
  /// In en, this message translates to:
  /// **'four'**
  String get wordFour;

  /// No description provided for @wordFive.
  ///
  /// In en, this message translates to:
  /// **'five'**
  String get wordFive;

  /// No description provided for @wordSix.
  ///
  /// In en, this message translates to:
  /// **'six'**
  String get wordSix;

  /// No description provided for @wordSeven.
  ///
  /// In en, this message translates to:
  /// **'seven'**
  String get wordSeven;

  /// No description provided for @wordEight.
  ///
  /// In en, this message translates to:
  /// **'eight'**
  String get wordEight;

  /// No description provided for @wordNine.
  ///
  /// In en, this message translates to:
  /// **'nine'**
  String get wordNine;

  /// No description provided for @wordTen.
  ///
  /// In en, this message translates to:
  /// **'ten'**
  String get wordTen;

  /// No description provided for @wordTwelve.
  ///
  /// In en, this message translates to:
  /// **'twelve'**
  String get wordTwelve;

  /// No description provided for @wordFourteen.
  ///
  /// In en, this message translates to:
  /// **'fourteen'**
  String get wordFourteen;

  /// No description provided for @wordEighteen.
  ///
  /// In en, this message translates to:
  /// **'eighteen'**
  String get wordEighteen;

  /// No description provided for @planTitle.
  ///
  /// In en, this message translates to:
  /// **'Romù , in full'**
  String get planTitle;

  /// No description provided for @planBody.
  ///
  /// In en, this message translates to:
  /// **'Every meditation and every breathing practice, whenever you need them'**
  String get planBody;

  /// No description provided for @planToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get planToday;

  /// No description provided for @planTodayBody.
  ///
  /// In en, this message translates to:
  /// **'Everything unlocks. Start listening straight away.'**
  String get planTodayBody;

  /// No description provided for @planDay5.
  ///
  /// In en, this message translates to:
  /// **'Day 5'**
  String get planDay5;

  /// No description provided for @planDay5Body.
  ///
  /// In en, this message translates to:
  /// **'A gentle reminder , two days before your trial ends.'**
  String get planDay5Body;

  /// No description provided for @planDay7.
  ///
  /// In en, this message translates to:
  /// **'Day 7'**
  String get planDay7;

  /// No description provided for @planDay7Body.
  ///
  /// In en, this message translates to:
  /// **'Your subscription starts, Cancel any time before then'**
  String get planDay7Body;

  /// No description provided for @planYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get planYearly;

  /// No description provided for @planMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get planMonthly;

  /// No description provided for @planYearPrice.
  ///
  /// In en, this message translates to:
  /// **'€59.99 a year'**
  String get planYearPrice;

  /// No description provided for @planMonthPrice.
  ///
  /// In en, this message translates to:
  /// **'€5.00 a month'**
  String get planMonthPrice;

  /// No description provided for @planYearNote.
  ///
  /// In en, this message translates to:
  /// **'That works out a €5.00 a month'**
  String get planYearNote;

  /// No description provided for @planMonthNote.
  ///
  /// In en, this message translates to:
  /// **'Billed every month. Cancel any time.'**
  String get planMonthNote;

  /// No description provided for @planStart.
  ///
  /// In en, this message translates to:
  /// **'Start 7 days free'**
  String get planStart;

  /// No description provided for @cyclesLabel.
  ///
  /// In en, this message translates to:
  /// **'cycles'**
  String get cyclesLabel;
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
