import 'dart:convert';

class NotificationModel {
  dynamic id;
  dynamic title;
  dynamic content;
  dynamic notRead;
  dynamic url;
  dynamic createdAt;
  dynamic closePage;
  List<dynamic> refreshPages;

  NotificationModel({
    this.id = '',
    this.title = '',
    this.content = '',
    this.createdAt = '',
    this.closePage = '',
    this.url = '',
    this.refreshPages = const [],
    this.notRead = true,
  });

  NotificationModel fromJson(Map<String, dynamic> json) {
    return NotificationModel.fromJson(json);
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json = jsonDecode(json['data']);
    }

    return NotificationModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      createdAt: json['created_at'] ?? '',
      closePage: json['closePage'] ?? '',
      refreshPages: json['refreshPages'] ?? [],
      notRead: json['notRead'] ?? false,
    );
  }

  Map<String, String> toJson() {
    return {
      '_id': id ?? '',
      'title': title ?? '',
      'content': content ?? '',
      'created_at': createdAt ?? '',
      'closePage': closePage ?? '',
      'refreshPages': refreshPages.toString(),
      'notRead': notRead ?? false
    };
  }

  Map<String, String> toShowNotification() {
    return {
      '_id': id ?? '',
      'title': title ?? '',
      'content': content ?? '',
    };
  }
}
