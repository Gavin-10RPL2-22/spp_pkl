class LoginResponseModel {
  final String token;
  final String nama_siswa;
  final String user;
  final String jumlah;
  final String message;

  LoginResponseModel({this.token, this.nama_siswa, this.user, this.message, this.jumlah});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      nama_siswa: json["nama_siswa"] != null ? json["nama_siswa"] : "",
      user: json["user"] != null ? json["user"] : "",
      jumlah: json["jumlah"] != null ? json["jumlah"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class LoginRequestModel {
  String nis;

  LoginRequestModel({
    this.nis,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'nis': nis.trim(),
    };

    return map;
  }
}
