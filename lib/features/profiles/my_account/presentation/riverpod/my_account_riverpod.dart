import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/features/profiles/my_account/data/model/my_account_model.dart';
import 'package:gogreen/features/profiles/my_account/data/reposaitories/my_account_repo.dart';
import 'package:gogreen/features/profiles/my_account/presentation/widget/change_password_form.dart';
import 'package:gogreen/features/profiles/my_account/presentation/widget/update_personal_form.dart';
import 'package:gogreen/features/profiles/my_account/presentation/widget/update_store_form.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:gogreen/features/user/data/model/auth.model.dart';
import 'package:gogreen/features/user/data/model/user.model.dart';

final getMyAccountProvider = StateNotifierProvider.autoDispose<
    GetMyAccountController,
    GenerateDataState<MyAccountModel>>(
      (ref) {
    return GetMyAccountController();
  },
);

class GetMyAccountController
    extends StateNotifier<GenerateDataState<MyAccountModel>> {
  GetMyAccountController()
      : super(
      GenerateDataState<MyAccountModel>.initial(MyAccountModel.empty())) {
    getProfile();
  }

  final _controller = MyAccountRepository();

  Future<void> getProfile() async {
    state = state.loading();
    final data = await _controller.getProfile();
    if (data is DataSuccess) {
      updateForms(data.data!);
      state = state.success(data.data!);
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }

  updateForms(MyAccountModel data) {
    UpdateMyAccountController.storeForm.group.patchValue({
      'store_name': data.storeName,
      'store_address': data.storeAddress,
      'commercial_number': data.commercialNumber,
    });
    UpdateMyAccountController.personalForm.group.patchValue({
      'name': data.name,
      'email': data.email,
      'phone': data.phoneNumber,
    });
  }
}

/// Update my account and change password riverpod
final updateMyAccountProvider = StateNotifierProvider.autoDispose<
    UpdateMyAccountController,
    GenerateDataState<UserModel>>(
      (ref) {
    return UpdateMyAccountController();
  },
);

class UpdateMyAccountController
    extends StateNotifier<GenerateDataState<UserModel>> {
  UpdateMyAccountController()
      : super(GenerateDataState<UserModel>.initial(Auth().user.user));

  final _controller = MyAccountRepository();

  static UpdateStoreFormController storeForm = UpdateStoreFormController();
  static UpdatePersonalFormController personalForm =
  UpdatePersonalFormController();

  final ChangePasswordFormController changePasswordForm =
  ChangePasswordFormController();

  bool isValid() {
    storeForm.group.markAllAsTouched();
    personalForm.group.markAllAsTouched();

    return storeForm.group.valid && personalForm.group.valid;
  }

  Future<void> updateMyAccount(BuildContext context, {
    required double lat,
    required double lng,
    required Function onSuccess,
  }) async {
    if (!isValid()) return;
    state = state.loading();
    final Map<String, dynamic> form = {
      ...storeForm.group.value,
      ...personalForm.group.value,
    };

    final data = await _controller.updateProfile(
      phone: form['phone'],
      name: form['name'],
      email: form['email'],
      storeName: form['store_name'],
      storeAddress: form['store_address'],
      commercialNumber: form['commercial_number'],
      lat: lat.toString(),
      lng: lng.toString(),
    );

    if (data is DataSuccess) {
      Auth().login(AuthModel(token: Auth().token, user: data.data!));
      onSuccess();

      state = state.success(data.data!);
    } else {
      _errorFlashBar(data.message, data.error!.desc.toString(),
          context: context);
      state = state.failure(data.message, error: data.error);
    }
  }

  //changePassword
  Future<void> changePassword(BuildContext context, {
    required Function onSuccess,
  }) async {
    changePasswordForm.group.markAllAsTouched();
    if (!changePasswordForm.group.valid) return;
    state = state.loading();
    final Map<String, dynamic> form = changePasswordForm.group.value;
    final data = await _controller.changePassword(
      oldPassword: form['old_password'],
      newPassword: form['new_password'],
      confirmPassword: form['password_confirmation'],
    );

    if (data is DataSuccess) {
      await Auth().logout();
      onSuccess();

      state = state.success(state.data);
    } else {
      _errorFlashBar(data.message, data.error!.desc.toString(),
          context: context);
      state = state.failure(data.message, error: data.error);
    }
  }

  void _errorFlashBar(String message, String desc,
      {required BuildContext context}) {
    showFlashBarError(
      message: "$message ${desc.toString()}",
      context: context,
    );
  }

  void _successFlashBar(String message, BuildContext context) {
    showFlashBarSuccess(
      message: message,
      context: context,
    );
  }
}

/// Update Email Riverpod /////////////////////////////////////////////
final updateEmailProvider = StateNotifierProvider.autoDispose<
    UpdateEmailController,
    GenerateDataState<bool>>(
      (ref) {
    return UpdateEmailController();
  },
);

class UpdateEmailController extends StateNotifier<GenerateDataState<bool>> {
  UpdateEmailController() : super(GenerateDataState<bool>.initial(false));
  final _controller = MyAccountRepository();

  Future<void> updateEmail(BuildContext context, {
    required String oldEmail,
    required String newEmail,
    required Function onSuccess,
  }) async {
    state = state.loading();
    final data = await _controller.updateEmail(
      oldEmail: oldEmail,
      newEmail: newEmail,
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
