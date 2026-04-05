import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../../repository/domain/catalog/entities/catalogs.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<LoginBloc, LoginState>(
      listenWhen: _listenWhenStatusChanged,
      listener: (context, state) => _handleState(context, state),
      child: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSize.spacedViewSpacing),
                  Center(
                    child: Image.asset(
                      AppImages.logo,
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ),
                  const SizedBox(height: AppSize.viewSpacing),
                  Text(
                    "${LocaleKeys.hi.value} ${LocaleKeys.welcome.value}",
                    style: theme.textTheme.titleMedium?.copyWith(fontSize: 36),
                  ),
                  const SizedBox(height: AppSize.viewSpacing),
                  UserNameInput(textController: _usernameController),
                  const SizedBox(height: AppSize.inset),
                  _PasswordInput(),
                  const SizedBox(height: AppSize.inset),
                  _UserTypeInput(),
                  const SizedBox(height: AppSize.inset),
                  const RememberView(),
                  const SizedBox(height: AppSize.viewSpacing * 2),
                  CustomButton(
                    title: LocaleKeys.login.value,
                    onPressed: () => _onLoginPressed(context),
                  ),
                  const SizedBox(height: AppSize.inset),
                ],
              ),
            ),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: BuildBottomSection(),
            ),
          ],
        ),
      ),
    );
  }


  void _onLoginPressed(BuildContext context) {
    KeyboardUtil.hideKeyboard(context);

    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(AuthenticateUser());
    }
  }

  // -------------------- LISTENER --------------------

  bool _listenWhenStatusChanged(LoginState prev, LoginState curr) {
    return prev.status != curr.status;
  }

  void _handleState(BuildContext context, LoginState state) {
    final status = state.status;

    (status is InProgress) ? LoadingView.show() : LoadingView.hide();

    if (status is Success) {
      _navigate(context, state.userType.id);
    } else if (status is SubmissionFailure) {
      ErrorResolver.resolve(context, status);
    }
  }

  void _navigate(BuildContext context, String userType) {
    Navigator.of(context).pushReplacementNamed(
      _resolveRoute(userType),
    );
  }

  String _resolveRoute(String userType) {
    switch (userType) {
      case "admin":
        return AppRoute.admin;
      case "operator":
        return AppRoute.operator;
      default:
        return AppRoute.user;
    }
  }
}

class UserNameInput extends StatelessWidget {
  const UserNameInput({super.key, required this.textController});
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.persistUsername != current.persistUsername,
      listener: (context, state) {
        textController.text = state.persistUsername;
        textController.selection = TextSelection.collapsed(offset: state.persistUsername.length);
      },
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return AppTextfield(
          controller: textController,
          maxLength: 254,
          title: LocaleKeys.emailAddressTitle.value,
          placeHolder: LocaleKeys.emailAddressPlaceholder.value,
          validator: (_) => state.usernameValidation,
          onChanged: (username) {
            context.read<LoginBloc>().add(UsernameNumberChanged(username));
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AppTextfield(
          obscureSign: "•",
          title: LocaleKeys.passwordTitle.value,
          placeHolder: LocaleKeys.enterPassword.value,
          isObscure: true,
          textInputType: TextInputType.visiblePassword,
          validator: (_) => state.passwordValidation,
          onChanged: (password) {
            context.read<LoginBloc>().add(PasswordChanged(password));
          },
        );
      },
    );
  }
}

class _UserTypeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.userType != current.userType,
      builder: (context, state) {
        return AppDropDown<Catalog>(
          title: "User Type",
          placeholder: "Select User Type",
          items: state.userTypeList,
          selectedItem: state.userType,
          onChanged: (userType) {
            context.read<LoginBloc>().add(UserTypeSelected(userType));
          },
        );
      },
    );
  }
}

class RememberView extends StatelessWidget {
  const RememberView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.isRememberMe != current.isRememberMe,
      builder: (context, state) {
        return Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    height: AppSize.checkBoxHeight,
                    width: AppSize.checkBoxHeight,
                    child: Checkbox(
                      side: WidgetStateBorderSide.resolveWith(
                        (states) => const BorderSide(width: 1.0, color: Colors.grey),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                      checkColor: Colors.black,
                      fillColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
                        return Colors.white;
                      }),
                      value: state.isRememberMe,
                      onChanged: (_) => context.read<LoginBloc>().add(RememberMe()),
                    ),
                  ),
                  const SizedBox(width: AppSize.cornerRadiusMedium),
                  Text(
                    LocaleKeys.rememberMe.value,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.forgotPassword);
                },
                child: Text(
                  LocaleKeys.forgotPassword.value,
                  textAlign: TextAlign.end,
                  style: theme.textTheme.titleMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BuildBottomSection extends StatelessWidget {
  const BuildBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.viewSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              LocaleKeys.loginAsGuest.value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  LocaleKeys.notHaveAnOptions.value,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: AppSize.cornerRadiusMedium),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.newMemberPage);
                },
                child: Text(
                  LocaleKeys.signUp.value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
