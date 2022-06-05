
import 'package:dio/dio.dart';

class DioHelper {
  static late final Dio dio;
  static init ()async{
    dio =  Dio(
        BaseOptions(
            baseUrl: 'http://127.0.0.1:8000/api/',
            receiveDataWhenStatusError: true,
            headers:{
              'Content-Type':'application/json',
              "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
              "Access-Control-Allow-Methods": "POST, OPTIONS",
              "Access-Control_Allow_Origin": "*"

            }

    )
    );

  }

  static Future getData({required url, query,
    token})async{
    return await dio.get(url,queryParameters: query);
  }

  static Future deleteData({required url}){
    return dio.delete(url);
  }
  static Future updateData({required url,required data}){
    return dio.put(url, data: data);
  }

  static Future<Response> postData({
    required  url,
    query,
    required data,
    token
  })async{

    return  dio.post(url,
        queryParameters: query,
        data: data
    );
  }
}