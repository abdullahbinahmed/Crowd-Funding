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
      this.cnic});

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
        "zone": zone
      };
}
