import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

import '../../../core/shared_widgets/shared_text_form_field.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({super.key});
TextEditingController demo=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text(
                 'المواقف بين ايديك',
                 style: GoogleFonts.amiri(
                   fontSize: 30,
                   fontWeight: FontWeight.w400,
                   color: Colors.blue,
                 ),
               ),
               SharedTextFormField(controller:demo , hintText: 'demo', validator: (String) {  }, suffixIcon: Icon(Icons.add),)
             ],
           ),
         ),
        ),
      ),
    );
  }
}
