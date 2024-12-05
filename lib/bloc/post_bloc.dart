import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:sm_assignment_1/models/post_model.dart';
import 'package:sm_assignment_1/utils/constants/app_constants.dart';

abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class SavePosts extends PostEvent {}

class LoadPosts extends PostEvent {}

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;

  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String error;

  PostError(this.error);
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<SavePosts>(_onSavePosts);
    on<LoadPosts>(_onLoadPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final response =
          await http.get(Uri.parse('${AppConstants.baseURl}posts'));

      if (response.statusCode == 200) {
        emit(PostLoaded(postModelFromJson(response.body)));
      } else {
        emit(PostError('Failed to fetch posts'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  FutureOr<void> _onSavePosts(SavePosts event, Emitter<PostState> emit) async {
    int retryCount = 0;

    while (state is! PostLoaded && retryCount < 500) {
      await Future.delayed(const Duration(milliseconds: 500));
      retryCount++;
    }

    if (state is PostLoaded) {
      final postBox = Hive.box("postBox");

      final posts = (state as PostLoaded)
          .posts
          .map((post) => jsonEncode(post.toJson()))
          .toList();

      postBox.put("data", posts);
    }
  }

  FutureOr<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) {
    final postBox = Hive.box("postBox");
    final savedData = postBox.get("data") as List<dynamic>;
    final posts =
        savedData.map((e) => PostModel.fromJson(jsonDecode(e))).toList();
    emit(PostLoaded(posts));
  }
}
