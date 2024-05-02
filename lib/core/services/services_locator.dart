import 'package:get_it/get_it.dart';
import 'package:iamtalking/core/app_bussines_logic/cubit/app_cubit.dart';
import 'package:iamtalking/core/helper/picke_file_helper.dart';
import 'package:iamtalking/core/helper/upload_to_storage_helper.dart';
import 'package:iamtalking/feautures/bussines_logic/auth_cubit/auth_cubit.dart';
import 'package:iamtalking/feautures/bussines_logic/comment_cubit/comment_cubit.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:iamtalking/feautures/bussines_logic/user_cubit/user_cubit.dart';
import 'package:iamtalking/feautures/data/repository/auth_repo.dart';
import 'package:iamtalking/feautures/data/repository/post_repo.dart';
import 'package:iamtalking/feautures/data/repository/user_repo.dart';
import 'package:iamtalking/feautures/data/services/auth_services.dart';
import 'package:iamtalking/feautures/data/services/comment_services.dart';
import 'package:iamtalking/feautures/data/services/post_services.dart';
import 'package:iamtalking/feautures/data/services/user_services.dart';

import '../../feautures/bussines_logic/chat_cubit/chat_cubit.dart';
import '../../feautures/data/repository/chat_repo.dart';
import '../../feautures/data/repository/comment_repo.dart';
import '../../feautures/data/services/chat_dervices.dart';

late GetIt sl;

void initSingleton() {
  sl = GetIt.instance;
  //Bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc());
  sl.registerFactory<UserBloc>(() => UserBloc());
  sl.registerFactory<PostBloc>(() => PostBloc());
  sl.registerFactory<AppBloc>(() => AppBloc());
  sl.registerFactory<CommentBloc>(() => CommentBloc());
  sl.registerFactory<ChatBloc>(() => ChatBloc());

  //Services
  sl.registerSingleton(AuthServices());
  sl.registerSingleton(UserServices());
  sl.registerSingleton(PostServices());
  sl.registerSingleton(CommentServices());
  sl.registerSingleton(ChatServices());

  //Repository
  sl.registerSingleton(AuthRepo());
  sl.registerSingleton(UserRepo());
  sl.registerSingleton(PostRepo());
  sl.registerSingleton(CommentRepo());
  sl.registerSingleton(ChatRepo());

  //Helpers
  sl.registerSingleton(PickeFileHelper());
  sl.registerSingleton(UploadToStorageHelper());
}
