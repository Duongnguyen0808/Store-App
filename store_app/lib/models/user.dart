import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });
  //Serialization: Covert User object to a Map
  //Map: A Map is a collection of key-value pairs
  //Why: Covering to a map is an intermediate step that makes it easier to serialize
  //The object to formates like Json for storage or transmission

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

  //Serialization: Covert Map to a Json String
  //This method directly encodes the data from the Map into a Json String

  //The json.encode() function converts a Dart object (such as Map or List)
  //into a Json String reprensentation , making it suitable for communication
  //between different system.
  String toJson() => json.encode(toMap());

  //Deserialization: Covert a Map to a user Object
  //purpose - Manipulation and user : Once the data is coverted a to a User object
  //it can be easily manipuated and use within the application . For example
  //we might want to display the user's fullName, email etc on the Ui. Or we might
  //want to save the data locally.

  //the factory contructor takes a Map(Usually obtained from a json object)
  //and coverts it into a user Object. If a field is not presend in the,
  //it defaults to an empty String.

  //fromMap: This contructor take a Map<String, dynamic> and coverts into a user Object
  // its usefull when you already have the data in map format
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
      token: map['token'] as String? ?? "",
    );
  }

  //fromJson: This factory contructor takes Json String, and decodes into a Map<String, dynamic>
  //and then uses fromMap to covert that Map into a User Object

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
