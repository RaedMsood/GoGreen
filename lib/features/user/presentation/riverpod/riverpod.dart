import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/features/user/data/model/auth.model.dart';
import 'package:gogreen/features/user/data/repos/user_repo.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/features/user/presentation/forms/forget_password_form.dart';
import 'package:gogreen/features/user/presentation/forms/login_form.dart';
import 'package:gogreen/features/user/presentation/forms/register_personal_form.dart';
import 'package:gogreen/features/user/presentation/forms/register_store_form.dart';
import 'package:gogreen/features/user/presentation/forms/reset_password_form.dart';

/// Log In //////////////////////////////////////////////////////////////////////////////////
final loginProvider = StateNotifierProvider.autoDispose<LoginRiverpodController,
    GenerateDataState<AuthModel>>(
  (ref) {
    return LoginRiverpodController();
  },
);

class LoginRiverpodController
    extends StateNotifier<GenerateDataState<AuthModel>> {
  LoginRiverpodController()
      : super(GenerateDataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = UserRepository();
  final LoginForm loginForm = LoginForm();

  bool isValid() {
    loginForm.group.markAllAsTouched();
    return loginForm.group.valid;
  }

  Future<void> login(
    BuildContext context, {
    required Function onSuccess,
    required Function onUserActivated,
  }) async {
    if (!isValid()) return;
    state = state.loading();

    final Map<String, dynamic> form = loginForm.group.value;
    final data = await _controller.login(
      email: form['email'],
      password: form['password'],
    );

    if (data is DataSuccess) {
      await Auth().login(data.data!);
      onSuccess();
      state = state.success(data.data!);
    } else {
      showFlashBarError(
        context: context,
        message: "${data.message} ${data.error!.desc.toString()}",
      );
      state = state.failure(data.message, error: data.error);
    }
  }
}

/// Sign Up /////////////////////////////////////////////////////////////////////////////////
final registerProvider = StateNotifierProvider.autoDispose<RegisterController,
    GenerateDataState<AuthModel>>(
  (ref) {
    return RegisterController();
  },
);

class RegisterController extends StateNotifier<GenerateDataState<AuthModel>> {
  RegisterController()
      : super(GenerateDataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = UserRepository();

  final RegisterStoreForm storeForm = RegisterStoreForm();
  final RegisterPersonalForm personalForm = RegisterPersonalForm();

  bool isValid() {
    storeForm.group.markAllAsTouched();
    personalForm.group.markAllAsTouched();

    return storeForm.group.valid && personalForm.group.valid;
  }

  Future<void> register(
    BuildContext context, {
    required double lat,
    required double lng,
    required Function onSuccess,
  }) async {
    state = state.loading();
    final Map<String, dynamic> form = {
      ...storeForm.group.value,
      ...personalForm.group.value,
    };

    final data = await _controller.register(
      phone: form['phone'],
      name: form['name'],
      email: form['email'],
      password: form['password'],
      confirmPassword: form['password_confirmation'],
      commercialNumber: form['commercial_number'],
      storeName: form['store_name'],
      storeAddress: form['store_address'],
      lat: lat.toString(),
      lng: lng.toString(),
    );

    if (data is DataSuccess) {
      Auth().login(data.data!);
      onSuccess();
      state = state.success(data.data!);
    } else {

      showFlashBarError(
        message: "${data.message} ${data.error!.desc.toString()}",
        context: context,
      );
      state = state.failure(data.message, error: data.error);
    }
  }

  /// Send OTP ///
  Future<void> sendOTP(
    BuildContext context, {
    required Function onSuccess,
        required Function resendOTP,

      }) async {
    state = state.loading();
    final email = personalForm.group.control('email').value;

    final data = await _controller.sendOTP(
      email: email,
    );
    Auth().setEmail(email);

    if (data is DataSuccess) {
      onSuccess();
      state = state.success(AuthModel.empty());
    } else {
      if(data.message=="User is not activated. Please go check OTP."){
        resendOTP();
      }else{
        showFlashBarError(
          message: "${data.message} ${data.error!.desc.toString()}",
          context: context,
        );
      }
      state = state.failure(data.message, error: data.error);

    }
  }
}

/// Check OTP /////////////////////////////////////////////////////////////////////////////////
final checkOtpProvider = StateNotifierProvider.autoDispose<CheckOtpController,
    GenerateDataState<bool>>(
  (ref) {
    return CheckOtpController();
  },
);

class CheckOtpController extends StateNotifier<GenerateDataState<bool>> {
  CheckOtpController() : super(GenerateDataState<bool>.initial(false));
  final _controller = UserRepository();

  Future<void> checkOtp(
    BuildContext context, {
    required Function onSuccess,
    required String otp,
  }) async {
    state = state.loading();
    final data = await _controller.checkOtp(
      email: Auth().tempEmail,
      otp: otp,
    );

    if (data is DataSuccess) {
      onSuccess();
      state = state.success(true);
    } else {
      showFlashBarError(
        message: "${data.message} ${data.error!.desc.toString()}",
        context: context,
      );

      state = state.failure(data.message, error: data.error);
    }
  }
}

/// Resend Otp /////////////////////////////////////////////
final resendOtpProvider = StateNotifierProvider.autoDispose<ResendOtpController,
    GenerateDataState<bool>>(
  (ref) {
    return ResendOtpController();
  },
);


class ResendOtpController extends StateNotifier<GenerateDataState<bool>> {
  ResendOtpController() : super(GenerateDataState<bool>.initial(false));
  final _controller = UserRepository();

  Future<void> resendOtp(
    BuildContext context, {
    required Function onSuccess,
  }) async {
    state = state.loading();
    final data = await _controller.resendOtp(
      email: Auth().tempEmail,
    );

    if (data is DataSuccess) {
      onSuccess();
      state = state.success(true);
    } else {
      showFlashBarError(
        message: "${data.message} ${data.error!.desc.toString()}",
        context: context,
      );

      state = state.failure(data.message, error: data.error);
    }
  }
}

/// Forget Password //////////////////////////////////////////////////////////////////////////
final forgetPasswordProvider = StateNotifierProvider.autoDispose<
    ForgetPasswordController, GenerateDataState<bool>>(
  (ref) {
    return ForgetPasswordController();
  },
);

class ForgetPasswordController extends StateNotifier<GenerateDataState<bool>> {
  ForgetPasswordController() : super(GenerateDataState<bool>.initial(false));
  final _controller = UserRepository();
  final ForgetPasswordFormController form = ForgetPasswordFormController();

  bool isValid() {
    form.group.markAllAsTouched();
    return form.group.valid;
  }

  Future<void> forgetPassword({
    required BuildContext context,
    required Function onSuccess,
  }) async {
    if (!isValid()) return;
    state = state.loading();
    final email = form.group.control('email').value;

    final data = await _controller.forgetPassword(
      email: email,
    );

    if (data is DataSuccess) {
      Auth().setEmail(email);
      onSuccess();
      state.success(true);
    } else {
      showFlashBarError(
        message: "${data.message} ${data.error!.desc.toString()}",
        context: context,
      );
      state = state.failure(data.message, error: data.error);
    }
  }
}

/// Reset Password //////////////////////////////////////////////////////////////////////////
final resetPasswordProvider = StateNotifierProvider.autoDispose<
    ResetPasswordController, GenerateDataState<bool>>(
  (ref) {
    return ResetPasswordController();
  },
);

class ResetPasswordController extends StateNotifier<GenerateDataState<bool>> {
  ResetPasswordController() : super(GenerateDataState<bool>.initial(false));
  final _controller = UserRepository();
  final ResetPasswordFormController form = ResetPasswordFormController();

  Future<void> resetPassword(
    BuildContext context, {
    required Function onSuccess,
  }) async {
    if (!form.group.valid) {
      return;
    }
    state = state.loading();
    final data = await _controller.resetPassword(
      email: Auth().tempEmail,
      password: form.group.control('password').value,
      confirmPassword: form.group.control('password_confirmation').value,
    );

    if (data is DataSuccess) {
      onSuccess();
      state = state.success(true);
    } else {
      showFlashBarError(
        message: "${data.message} ${data.error!.desc.toString()}",
        context: context,
      );

      state = state.failure(data.message, error: data.error);
    }
  }
}
