  class ChartModel
{
  final String? title;
  final double? value;
  ChartModel ({this.title,this.value});

  factory ChartModel.fromMap(Map data)
  {
    return ChartModel(
      title: data['title'],
          value: double.parse(data['value'].toString() ?? "0")
    );
  }
}