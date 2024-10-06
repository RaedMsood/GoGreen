class ErrorEnum {
  static const authNotFound = '01_01';
  static const authPassIncorrect = '01_02';
  static const authAlreadyExist = '01_03';
  static const authInvalidToken = '01_04';
  static const authOldPassIncorrect = '01_05';
  static const authExpiredCode = '01_06';
  static const authInvalidCode = '01_07';
  static const authBanned = '01_08';
  static const authPhoneAlreadyExist = '01_09';
  static const roleAlreadyExist = '01_10';
  static const userNotExist = '01_11';
  static const userSuspended = '01_12';
  static const userNameExsist = '01_13';
  static const invalidReceipt = '02_01';
  static const userAlreadySubscribed = '02_02';
  static const purchaseAlreadyUsed = '02_03';
  static const notSubscribed = '02_05';
  static const newPasswordSameAsOldPassword = '03_03';
  static const theModifiedPasswordIsTheSameAsTheOldPassword = '03_16';
  static const oldPasswordIsNotTrue = '03_15';
  static const thereIsNoUserWithEmail = '03_01';
  static const otpIsNotCorrect = '03_05';
  static const userIsNotActivated = '03_02';
  static const unauthenticatedException = '0';
  static const friendRequestAlreadySentToThisNumber = '02_14';
  static const somethingWentWrong = '000';
  static const unknown = '00_00';

  //array of all error codes
  static const List<String> errorCodes = [
    authNotFound,
    authPassIncorrect,
    authAlreadyExist,
    authInvalidToken,
    authOldPassIncorrect,
    authExpiredCode,
    authInvalidCode,
    authBanned,
    authPhoneAlreadyExist,
    roleAlreadyExist,
    userNotExist,
    userSuspended,
    userNameExsist,
    invalidReceipt,
    userAlreadySubscribed,
    purchaseAlreadyUsed,
    notSubscribed,
    newPasswordSameAsOldPassword,
    theModifiedPasswordIsTheSameAsTheOldPassword,
    thereIsNoUserWithEmail,
    otpIsNotCorrect,
    oldPasswordIsNotTrue,
    userIsNotActivated,
    unauthenticatedException,
    friendRequestAlreadySentToThisNumber,
    somethingWentWrong,
    unknown,

  ];
}
