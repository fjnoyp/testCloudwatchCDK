import 'dart:io';

void main() {
  final metricName = const String.fromEnvironment('METRIC_NAME');
  final value = const String.fromEnvironment('VALUE');

  var metricNameTrimmed = metricName.trim();
  var valueTrimmed = value.trim();
  var metricNameRegex = RegExp(r'^[a-zA-Z0-9\ \_\-]+$');
  var valueRegex = RegExp(r'^[-+]?[0-9]+\.?[0-9]*$');
  if (!metricNameRegex.hasMatch(metricNameTrimmed)) {
    print(
        'Metric name can only contain alphanumeric characters, space character, -, and _.');
    exit(1);
  }
  if (!valueRegex.hasMatch(valueTrimmed)) {
    print('Metric value must be a valid number');
    exit(1);
  }
  Process.runSync('aws', [
    'cloudwatch',
    'put-metric-data',
    '--metric-name',
    metricName,
    '--namespace',
    'GithubCanaryApps',
    '--value',
    value
  ]);
}
