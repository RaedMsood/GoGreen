import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/core/states/view.state.dart';

import 'package:gogreen/locator.dart';

import '../../data/model/evaluation_model.dart';
import '../../data/model/evaluation_pagination_model.dart';
import '../../data/repositories/evaluation_repo.dart';

final getEvaluationAndCommentProvider = StateNotifierProvider.autoDispose
    .family<GetEvaluationAndCommentController,
        GenerateDataState<EvaluationModel>, int>(
  (ref, int id) {
    return GetEvaluationAndCommentController(id);
  },
);

class GetEvaluationAndCommentController
    extends StateNotifier<GenerateDataState<EvaluationModel>> {
  final int id;

  GetEvaluationAndCommentController(this.id)
      : super(GenerateDataState<EvaluationModel>.initial(
            EvaluationModel.empty())) {
    getData();
  }

  final _controller = locator<EvaluationRepository>();

  Future<void> getData({
    bool moreData = false,
  }) async {
    if (state.viewState == ViewState.loadingMore ||
        state.viewState == ViewState.loading) return;

    if (moreData) {
      state = state.loadingMore();
    } else {
      state = state.loading();
    }

    int page = state.data.comment.currentPage + 1;
    final data = await _controller.getEvaluationAndComment(
      companyId: id,
      page: page,
    );

    if (data is DataSuccess) {
      var oldData = state.data;

      if (oldData.rates != 0.0) {
        PaginatedEvaluationModel commentData;
        commentData = oldData.comment.copyWith(
          data: [...oldData.comment.data, ...data.data!.comment.data],
          currentPage: data.data!.comment.currentPage,
        );
        oldData = oldData.copyWith(comment: commentData);
      } else {
        oldData = data.data!;
      }

      state = state.success(oldData);
    } else {
      state = state.failure(
        data.message,
        error: data.error,
      );
    }
  }
}

/// Add Evaluation And Comment Riverpod //////////////////////////////////
final addEvaluationAndCommentProvider = StateNotifierProvider.autoDispose
    .family<AddEvaluationAndCommentController, GenerateDataState<bool>, int>(
  (ref, int id) {
    return AddEvaluationAndCommentController(id);
  },
);

class AddEvaluationAndCommentController
    extends StateNotifier<GenerateDataState<bool>> {
  final int id;

  AddEvaluationAndCommentController(this.id)
      : super(GenerateDataState<bool>.initial(false));

  final _controller = EvaluationRepository();

  Future<void> add({
    required BuildContext context,
    required double rating,
    required String comment,
    required Function onSuccess,
  }) async {
    state = state.loading();

    final data = await _controller.addEvaluationAndComment(
      id,
      rating,
      comment.toString(),
    );

    if (data is DataSuccess) {
      onSuccess();
      state = state.success(true);
    } else {
      showFlashBarError(
        context: context,
        message: "${data.message} ${data.error!.desc.toString()}",
      );

      state = state.failure(data.message, error: data.error);
    }
  }
}

/// Add Evaluation And Comment Riverpod //////////////////////////////////
final addLikeOrDislikeProvider = StateNotifierProvider.autoDispose
   <AddLikeOrDislikeController, GenerateDataState<bool>>(
  (ref) {
    return AddLikeOrDislikeController();
  },
);

class AddLikeOrDislikeController
    extends StateNotifier<GenerateDataState<bool>> {

  AddLikeOrDislikeController()
      : super(GenerateDataState<bool>.initial(false));

  final _controller = locator<EvaluationRepository>();

  Future<void> addLike(
    {
      required  BuildContext context,
      required int commentId,
  }) async {
    state = state.loading();
    final data = await _controller.addLike(commentId);

    if (data is DataSuccess) {
      state = state.success(true);
    } else {
      showFlashBarError(
        context: context,
        message: "${data.message} ${data.error!.desc.toString()}",
      );

      state = state.failure(data.message, error: data.error);
    }
  }

  Future<void> dislike( {
    required  BuildContext context,
    required int commentId,
  }) async {
    state = state.loading();

    final data = await _controller.dislike(commentId);

    if (data is DataSuccess) {
      state = state.success(true);
    } else {
      showFlashBarError(
        context: context,
        message: "${data.message} ${data.error!.desc.toString()}",
      );

      state = state.failure(data.message, error: data.error);
    }
  }
}
