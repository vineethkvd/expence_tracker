class ViewTaskModel {
  String? id;
  String? taskName;
  String? taskDescription;
  String? taskStartDate;
  String? taskEndDate;
  String? document;
  String? amount;

  ViewTaskModel(
      {this.id,
        this.taskName,
        this.taskDescription,
        this.taskStartDate,
        this.taskEndDate,
        this.document,
        this.amount});

  ViewTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['taskName'];
    taskDescription = json['taskDescription'];
    taskStartDate = json['taskStartDate'];
    taskEndDate = json['taskEndDate'];
    document = json['document'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['taskName'] = this.taskName;
    data['taskDescription'] = this.taskDescription;
    data['taskStartDate'] = this.taskStartDate;
    data['taskEndDate'] = this.taskEndDate;
    data['document'] = this.document;
    data['amount'] = this.amount;
    return data;
  }
}
