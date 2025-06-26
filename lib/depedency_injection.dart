import 'package:aquanotes/core/data/init/database_initializer.dart';
import 'package:aquanotes/core/data/local/hive/hive_config.dart';
import 'package:aquanotes/core/data/local/hive/hive_service.dart';
import 'package:aquanotes/core/data/remote/dio_config.dart';
import 'package:aquanotes/core/data/shared_preferences.dart/credentials_storage.dart';
import 'package:aquanotes/core/data/shared_preferences.dart/login_storage.dart';
import 'package:aquanotes/core/data/shared_preferences.dart/onboarding_storage.dart';
import 'package:aquanotes/features/add_alarm/data/repository/add_alarm_repo_impl.dart';
import 'package:aquanotes/features/add_alarm/data/source/add_alarm_remote_source.dart';
import 'package:aquanotes/features/add_alarm/domain/repository/add_alarm_repo.dart';
import 'package:aquanotes/features/add_alarm/domain/usecase/add_alarm_get_divais.dart';
import 'package:aquanotes/features/amonia/presentation/cubit/amonie_screen_cubit.dart';
import 'package:aquanotes/features/divais/data/data/remote/divais_remote_source.dart';
import 'package:aquanotes/features/divais/data/repository/divais_repo_impl.dart';
import 'package:aquanotes/features/divais/domain/repository/divais_repo.dart';
import 'package:aquanotes/features/divais/domain/usecase/post_divais.dart';
import 'package:aquanotes/features/divais/presentation/cubit/divais_screen_cubit.dart';
import 'package:aquanotes/features/export_data/data/repository/export_repo_impl.dart';
import 'package:aquanotes/features/export_data/data/source/export_remote_source.dart';
import 'package:aquanotes/features/export_data/domain/repository/export_repo.dart';
import 'package:aquanotes/features/export_data/domain/usecase/expo_get_divais.dart';
import 'package:aquanotes/features/export_data/domain/usecase/expo_get_kolam.dart';
import 'package:aquanotes/features/export_data/domain/usecase/expo_get_tambak.dart';
import 'package:aquanotes/features/feedvision/presentation/cubit/feedvision_screen_cubit.dart';
import 'package:aquanotes/features/kolam/data/data/remote/kolam_remote_source.dart';
import 'package:aquanotes/features/kolam/data/repository/kolam_screen_repo_impl.dart';
import 'package:aquanotes/features/kolam/domain/repositry/kolam_screen_repo.dart';
import 'package:aquanotes/features/kolam/domain/usecase/get_divais.dart';
import 'package:aquanotes/features/kolam/domain/usecase/get_tambak.dart';
import 'package:aquanotes/features/kolam/domain/usecase/post_kolam.dart';
import 'package:aquanotes/features/kolam/presentation/cubit/kolam_screen_cubit.dart';
import 'package:aquanotes/features/export_data/presentation/cubit/export_data_screen_cubit.dart';
import 'package:aquanotes/features/monitoring/data/repository/monitoring_repo_impl.dart';
import 'package:aquanotes/features/monitoring/data/source/monitoring_remote_source.dart';
import 'package:aquanotes/features/monitoring/domain/repository/monitoring_repo.dart';
import 'package:aquanotes/features/monitoring/domain/usecase/get_monitoring.dart';
import 'package:aquanotes/features/monitoring/presentation/cubit/monitoring_screen_cubit.dart';
import 'package:aquanotes/features/authentication/data/repository/login_screen_repo_impl.dart';
import 'package:aquanotes/features/authentication/data/repository/register_screen_repo_impl.dart';
import 'package:aquanotes/features/authentication/data/source/login_shared_pref.dart';
import 'package:aquanotes/features/authentication/data/source/remote/login_remote_source.dart';
import 'package:aquanotes/features/authentication/data/source/remote/regist_remote_source.dart';
import 'package:aquanotes/features/authentication/domain/repository/login_screen_repo.dart';
import 'package:aquanotes/features/authentication/domain/repository/register_screen_repo.dart';
import 'package:aquanotes/features/authentication/domain/usecase/new_login.dart';
import 'package:aquanotes/features/authentication/domain/usecase/save_login_credentials.dart';
import 'package:aquanotes/features/authentication/domain/usecase/send_regist.dart';
import 'package:aquanotes/features/authentication/domain/usecase/set_login.dart';
import 'package:aquanotes/features/dashboard/data/repository/dashboard_repo_impl.dart';
import 'package:aquanotes/features/dashboard/data/source/pref/dashboard_pref.dart';
import 'package:aquanotes/features/dashboard/data/source/remote/dashboard_remote_datasource.dart';
import 'package:aquanotes/features/dashboard/domain/repository/dashboard_repo.dart';
import 'package:aquanotes/features/dashboard/domain/usecases/dash_get_tambak_data.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/dashboard_screen_cubit.dart';
import 'package:aquanotes/features/profile/data/repository/profile_screen_repo_impl.dart';
import 'package:aquanotes/features/profile/data/source/profile_remote_source.dart';
import 'package:aquanotes/features/profile/data/source/profile_shared_pref.dart';
import 'package:aquanotes/features/profile/domain/repository/profile_screen_repo.dart';
import 'package:aquanotes/features/profile/domain/usecase/get_credentials.dart';
import 'package:aquanotes/features/profile/domain/usecase/set_logout.dart';
import 'package:aquanotes/features/profile/presentation/cubit/profile_screen_cubit.dart';
import 'package:aquanotes/features/splash_screen/data/repository/splash_screen_repository_impl.dart';
import 'package:aquanotes/features/splash_screen/data/source/splash_shared_preferences.dart';
import 'package:aquanotes/features/splash_screen/domain/repository/splash_screen_repository.dart';
import 'package:aquanotes/features/splash_screen/domain/usecases/check_login.dart';
import 'package:aquanotes/features/splash_screen/domain/usecases/check_onboarding.dart';
import 'package:aquanotes/features/splash_screen/domain/usecases/set_onboarding.dart';
import 'package:aquanotes/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:aquanotes/features/status/data/repository/status_repo_impl.dart';
import 'package:aquanotes/features/status/data/source/remote/status_remote_source.dart';
import 'package:aquanotes/features/status/domain/repository/status_repo.dart';
import 'package:aquanotes/features/status/domain/usecase/get_divais_status.dart';
import 'package:aquanotes/features/status/domain/usecase/get_kolam_status.dart';
import 'package:aquanotes/features/status/domain/usecase/get_tambak_status.dart';
import 'package:aquanotes/features/tambak/data/repository/tambak_repository_impl.dart';
import 'package:aquanotes/features/tambak/data/source/tambak_local_datasource.dart';
import 'package:aquanotes/features/tambak/data/source/tambak_remote_datasource.dart';
import 'package:aquanotes/features/tambak/domain/repositories/tambak_repository.dart';
import 'package:aquanotes/features/tambak/domain/usecases/get_provinces.dart';
import 'package:aquanotes/features/tambak/domain/usecases/post_tambak.dart';
import 'package:aquanotes/features/tambak/presentation/cubit/tambak_sreen_cubit.dart';
import 'package:aquanotes/features/add_alarm/presentation/cubit/alarm_setting_cubit.dart';
import 'package:aquanotes/features/notifikasi/presentation/cubit/notifikasi_screen_cubit.dart';
import 'package:aquanotes/features/performa/presentation/cubit/performa_screen_cubit.dart';
import 'package:aquanotes/features/status/presentation/cubit/status_screen_cubit.dart';
import 'package:aquanotes/features/tagihan/presentation/cubit/tagihan_screen_cubit.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/articles/article_widget_cubit.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/questions/questions_widget_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'features/authentication/presentation/cubit/login/login_screen_cubit.dart';
import 'features/authentication/presentation/cubit/registration/registration_screen_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Hive
  await HiveConfig.init();
  sl.registerLazySingleton(() => HiveService());

  //SharedPreferences
  sl.registerLazySingleton(() => LoginStorage());
  sl.registerLazySingleton(() => OnboardingStorage());
  sl.registerLazySingleton(() => CredentialsStorage());

  sl.registerLazySingleton<SplashSharedPreferences>(() =>
      SplashSharedPreferencesImpl(sl<LoginStorage>(), sl<OnboardingStorage>()));
  sl.registerLazySingleton<LoginSharedPref>(
      () => LoginSharedPrefImpl(sl<LoginStorage>(), sl<CredentialsStorage>()));
  sl.registerLazySingleton<ProfileSharedPref>(
      () => ProfileSharedPrefImpl(sl<CredentialsStorage>()));
  sl.registerLazySingleton<DashboardPref>(
      () => DashboardPrefImpl(sl<CredentialsStorage>()));

  //Dio
  sl.registerLazySingleton<Dio>(() {
    final loginStorage = sl<LoginStorage>();
    final credStorage = sl<CredentialsStorage>();
    return DioConfig(
            loginStorage: loginStorage, credentialsStorage: credStorage)
        .dio;
  });

  //DataSource
  sl.registerLazySingleton<TambakLocalDatasource>(
      () => TambakDataSourceImplementation(sl<HiveService>()));

  sl.registerLazySingleton<ProvinceInitializer>(
      () => ProvinceInitializer(sl<HiveService>()));

  sl.registerLazySingleton<RegistRemoteSource>(
      () => RegistRemoteSourceImpl(sl<Dio>()));

  sl.registerLazySingleton<LoginRemoteSource>(
      () => LoginRemoteSourceImpl(sl<Dio>()));

  sl.registerLazySingleton<DashboardRemoteDatasource>(
      () => DashBoardRemoteDatasourceImpl(sl<Dio>()));

  sl.registerLazySingleton<TambakRemoteDatasource>(
      () => TambakRemoteDataSourceImpl(sl<Dio>()));

  sl.registerLazySingleton<ProfileRemoteSource>(
      () => ProfileRemoteSourcImpl(sl<Dio>()));

  sl.registerLazySingleton<DivaisRemoteSource>(
      () => DivaisRemoteSourceImpl(sl<Dio>()));

  sl.registerLazySingleton<KolamRemoteSource>(
      () => KolamRemoteSourceImpl(sl<Dio>()));

  sl.registerLazySingleton<StatusRemoteSource>(
      () => StatusRemoteSourceImpl(sl<Dio>()));

  sl.registerLazySingleton<MonitoringRemoteSource>(
      () => MonitoringRemoteSourceImpl(sl<Dio>()));

  sl.registerLazySingleton<ExportRemoteSource>(
      () => ExportRemoteSourceImpl(sl<Dio>()));

  sl.registerLazySingleton<AddAlarmRemoteSource>(
      () => AddAlarmRemoteImpl(sl<Dio>()));

  //Repository
  sl.registerLazySingleton<TambakRepository>(() => TambakRepositoryImpl(
      sl<TambakLocalDatasource>(), sl<TambakRemoteDatasource>()));
  sl.registerLazySingleton<SplashScreenRepository>(
      () => SplashScreenRepositoryImpl(sl<SplashSharedPreferences>()));
  sl.registerLazySingleton<LoginScreenRepo>(() =>
      LoginScreenRepoImpl(sl<LoginSharedPref>(), sl<LoginRemoteSource>()));
  sl.registerLazySingleton<ProfileScreenRepo>(() => ProfileScreenRepoImpl(
      sl<ProfileSharedPref>(), sl<ProfileRemoteSource>()));
  sl.registerLazySingleton<RegisterScreenRepo>(
      () => RegisterScreenRepoImpl(sl<RegistRemoteSource>()));
  sl.registerLazySingleton<DashboardRepo>(() =>
      DashboardRepoImpl(sl<DashboardRemoteDatasource>(), sl<DashboardPref>()));
  sl.registerLazySingleton<DivaisRepo>(
      () => DivaisRepoImpl(sl<DivaisRemoteSource>()));
  sl.registerLazySingleton<StatusRepo>(
      () => StatusRepoImpl(sl<StatusRemoteSource>()));
  sl.registerLazySingleton<KolamScreenRepo>(
      () => KolamScreenRepoImpl(sl<KolamRemoteSource>()));
  sl.registerLazySingleton<MonitoringRepo>(
      () => MonitoringRepoImpl(sl<MonitoringRemoteSource>()));
  sl.registerLazySingleton<ExportRepo>(
      () => ExportRepoImpl(sl<ExportRemoteSource>()));
  sl.registerLazySingleton<AddAlarmRepo>(
      () => AddAlarmRepoImpl(sl<AddAlarmRemoteSource>()));
  //UseCase
  sl.registerLazySingleton(() => GetProvinces(sl<TambakRepository>()));
  sl.registerLazySingleton(() => CheckLogin(sl<SplashScreenRepository>()));
  sl.registerLazySingleton(() => CheckOnboarding(sl<SplashScreenRepository>()));
  sl.registerLazySingleton(() => SetOnboarding(sl<SplashScreenRepository>()));
  sl.registerLazySingleton(() => SetLogin(sl<LoginScreenRepo>()));
  sl.registerLazySingleton(() => SetLogout(sl<ProfileScreenRepo>()));
  sl.registerLazySingleton(() => GetCredentials(sl<ProfileScreenRepo>()));
  sl.registerLazySingleton(() => SendRegist(sl<RegisterScreenRepo>()));
  sl.registerLazySingleton(() => SendLogin(sl<LoginScreenRepo>()));
  sl.registerLazySingleton(() => SaveLoginCredentials(sl<LoginScreenRepo>()));
  sl.registerLazySingleton(() => DashGetTambakData(sl<DashboardRepo>()));
  sl.registerLazySingleton(() => PostTambak(sl<TambakRepository>()));
  sl.registerLazySingleton(() => PostDivais(sl<DivaisRepo>()));
  sl.registerLazySingleton(() => GetTambak(sl<KolamScreenRepo>()));
  sl.registerLazySingleton(() => GetDivais(sl<KolamScreenRepo>()));
  sl.registerLazySingleton(() => PostKolam(sl<KolamScreenRepo>()));
  sl.registerLazySingleton(() => GetTambakStatus(sl<StatusRepo>()));
  sl.registerLazySingleton(() => GetDivaisStatus(sl<StatusRepo>()));
  sl.registerLazySingleton(() => GetKolamStatus(sl<StatusRepo>()));
  sl.registerLazySingleton(() => GetMonitoring(sl<MonitoringRepo>()));
  sl.registerLazySingleton(() => ExpoGetTambak(sl<ExportRepo>()));
  sl.registerLazySingleton(() => ExpoGetDivais(sl<ExportRepo>()));
  sl.registerLazySingleton(() => ExpoGetKolam(sl<ExportRepo>()));
  sl.registerLazySingleton(() => AddAlarmGetDivais(sl<AddAlarmRepo>()));

  //Cubit
  sl.registerFactory(() => RegistrationScreenCubit(sl<SendRegist>()));
  sl.registerFactory(() => LoginScreenCubit(
      sl<SetLogin>(), sl<SendLogin>(), sl<SaveLoginCredentials>()));
  sl.registerFactory(() => ArticleWidgetCubit());
  sl.registerFactory(() => QuestionsWidgetCubit());
  sl.registerFactory(
      () => TambakSreenCubit(sl<GetProvinces>(), sl<PostTambak>()));
  sl.registerFactory(() => DivaisScreenCubit(sl<PostDivais>()));
  sl.registerFactory(() =>
      KolamScreenCubit(sl<GetDivais>(), sl<GetTambak>(), sl<PostKolam>()));
  sl.registerFactory(() => StatusScreenCubit(
      sl<GetTambakStatus>(), sl<GetDivaisStatus>(), sl<GetKolamStatus>()));
  sl.registerFactory(() => TagihanScreenCubit());
  sl.registerFactory(() => NotifikasiScreenCubit()..fetchNotifications());
  sl.registerFactory(() => MonitoringScreenCubit(sl<GetMonitoring>()));
  sl.registerFactory(() => ExportDataScreenCubit(
      sl<ExpoGetDivais>(), sl<ExpoGetKolam>(), sl<ExpoGetTambak>()));
  sl.registerFactory(() => FeedvisionCubit());
  sl.registerFactory(() => AmonieScreenCubit());
  sl.registerFactory(() => PerformaScreenCubit());
  sl.registerFactory(() => AlarmSettingCubit(sl<AddAlarmGetDivais>()));
  sl.registerFactory(() => SplashScreenCubit(
      sl<CheckLogin>(), sl<CheckOnboarding>(), sl<SetOnboarding>()));
  sl.registerFactory(
      () => ProfileScreenCubit(sl<SetLogout>(), sl<GetCredentials>()));
  sl.registerFactory(() => DashboardScreenCubit(sl<DashGetTambakData>()));
}
