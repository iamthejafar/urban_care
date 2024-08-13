import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../../core/theme/colors.dart';
import '../../utils/app_image_picker.dart';
import '../providers/global_providers.dart';
import 'custom_dotted_container.dart';


class CustomImageGrid extends ConsumerStatefulWidget {
  const CustomImageGrid(
      {required this.providerId, this.length = 6,super.key});

  final int length;
  final String providerId;

  @override
  ConsumerState<CustomImageGrid> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends ConsumerState<CustomImageGrid> {

  final List<File> _pickedImages = [];
  Future<void> chooseImage({required bool isCamera}) async {
    File? pickedFile;
    if (isCamera) {
      pickedFile = await ref.read(mediaProvider).captureMedia();
    } else {
      pickedFile = await ref.read(mediaProvider).pickImage();
    }
    if (pickedFile != null) {
      _pickedImages.add(pickedFile);
      ref.read(pickedImageProvider(widget.providerId).notifier).setImages(_pickedImages);
      setState(() {});
    }
  }

  Future<void> chooseMultiImage({required int imageCount}) async {
    final pickedFile = await ref
        .read(mediaProvider)
        .pickMultiImage(count: imageCount, context: context);

    if (pickedFile.isNotEmpty) {
      _pickedImages.addAll(pickedFile);


      ref.read(pickedImageProvider(widget.providerId).notifier).setImages(_pickedImages);
      setState(() {});
    }
  }

  @override
  void initState() {
    ref.read(pickedImageProvider(widget.providerId)).forEach((element) {
      _pickedImages.add(element);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: const InputDecoration(
          fillColor: backGroundColor,
            filled: true,
            border: InputBorder.none,
        ),
        child: ReorderableGridView.extent(
          shrinkWrap: true,
          maxCrossAxisExtent: 120,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0,
          onReorder: (oldImage, newImage) {
            setState(() {
              final reorderedImage = _pickedImages.removeAt(oldImage);
              _pickedImages.insert(newImage, reorderedImage);
              ref.read(pickedImageProvider(widget.providerId).notifier).setImages(_pickedImages);
            });
          },
          children: [
            for (final item in _pickedImages)
              SizedBox(
                key: ValueKey(item),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          item,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        onTap: () {
                          _pickedImages.remove(item);
                          ref.read(pickedImageProvider(widget.providerId).notifier).setImages(_pickedImages);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: fontColor2),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.close,
                            color: backGroundColor,
                            size: MediaQuery.of(context).size.height * 0.019,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            if (_pickedImages.length <= (widget.length - 1))
              SizedBox(
                key: const ValueKey('AddImage'),
                child: InkWell(
                  onTap: _pickedImages.length == widget.length
                      ? null
                      : () async {
                    final isCamera = await ref
                        .read(mediaProvider)
                        .chooseSource(context);
                    if (isCamera != null) {
                      if (isCamera) {
                        chooseImage(isCamera: isCamera);
                        setState(() {});
                      } else {
                        final length =
                            widget.length - _pickedImages.length;
                        if (widget.length == 1) {
                          chooseImage(
                            isCamera: false,
                          );
                        } else {
                          chooseMultiImage(imageCount: length);
                        }
                        setState(() {});
                      }
                    }
                  },
                  child: const CustomDottedBox(
                      height: double.infinity,
                      child: Icon(
                        Icons.add,
                        color: fontColor1,
                      )),
                ),
              ),
          ],
        ),
    );
  }
}



