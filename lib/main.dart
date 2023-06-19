import 'package:any_percent_training_tracker/constants/routes.dart';
import 'package:any_percent_training_tracker/helpers/loading/loading_screen.dart';
import 'package:any_percent_training_tracker/services/auth/bloc/auth_bloc.dart';
import 'package:any_percent_training_tracker/services/auth/bloc/auth_event.dart';
import 'package:any_percent_training_tracker/services/auth/bloc/auth_state.dart';
import 'package:any_percent_training_tracker/services/auth/firebase_auth_provider.dart';
import 'package:any_percent_training_tracker/views/forgot_password_view.dart';
import 'package:any_percent_training_tracker/views/log/edit_stack_view.dart';
import 'package:any_percent_training_tracker/views/log/exercise_search_view.dart';
import 'package:any_percent_training_tracker/views/log/sessions_view.dart';
import 'package:any_percent_training_tracker/views/login_view.dart';
import 'package:any_percent_training_tracker/views/register_view.dart';
import 'package:any_percent_training_tracker/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Any Percent',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        exerciseSearchViewRoute: (context) => const ExerciseSearchView(),
        editStackViewRoute: (context) => const EditStackView(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.isLoading) {
        LoadingScreen().show(
          context: context,
          text: state.loadingText ?? 'Please wait a moment',
        );
      } else {
        LoadingScreen().hide();
      }
    }, builder: (context, state) {
      if (state is AuthStateLoggedIn) {
        return const SessionsView();
      } else if (state is AuthStateNeedsVerification) {
        return const VerifyEmailView();
      } else if (state is AuthStateLoggedOut) {
        return const LoginView();
      } else if (state is AuthStateForgotPassword) {
        return const ForgotPasswordView();
      } else if (state is AuthStateRegistering) {
        return const RegisterView();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });
  }
}
