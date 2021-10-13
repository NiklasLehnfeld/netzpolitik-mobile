import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingManager {

  static const DAYS_TO_ASK = 31;
  static const ARTICLES_TO_READ = 10;
  static const RATING_DIALOG_LAST_ASKED_KEY = 'RATING_DIALOG_LAST_ASKED_KEY';
  static const RATING_DIALOG_ARTICLE_COUNT_KEY = 'RATING_DIALOG_ARTICLE_COUNT_KEY';

  SharedPreferences? _sharedPreferences;
  final InAppReview _inAppReview = InAppReview.instance;

  RatingManager() {
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }

  Future<void> reset() async {
    await _sharedPreferences?.setInt(RATING_DIALOG_ARTICLE_COUNT_KEY, 0);
    await _sharedPreferences?.setInt(RATING_DIALOG_LAST_ASKED_KEY, DateTime.now().millisecondsSinceEpoch);
  }

  DateTime get _lastAskedDate {
    var timestamp = _sharedPreferences?.getInt(RATING_DIALOG_LAST_ASKED_KEY);
    if (timestamp == null) {
      timestamp = DateTime.now().millisecondsSinceEpoch;
      _sharedPreferences?.setInt(RATING_DIALOG_LAST_ASKED_KEY, timestamp);
    }
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  int get _articleReadCount {
    var count = _sharedPreferences?.getInt(RATING_DIALOG_ARTICLE_COUNT_KEY);
    count ??= 0;
    return count;
  }

  bool get _shouldShowDialog {
    return DateTime.now().difference(_lastAskedDate).inDays > DAYS_TO_ASK &&
      _articleReadCount > ARTICLES_TO_READ;
  }

  void trackArticleRead() async {
    var count = _articleReadCount;
    await _sharedPreferences?.setInt(RATING_DIALOG_ARTICLE_COUNT_KEY, count + 1);

    if (_shouldShowDialog && await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
      await reset();
    }
  }

  void openStore() async {
    await _inAppReview.openStoreListing();
  }

}