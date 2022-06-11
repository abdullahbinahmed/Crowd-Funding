class User {
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? city;
  String? postCode;
  String? country;
  String? zone;
  String? company;
  String? bankAccountNumber;
  String? bankName;
  String? role;
  String? cnic;
  String? bankCode;

  User(
      {this.email,
      this.firstName,
      this.lastName,
      this.phone,
      this.address,
      this.postCode,
      this.country,
      this.zone,
      this.bankAccountNumber,
      this.bankName,
      this.role,
      this.company,
      this.city,
      this.cnic,
      this.bankCode});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['emailId'] as String,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      phone: json['PhoneNumber'] as String,
      address: json['Address'] as String,
      city: json['City'] as String,
      postCode: json['PostalCode'] as String,
      country: json['Country'] as String,
      zone: json['zone'] as String,
      company: json['Company'] as String,
      bankAccountNumber: json['BankAccountNumber'] as String,
      bankName: json['BankName'] as String,
      role: json['Role'] as String,
      cnic: json['CNICNumber'] as String,
      bankCode: json['bankCode'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "address": address,
        "city": city,
        "postCode": postCode,
        "company": company,
        "bankAccountNumber": bankAccountNumber,
        "bankName": bankName,
        "role": role,
        "country": country,
        "cnic": cnic,
        "zone": zone,
        "bankCode": bankCode
      };
}
