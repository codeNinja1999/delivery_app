// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../../core/app_core.dart';
// import '../../../../resources/resources.dart';
// import '../transaction_details.dart';

// class ImageDisplay extends StatefulWidget {
//   const ImageDisplay({super.key});

//   @override
//   State<ImageDisplay> createState() => _ImageDisplayState();
// }

// class _ImageDisplayState extends State<ImageDisplay> {
//   late ThemeData theme;
//   File? imgFile;
//   final imgPicker = ImagePicker();
//   void openCamera() async {
//     var imgCamera = await imgPicker.pickImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640, imageQuality: 50);
//     if (imgCamera != null) {
//       setState(() {
//         imgFile = File(imgCamera.path);
//         context.read<TransactionDetailBloc>().add(ReceiptImageChanged(imgFile));
//       });
//       // ignore: use_build_context_synchronously
//     }
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pop();
//   }

//   void openGallery() async {
//     var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640, imageQuality: 50);

//     if (imgGallery != null) {
//       setState(() {
//         imgFile = File(imgGallery.path);
//         context.read<TransactionDetailBloc>().add(ReceiptImageChanged(imgFile));
//       });
//       // ignore: use_build_context_synchronously
//     }
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     theme = Theme.of(context);
//     return BlocProvider(
//       create: (context) => sl<TransactionDetailBloc>(),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: AppSize.inset, bottom: AppSize.inset),
//             child: Text(
//               "REQUIRED: Use your mobile phone to take a clear photo of your receipt.",
//               style: theme.textTheme.titleSmall,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Row(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.all(Radius.circular(5)),
//                 child: displayImage(),
//               ),
//               const SizedBox(width: 5.0),
//               ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryPinkDark, // Background color
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _bottomSheet(context);
//                     });
//                   },
//                   icon: const Icon(Icons.camera_alt),
//                   label: const Text("RECEIPT")),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget displayImage() {
//     if (imgFile == null) {
//       return BlocProvider(
//         create: (context) => sl<TransactionDetailBloc>(),
//         child: Image.asset(
//           Images.gallery,
//           fit: BoxFit.fill,
//           height: 150,
//           width: 150,
//         ),
//       );
//     } else {
//       return Image.file(imgFile!, width: 160, height: 200);
//     }
//   }

//   _bottomSheet(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext c) {
//           return Wrap(
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
//                     color: Colors.white,
//                     //color: const Color(0xFF000000),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       child: Center(
//                         child: TextButton(
//                           style: TextButton.styleFrom(backgroundColor: Colors.white),
//                           onPressed: () {
//                             openCamera();
//                           },
//                           child: const Text(
//                             "Image From Camera",
//                             style: TextStyle(color: AppColors.ppink),
//                             // style: GoogleFonts.ptSans(
//                             //     fontSize: 18.0,
//                             //     fontWeight: FontWeight.normal,
//                             //     color: const Color(0xFF0E76BC)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
//                     color: Colors.white,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       child: Center(
//                         child: TextButton(
//                           style: TextButton.styleFrom(backgroundColor: Colors.white),
//                           onPressed: () {
//                             openGallery();
//                           },
//                           child: const Text(
//                             "Image From Gallery",
//                             style: TextStyle(color: AppColors.ppink),
//                             // style: TextStyle(
//                             //     fontSize: 18.0,
//                             //     fontWeight: FontWeight.normal,
//                             //     color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
//                     color: Colors.white,
//                     // color: const Color(0xFF000000),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       child: Center(
//                         child: TextButton(
//                           style: TextButton.styleFrom(backgroundColor: Colors.white),
//                           child: const Text(
//                             "Cancel",
//                             style: TextStyle(color: AppColors.ppink),
//                             // style: GoogleFonts.ptSans(
//                             //     fontSize: 18.0,
//                             //     fontWeight: FontWeight.normal,
//                             //     color: const Color(0xFF0E76BC)),
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         });
//   }
// }
