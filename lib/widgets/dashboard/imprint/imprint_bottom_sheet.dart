import 'package:flutter/cupertino.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_bottom_sheet.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';

class ImprintBottomSheet extends StatelessWidget {

  const ImprintBottomSheet();

  @override
  Widget build(BuildContext context) {

    return WPBottomSheet(
        child: RichText(
          text: TextSpan(
            style: context.headline1,
            children: <TextSpan>[
              TextSpan(text: context.getString('about_the_app_headline') + '\n'),
              TextSpan(text: context.getString('about_the_app_content') , style: context.body1),

              LinkTextSpan(
                  text: context.getString('github_link') + '\n\n',
                  url: context.getString('github_link'),
                  onLinkTap: (url) => launch(url),
                  style: context.body1.copyWith(color: context.primaryColor, decoration: TextDecoration.underline,),
              ),

              TextSpan(text: context.getString('about_the_dev_headline') + '\n'),
              TextSpan(text: context.getString('about_the_dev_content') + '\n', style: context.body1),
              LinkTextSpan(
                text: context.getString('linkedin_url') + '\n\n',
                url: context.getString('linkedin_url'),
                onLinkTap: (url) => launch(url),
                style: context.body1.copyWith(color: context.primaryColor, decoration: TextDecoration.underline,),
              ),

              TextSpan(text: context.getString('imprint_headline') + '\n'),
              TextSpan(text: context.getString('imprint_content') + '\n\n', style: context.body1),
            ],
          ),
        )
    );
  }
}

