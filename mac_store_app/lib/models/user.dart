import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
  });

  // Chuyển đổi (serialize) đối tượng User thành một Map
  // Map: Là tập hợp của các cặp key-value (khóa - giá trị)
  // Tại sao cần chuyển sang Map?
  // - Đây là bước trung gian giúp dễ dàng chuyển đổi đối tượng thành các định dạng như JSON
  // - Hữu ích khi lưu trữ vào cơ sở dữ liệu hoặc truyền tải qua mạng

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "password": password,
    };
  }
  // Chuyển đổi (serialize) Map thành chuỗi JSON
  // Phương thức này mã hóa dữ liệu từ Map thành chuỗi JSON
  //
  // Hàm json.encode() chuyển một đối tượng Dart (chẳng hạn như Map hoặc List)
  // thành chuỗi JSON, giúp dữ liệu có thể dễ dàng giao tiếp giữa các hệ thống khác nhau.

  String toJson() => json.encode(toMap());

  // Chuyển đổi (deserialize) một Map thành đối tượng User
  //
  // Mục đích: Sau khi dữ liệu được chuyển đổi thành đối tượng User,
  // ta có thể dễ dàng thao tác và sử dụng trong ứng dụng.
  // Ví dụ: Hiển thị thông tin người dùng trên UI hoặc lưu trữ cục bộ.
  //
  // Factory constructor nhận một Map (thường lấy từ một đối tượng JSON)
  // và chuyển nó thành đối tượng User. Nếu một trường không tồn tại trong Map,
  // nó sẽ mặc định là chuỗi rỗng ("").

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
    );
  }

  // fromJson: Hàm tạo (factory constructor) nhận vào một chuỗi JSON,
  // sau đó chuyển đổi (giải mã) thành một Map<String, dynamic>
  // và tiếp tục sử dụng fromMap để tạo đối tượng User.

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
