import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

String tag = 'api_provider';

const baseUrl = 'https://api.giphy.com/v1/gifs';

  const trndingURL= '/trending?api_key=2V5UL1JLCxqCV8UCQD9UTe802NMALZjs&limit=25&offset=0&rating=g&bundle=messaging_non_clips';
  const searchURL= '/search?api_key=2V5UL1JLCxqCV8UCQD9UTe802NMALZjs&q=';

handleException(error, stacktrace, DioError dioError) {
  debugPrint("Exception occurred: $error stackTrace: $stacktrace");
  if (dioError.response!.statusCode == 401) {
    throwIfNoSuccess("unauthorized".tr);
  } else if (dioError.response!.statusCode == 500) {
    if (dioError.response!.data == null) {
      throwIfNoSuccess("server_error".tr);
    } else {
      throwIfNoSuccess(dioError.response!.data['message']);
    }
  } else {
    if (dioError.response!.data == null) {
      throwIfNoSuccess("something_went_wrong".tr);
    } else {
      throwIfNoSuccess(dioError.response!.data['message']);
    }
  }
}

void throwIfNoSuccess(String response) {
  throw HttpException(response);
}
