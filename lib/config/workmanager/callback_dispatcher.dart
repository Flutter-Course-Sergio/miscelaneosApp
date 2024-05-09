import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey =
    'com.sergiobarreras.miscelaneos.fetch-background-pokemon';
const fetchPeriodicBackgroundTaskKey =
    'com.sergiobarreras.miscelaneos.fetch-background-pokemon';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case fetchBackgroundTaskKey:
        print('fetchBackgroundTaskKey');
        break;
      case fetchPeriodicBackgroundTaskKey:
        print('fetchPeriodicBackgroundTaskKey');
        break;
    }
    return true;

    // print("Native: called background task $taskName");
  });
}
