import 'package:cashenya_app/auth_repository.dart';
import 'package:cashenya_app/features/login/cubit/login_cubit.dart';
import 'package:cashenya_app/features/signup/ui/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  static Page page() => const MaterialPage<void>(child: LogInPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      body: BlocProvider(
        create: (_) => LogInCubit(context.read<AuthRepository>()),
        child: const LogInForm(),
      ),
    );
  }
}

class LogInForm extends StatelessWidget {
  const LogInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocListener<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state.status == LogInStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
              ),
            );
          }
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmailInput(),
            _PasswordInput(),
            _LogInButton(),
            _SignUpButton(),
            _SignUpWithGoogleButton(),
          ],
        ),
      );
    });
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: TextFormField(
            onChanged: (email) => context.read<LogInCubit>().emailChanged(email),
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.person_rounded),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: true,
            onChanged: (password) => context.read<LogInCubit>().passwordChanged(password),
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_rounded),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}

class _LogInButton extends StatelessWidget {
  const _LogInButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LogInStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => context.read<LogInCubit>().logInWithCredentials(),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  fixedSize: const Size(250, 40),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login_rounded),
                    SizedBox(width: 10),
                    Text('Log In'),
                  ],
                ),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status == LogInStatus.submitting ? null : () => Navigator.of(context).push(SignUpPage.route()),
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            fixedSize: const Size(250, 40),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email_rounded),
              SizedBox(width: 10),
              Text('Sign Up with Email'),
            ],
          ),
        );
      },
    );
  }
}

class _SignUpWithGoogleButton extends StatelessWidget {
  const _SignUpWithGoogleButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status == LogInStatus.submitting ? null : () => context.read<LogInCubit>().logInWithGoogle(),
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            backgroundColor: Colors.white,
            fixedSize: const Size(250, 40),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.google),
              SizedBox(width: 10),
              Text('Sign Up with Google'),
            ],
          ),
        );
      },
    );
  }
}
