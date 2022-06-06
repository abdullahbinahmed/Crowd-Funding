//@dart=2.10

class Campaign {
  final String description;
  final String endDate;
  final String id;
  final String name;
  final String amoutAcheived;
  final String targetAmount;
  final String startDate;
  final String imagePath;
  final String userId;

  Campaign(
      {this.description,
      this.endDate,
      this.id,
      this.name,
      this.amoutAcheived,
      this.targetAmount,
      this.startDate,
      this.imagePath,
      this.userId});

  Map<String, dynamic> toJson() => {
        "description": description,
        "endDate": endDate,
        "id": id,
        "name": name,
        "amoutAcheived": amoutAcheived,
        "targetAmount": targetAmount,
        "imagePath": imagePath,
        "userId": userId
      };
}
