class AppInfoModel {
  final String badgesSystem;
  final String privacyPolicy;
  final String applicationVersion;
  final String applicationDescription;
  final List<PhoneNumber> phoneNumbers;
  final String email;
  final String whatsapp;
  final String facebook;
  final String twitter;
  final String instagram;

  AppInfoModel({
    required this.badgesSystem,
    required this.privacyPolicy,
    required this.applicationVersion,
    required this.applicationDescription,
    required this.phoneNumbers,
    required this.email,
    required this.whatsapp,
    required this.facebook,
    required this.twitter,
    required this.instagram,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) => AppInfoModel(
        badgesSystem: json['badges_system'],
        privacyPolicy: json['privacy_policy'],
        applicationVersion: json['application_version'],
        applicationDescription: json['application_description'],
        phoneNumbers: List<PhoneNumber>.from(
            json['phone_numbers'].map((x) => PhoneNumber.fromJson(x))),
        email: json['email'],
        whatsapp: json['whatsapp'],
        facebook: json['facebook'],
        twitter: json['twitter'],
        instagram: json['instagram'],
      );

  Map<String, dynamic> toJson() => {
        'badges_system': badgesSystem,
        'privacy_policy': privacyPolicy,
        'application_version': applicationVersion,
        'application_description': applicationDescription,
        'phone_numbers':
            List<dynamic>.from(phoneNumbers.map((x) => x.toJson())),
        'email': email,
        'whatsapp': whatsapp,
        'facebook': facebook,
        'twitter': twitter,
        'instagram': instagram,
      };

  //empty
  static AppInfoModel empty() => AppInfoModel(
        badgesSystem: '',
        privacyPolicy: '',
        applicationVersion: '',
        applicationDescription: '',
        phoneNumbers: [],
        email: '',
        whatsapp: '',
        facebook: '',
        twitter: '',
        instagram: '',
      );
}

class PhoneNumber {
  final String phone;

  PhoneNumber({
    required this.phone,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'phone': phone,
      };
}
