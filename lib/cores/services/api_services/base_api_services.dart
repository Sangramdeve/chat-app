abstract class BaseApiServices{
  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(String url,data);
  Future<dynamic> putApi();
  Future<dynamic> patchApi();
  Future<dynamic> deleteApi();
}