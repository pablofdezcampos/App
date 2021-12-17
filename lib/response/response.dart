enum RegisterResponseStatus {
  success,
  userAlreadyExists,
  passwordShort,
  emailInvalid,
  emailPasswordRequired,
  networkError,
  unknowError
}

class RegisterResponse {
  RegisterResponseStatus status;
  String errorMessage;
  //String token;

  RegisterResponse(this.status, this.errorMessage);

  RegisterResponse.success(token, errorMessage)
      : this(RegisterResponseStatus.success, errorMessage);

  RegisterResponse.userAlreadyExists(errorMessage)
      : this(RegisterResponseStatus.userAlreadyExists, errorMessage);

  RegisterResponse.passwordShort(errorMessage)
      : this(RegisterResponseStatus.passwordShort, errorMessage);

  RegisterResponse.emailInvalid(errorMessage)
      : this(RegisterResponseStatus.emailInvalid, errorMessage);

  RegisterResponse.emailPasswordRequired(errorMessage)
      : this(RegisterResponseStatus.emailPasswordRequired, errorMessage);

  RegisterResponse.networkError(errorMessage)
      : this(RegisterResponseStatus.networkError, errorMessage);

  RegisterResponse.unknowError(errorMessage)
      : this(RegisterResponseStatus.unknowError, errorMessage);
}
