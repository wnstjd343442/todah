import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todah/features/auth/data/firebase_auth_repo.dart';
import 'package:todah/features/auth/domain/repos/auth_repo.dart';
import 'package:todah/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:todah/features/auth/presentation/cubits/auth_states.dart';
import 'package:todah/features/auth/presentation/pages/auth_page.dart';
import 'package:todah/features/home/presentation/pages/home_page.dart';
import 'package:todah/features/themes/light_mode.dart';

// unauthenticated => auth page
// authenticated => home page

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);
            if (authState is Unauthenticated) {
              return const AuthPage();
            }

            if (authState is Authenticated) {
              return const HomePage();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, authState) {
            if (authState is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(authState.message)));
            }
          },
        ),
      ),
    );
  }
}
