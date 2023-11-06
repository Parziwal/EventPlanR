import 'package:event_planr_app/ui/shared/widgets/image_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerItem extends StatelessWidget {
  const ImagePickerItem({required this.imagePicked, super.key, this.imageUrl});

  final String? imageUrl;
  final void Function(XFile file) imagePicked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWrapper(
          imageUrl: imageUrl,
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: IconButton.filledTonal(
            onPressed: () async {
              final picker = ImagePicker();
              final image = await picker.pickImage(source: ImageSource.gallery);

              if (image != null) {
                imagePicked(image);
              }
            },
            icon: const Icon(Icons.upload),
          ),
        ),
      ],
    );
  }
}
