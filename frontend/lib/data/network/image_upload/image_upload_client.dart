import 'package:dio/dio.dart';
import 'package:event_planr_app/env/env.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@singleton
class ImageUploadClient {
  ImageUploadClient({required this.dio});

  final Dio dio;

  Future<String> uploadOrganizationProfileImage(XFile image) async {
    final formData = FormData.fromMap({
      'ImageFile': MultipartFile.fromBytes(
        await image.readAsBytes(),
        filename: image.name,
      ),
    });
    final response = await dio.post<String>(
      '${Env.eventPlanrApiUrl}/organizationmanager/profileimage',
      data: formData,
    );
    return response.data!;
  }

  Future<String> uploadUserProfileImage(XFile image) async {
    final formData = FormData.fromMap({
      'ImageFile': MultipartFile.fromBytes(
        await image.readAsBytes(),
        filename: image.name,
      ),
    });
    final response = await dio.post<String>(
      '${Env.eventPlanrApiUrl}/chatmanager/profileimage',
      data: formData,
    );
    return response.data!;
  }

  Future<String> uploadEventCoverImage({
    required XFile image,
    required String eventId,
  }) async {
    final formData = FormData.fromMap({
      'ImageFile': MultipartFile.fromBytes(
        await image.readAsBytes(),
        filename: image.name,
      ),
    });
    final response = await dio.post<String>(
      '${Env.eventPlanrApiUrl}/eventmanager/coverimage/$eventId',
      data: formData,
    );
    return response.data!;
  }
}
