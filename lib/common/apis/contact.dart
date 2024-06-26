import '../entities/contact.dart';
import '../util/http.dart';

class ContactAPI {
  /// refresh
  static Future<ContactResponseEntity> post_contact() async {
    var response = await HttpUtil().post(
      'api/v1/chat/contact',
    );
    return ContactResponseEntity.fromJson(response);
  }
}
