class UserModel {
  final String id;
  final String username;
  final String mobileNumber;
  final String password;
  final int points;
  final int recycledAmount;
  final double savedCarbon;
  final double savedPlastic;
  final double savedPaper;
  final bool vibrate;
  final bool beeb;

  UserModel({
    required this.id,
    required this.username,
    required this.mobileNumber,
    required this.password,
    required this.points,
    required this.recycledAmount,
    required this.savedCarbon,
    required this.savedPlastic,
    required this.savedPaper,
    this.vibrate = false,
    this.beeb    = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'mobileNumber': mobileNumber,
      'password': password,
      'points': points,
      'recycledAmount': recycledAmount,
      'savedCarbon': savedCarbon,
      'savedPlastic': savedPlastic,
      'savedPaper': savedPaper,
      'vibrate': vibrate,
      'beeb':    beeb,
    };
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      username: map['username'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      password: map['password'] ?? '',
      points: map['points']?.toInt() ?? 0,
      recycledAmount: (map['recycledAmount'] as num?)?.toInt() ?? 0,
      savedCarbon:    (map['savedCarbon']    as num?)?.toDouble() ?? 0.0,
      savedPlastic:   (map['savedPlastic']   as num?)?.toDouble() ?? 0.0,
      savedPaper:     (map['savedPaper']     as num?)?.toDouble() ?? 0.0,
      vibrate: map['vibrate'] as bool? ?? false,
      beeb:    map['beeb']    as bool? ?? false,
    );
  }
}
