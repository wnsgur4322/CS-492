import 'package:flutter/material.dart';

BoxDecoration photoBox(ImageProvider imageProvider) {
  return BoxDecoration(
    image: DecorationImage(
      image: imageProvider,
      fit: BoxFit.cover
    )
  );
}
