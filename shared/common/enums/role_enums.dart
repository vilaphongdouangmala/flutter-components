enum UserRole {
  admin,
  webUser,
  mechanicUser,
  customerService,
}

extension UserRoleExtension on UserRole {
  String get title {
    switch (this) {
      case UserRole.admin:
        return "Admin";
      case UserRole.webUser:
        return "Web User";
      case UserRole.mechanicUser:
        return "Mechanic User";
      case UserRole.customerService:
        return "Customer Service";
      default:
        throw Exception("UserRole not found");
    }
  }

  int get value {
    switch (this) {
      case UserRole.admin:
        return 0;
      case UserRole.webUser:
        return 1;
      case UserRole.mechanicUser:
        return 2;
      case UserRole.customerService:
        return 3;
      default:
        throw Exception("UserRole not found");
    }
  }

  static UserRole fromValue(int value) {
    switch (value) {
      case 0:
        return UserRole.admin;
      case 1:
        return UserRole.webUser;
      case 2:
        return UserRole.mechanicUser;
      case 3:
        return UserRole.customerService;
      default:
        throw Exception("UserRole not found");
    }
  }
}
