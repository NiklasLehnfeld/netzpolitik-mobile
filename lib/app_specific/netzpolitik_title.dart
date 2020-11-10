import 'package:flutter/cupertino.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';

class NetzpolitikTitle extends StatelessWidget {
  const NetzpolitikTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset('assets/netzpolitik_logo.png', width: context.width / 1.7,),
    );
  }
}
