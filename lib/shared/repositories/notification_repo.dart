import 'package:cache/cache.dart';
import 'package:firebase_database/firebase_database.dart';

class NotificationsRepo {
  //-- Config
  final _cache = const Cache<List<String>>('designations');
  final _dbTheses = FirebaseDatabase.instance.ref('theses');
  final _dbResearches = FirebaseDatabase.instance.ref('researches');
  final _errorMsgDesignationsNotFound = 'Designations not found!';
  final _errorMsgDesignations = "Couldn't get the designations!";

  //-- Public APIs
  /// Get list of designation.
  // Stream<List<Thesis>> get stream async* {

  //   yield* _dbTheses.onValue.asyncMap<List<Thesis>>(
  //     (event) async {
  //       final theses = <Thesis>[];
  //       for (final snapshot in event.snapshot.children) {
  //         final thesis = await snapshotToModel(snapshot);
  //         if (thesis != null) theses.add(thesis);
  //       }
  //       return _cache.value = theses;
  //     },
  //   );
  // }
}
