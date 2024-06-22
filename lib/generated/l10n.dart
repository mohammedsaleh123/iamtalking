// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Feeds`
  String get feeds {
    return Intl.message(
      'Feeds',
      name: 'feeds',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Add Post`
  String get add_post {
    return Intl.message(
      'Add Post',
      name: 'add_post',
      desc: '',
      args: [],
    );
  }

  /// `Add caption`
  String get add_caption {
    return Intl.message(
      'Add caption',
      name: 'add_caption',
      desc: '',
      args: [],
    );
  }

  /// `Add Comment`
  String get add_comment {
    return Intl.message(
      'Add Comment',
      name: 'add_comment',
      desc: '',
      args: [],
    );
  }

  /// `Saved Posts`
  String get saved_posts {
    return Intl.message(
      'Saved Posts',
      name: 'saved_posts',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get people {
    return Intl.message(
      'People',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `Posts`
  String get posts {
    return Intl.message(
      'Posts',
      name: 'posts',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get likes {
    return Intl.message(
      'Likes',
      name: 'likes',
      desc: '',
      args: [],
    );
  }

  /// `Followers`
  String get followers {
    return Intl.message(
      'Followers',
      name: 'followers',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `less`
  String get less {
    return Intl.message(
      'less',
      name: 'less',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message(
      'Log Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get login_with_Google {
    return Intl.message(
      'Login with Google',
      name: 'login_with_Google',
      desc: '',
      args: [],
    );
  }

  /// `I am talking`
  String get iamtalking {
    return Intl.message(
      'I am talking',
      name: 'iamtalking',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get please_enter_your_name {
    return Intl.message(
      'Please enter your name',
      name: 'please_enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get please_enter_your_email {
    return Intl.message(
      'Please enter your email',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Or  `
  String get or {
    return Intl.message(
      'Or  ',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `New member?`
  String get new_remember {
    return Intl.message(
      'New member?',
      name: 'new_remember',
      desc: '',
      args: [],
    );
  }

  /// `Register with Google`
  String get register_with_Google {
    return Intl.message(
      'Register with Google',
      name: 'register_with_Google',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get please_enter_a_valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'please_enter_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get please_enter_your_password {
    return Intl.message(
      'Please enter your password',
      name: 'please_enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your confirm password`
  String get please_enter_your_confirm_password {
    return Intl.message(
      'Please enter your confirm password',
      name: 'please_enter_your_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_must_be_at_least_6_characters {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_must_be_at_least_6_characters',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get password_does_not_match {
    return Intl.message(
      'Password does not match',
      name: 'password_does_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid data`
  String get please_enter_a_valid_data {
    return Intl.message(
      'Please enter a valid data',
      name: 'please_enter_a_valid_data',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Save Post`
  String get save_post {
    return Intl.message(
      'Save Post',
      name: 'save_post',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get light_theme {
    return Intl.message(
      'Light Theme',
      name: 'light_theme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get dark_theme {
    return Intl.message(
      'Dark Theme',
      name: 'dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `اللغة العربية`
  String get language {
    return Intl.message(
      'اللغة العربية',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Choose Image`
  String get choose_image {
    return Intl.message(
      'Choose Image',
      name: 'choose_image',
      desc: '',
      args: [],
    );
  }

  /// `Choose Video`
  String get choose_video {
    return Intl.message(
      'Choose Video',
      name: 'choose_video',
      desc: '',
      args: [],
    );
  }

  /// `Login successfully`
  String get login_successfully {
    return Intl.message(
      'Login successfully',
      name: 'login_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Register successfully`
  String get register_successfully {
    return Intl.message(
      'Register successfully',
      name: 'register_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get login_failed {
    return Intl.message(
      'Login failed',
      name: 'login_failed',
      desc: '',
      args: [],
    );
  }

  /// `Register failed`
  String get register_failed {
    return Intl.message(
      'Register failed',
      name: 'register_failed',
      desc: '',
      args: [],
    );
  }

  /// `Edit Post`
  String get edit_post {
    return Intl.message(
      'Edit Post',
      name: 'edit_post',
      desc: '',
      args: [],
    );
  }

  /// `Delete Post`
  String get delete_post {
    return Intl.message(
      'Delete Post',
      name: 'delete_post',
      desc: '',
      args: [],
    );
  }

  /// `Unsave Post`
  String get un_save_post {
    return Intl.message(
      'Unsave Post',
      name: 'un_save_post',
      desc: '',
      args: [],
    );
  }

  /// `Please upload your profile image`
  String get please_upload_your_profile_image {
    return Intl.message(
      'Please upload your profile image',
      name: 'please_upload_your_profile_image',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get please_fill_all_fields {
    return Intl.message(
      'Please fill all fields',
      name: 'please_fill_all_fields',
      desc: '',
      args: [],
    );
  }

  /// `Add post successfully`
  String get add_post_successfully {
    return Intl.message(
      'Add post successfully',
      name: 'add_post_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Edit post successfully`
  String get edit_post_successfully {
    return Intl.message(
      'Edit post successfully',
      name: 'edit_post_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete post successfully`
  String get delete_post_successfully {
    return Intl.message(
      'Delete post successfully',
      name: 'delete_post_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Unsave post successfully`
  String get un_save_post_successfully {
    return Intl.message(
      'Unsave post successfully',
      name: 'un_save_post_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Save post successfully`
  String get save_post_successfully {
    return Intl.message(
      'Save post successfully',
      name: 'save_post_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get follow {
    return Intl.message(
      'Follow',
      name: 'follow',
      desc: '',
      args: [],
    );
  }

  /// `Unfollow`
  String get un_follow {
    return Intl.message(
      'Unfollow',
      name: 'un_follow',
      desc: '',
      args: [],
    );
  }

  /// `Delete Comment`
  String get delete_comment {
    return Intl.message(
      'Delete Comment',
      name: 'delete_comment',
      desc: '',
      args: [],
    );
  }

  /// `Edit Comment`
  String get edit_comment {
    return Intl.message(
      'Edit Comment',
      name: 'edit_comment',
      desc: '',
      args: [],
    );
  }

  /// `Add Message`
  String get add_message {
    return Intl.message(
      'Add Message',
      name: 'add_message',
      desc: '',
      args: [],
    );
  }

  /// `Your Record`
  String get your_record {
    return Intl.message(
      'Your Record',
      name: 'your_record',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
