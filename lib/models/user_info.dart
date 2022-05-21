class UserInfo{
   String? displayName;
   String? loginName;
   String? userRole;
   String? email;

   bool? isAddUser;
   bool? isEditUser;
   bool? isDeleteUser;

   UserInfo(
      {this.displayName,
        this.loginName,
        this.userRole,
        this.email,
        this.isAddUser,
        this.isEditUser,
        this.isDeleteUser});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      displayName: json['displayName'],
      loginName: json['loginName'],
      userRole: json['userRole'],
      email: json['email'],
      isAddUser: json['isAddUser'],
      isEditUser: json['isEditUser'],
      isDeleteUser: json['isDeleteUser'],
    );
  }
}