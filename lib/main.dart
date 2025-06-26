import 'package:aquanotes/core/data/init/database_initializer.dart';
import 'package:aquanotes/features/add_alarm/presentation/page/add_alarm_screen.dart';
import 'package:aquanotes/features/amonia/presentation/cubit/amonie_screen_cubit.dart';
import 'package:aquanotes/features/divais/presentation/cubit/divais_screen_cubit.dart';
import 'package:aquanotes/features/feedvision/presentation/cubit/feedvision_screen_cubit.dart';
import 'package:aquanotes/features/kolam/presentation/cubit/kolam_screen_cubit.dart';
import 'package:aquanotes/features/export_data/presentation/cubit/export_data_screen_cubit.dart';
import 'package:aquanotes/features/monitoring/presentation/cubit/monitoring_screen_cubit.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/dashboard_screen_cubit.dart';
import 'package:aquanotes/features/profile/presentation/cubit/profile_screen_cubit.dart';
import 'package:aquanotes/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:aquanotes/features/tambak/presentation/cubit/tambak_sreen_cubit.dart';
import 'package:aquanotes/features/add_alarm/presentation/cubit/alarm_setting_cubit.dart';
import 'package:aquanotes/features/notifikasi/presentation/cubit/notifikasi_screen_cubit.dart';
import 'package:aquanotes/features/performa/presentation/cubit/performa_screen_cubit.dart';
import 'package:aquanotes/features/status/presentation/cubit/status_screen_cubit.dart';
import 'package:aquanotes/features/tagihan/presentation/cubit/tagihan_screen_cubit.dart';
import 'package:aquanotes/features/authentication/presentation/page/login_screen.dart';
import 'package:aquanotes/features/introduction/presentation/page/introduction_screen.dart';
import 'package:aquanotes/features/authentication/presentation/page/registration_screen.dart';
import 'package:aquanotes/features/divais/presentation/page/divais.dart';
import 'package:aquanotes/features/feedvision/presentation/page/feedvision_screen.dart';
import 'package:aquanotes/features/kolam/presentation/page/kolam.dart';
import 'package:aquanotes/features/export_data/presentation/page/export_data_screen.dart';
import 'package:aquanotes/features/monitoring/presentation/page/monitoring_screen.dart';
import 'package:aquanotes/shared/presentation/pages/popup_screen.dart';
import 'package:aquanotes/features/prediksi/presentation/page/about_screen.dart';
import 'package:aquanotes/features/amonia/presentation/page/amonia_prediction_result_screen.dart';
import 'package:aquanotes/features/amonia/presentation/page/amonia_screen.dart';
import 'package:aquanotes/features/performa/presentation/page/performa_screen.dart';
import 'package:aquanotes/features/prediksi/presentation/page/prediksi_screen.dart';
import 'package:aquanotes/features/tambak/presentation/page/tambak.dart';
import 'package:aquanotes/features/status/presentation/page/status_screen.dart';
import 'package:aquanotes/features/notifikasi/presentation/page/notifikasi_screen.dart';
import 'package:aquanotes/features/profile/presentation/page/profile_screen.dart';
import 'package:aquanotes/features/splash_screen/presentation/page/splash_screen.dart';
import 'package:aquanotes/features/tagihan/presentation/page/tagihan_screen.dart';
import 'package:aquanotes/features/welcome/presentation/page/welcome_screen.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/articles/article_widget_cubit.dart';
import 'package:aquanotes/features/dashboard/presentation/cubit/questions/questions_widget_cubit.dart';
import 'package:aquanotes/features/home/presentation/page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'depedency_injection.dart' as di;
import 'depedency_injection.dart';
import 'features/authentication/presentation/cubit/login/login_screen_cubit.dart';
import 'features/authentication/presentation/cubit/registration/registration_screen_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await sl<ProvinceInitializer>().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<RegistrationScreenCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<LoginScreenCubit>(),
        ),
        BlocProvider(create: (context) => sl<ArticleWidgetCubit>()),
        BlocProvider(create: (context) => sl<QuestionsWidgetCubit>()),
        BlocProvider(create: (context) => sl<TambakSreenCubit>()),
        BlocProvider(create: (context) => sl<DivaisScreenCubit>()),
        BlocProvider(create: (context) => sl<KolamScreenCubit>()),
        BlocProvider(create: (context) => sl<StatusScreenCubit>()),
        BlocProvider(create: (context) => sl<TagihanScreenCubit>()),
        BlocProvider(create: (context) => sl<NotifikasiScreenCubit>()),
        BlocProvider(create: (context) => sl<MonitoringScreenCubit>()),
        BlocProvider(create: (context) => sl<ExportDataScreenCubit>()),
        BlocProvider(create: (context) => sl<FeedvisionCubit>()),
        BlocProvider(create: (context) => sl<PerformaScreenCubit>()),
        BlocProvider(create: (context) => sl<AmonieScreenCubit>()),
        BlocProvider(create: (context) => sl<AlarmSettingCubit>()),
        BlocProvider(create: (context) => sl<SplashScreenCubit>()),
        BlocProvider(create: (context) => sl<ProfileScreenCubit>()),
        BlocProvider(create: (context) => sl<DashboardScreenCubit>())
      ],
      child: MaterialApp(
        title: 'Aquanotes',
        initialRoute: SplashScreen.routeName,
        theme: ThemeData(useMaterial3: true, fontFamily: "Inter"),
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          IntroductionScreen.routeName: (context) => const IntroductionScreen(),
          WelcomeScreen.routeName: (context) => const WelcomeScreen(),
          RegistrationScreen.routeName: (context) => const RegistrationScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          TambakScreen.routeName: (context) => const TambakScreen(),
          DivaisScreen.routeName: (context) => const DivaisScreen(),
          KolamScreen.routeName: (context) => const KolamScreen(),
          PopupScreen.routeName: (context) => const PopupScreen(),
          StatusScreen.routeName: (context) => const StatusScreen(),
          TagihanScreen.routeName: (context) => const TagihanScreen(),
          NotifikasiScreen.routeName: (context) => const NotifikasiScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          MonitoringScreen.routeName: (context) => const MonitoringScreen(),
          PrediksiScreen.routeName: (context) => const PrediksiScreen(),
          ExportDataScreen.routeName: (context) => const ExportDataScreen(),
          FeedvisionScreen.routeName: (context) => const FeedvisionScreen(),
          AboutScreen.routeName: (context) => const AboutScreen(),
          AmoniaScreen.routeName: (context) => AmoniaScreen(),
          PerformaScreen.routeName: (context) => PerformaScreen(),
          AmoniaPredictionResultScreen.routeName: (context) =>
              const AmoniaPredictionResultScreen(),
          AddAlarmScreen.routeName: (context) => const AddAlarmScreen(),
        },
      ),
    );
  }
}
