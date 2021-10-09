import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:netzpolitik_mobile/persistence/app_settings.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/height.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/width.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_bottom_sheet.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_link_card.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class ImprintBottomSheet extends StatefulWidget {
  const ImprintBottomSheet();

  @override
  _ImprintBottomSheetState createState() => _ImprintBottomSheetState();
}

class _ImprintBottomSheetState extends State<ImprintBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var cards = [
      WPLinkCard(
        FontAwesomeIcons.globe,
        context.getString('privacy_statement'),
        context.getString('privacy_statement_url'),
        Colors.grey[600]!,
      ),
      WPLinkCard(
        FontAwesomeIcons.globe,
        context.getString('support_website'),
        context.getString('support_website_url'),
        Colors.grey[600]!,
      ),
    ];

    final colCount = context.isWide ? 2 : 1;

    var bottomContainer = GridView.count(
      crossAxisCount: colCount,
      childAspectRatio: 2.5 * context.density * colCount,
      shrinkWrap: true,
      children: cards,
    );

    return WPBottomSheet(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingsSection(context),
            Height(15),
            _buildAboutAppSection(context),
            Height(15),
            _buildImprintSection(context),
            Height(15),
            bottomContainer,
            Height(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildVersionNumber(context),
                Width(18)
              ],
            ),
          ],
        ));
  }

  Widget _buildVersionNumber(BuildContext context) =>
      Align(
        alignment: Alignment.centerRight,
        child: FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            var text = '';
            if (snapshot.hasData) {
              text = (snapshot.data as PackageInfo).version;
            }

            return Text('Version: $text');
          },
        ),
      );

  Widget _buildAboutAppSection(BuildContext context) =>
      RichText(
        text: TextSpan(
          style: context.headline1,
          children: <TextSpan>[
            TextSpan(text: context.getString('about_the_app_headline') + '\n'),
            TextSpan(
                text: context.getString('about_the_app_content'),
                style: context.body2),
          ],
        ),
      );

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.getString('settings_headline'),
          style: context.headline1,
        ),
        _buildFontsizeWidget(context),
      ],
    );
  }

  Widget _buildFontsizeWidget(BuildContext context) {
    var appSettings = context.watch<AppSettings>();
    var fontSize = appSettings.fontSize;
    return Row(
      children: [
        Text(context.getString('fontsize_label'),
            style: context.body1.copyWith(fontWeight: FontWeight.normal)),
        Expanded(
          child: Slider(
            value: fontSize.toDouble(),
            divisions: (MAX_FONT_SIZE - MIN_FONT_SIZE).toInt(),
            max: MAX_FONT_SIZE,
            min: MIN_FONT_SIZE,
            onChanged: (value) =>
                setState(() => appSettings.fontSize = value.toInt()),
            label: fontSize.toString(),
          ),
        ),
      ],
    );
  }

  Widget _buildImprintSection(BuildContext context) =>
      RichText(
        text: TextSpan(
          style: context.headline1,
          children: <TextSpan>[
            TextSpan(text: context.getString('imprint_headline') + '\n'),
            TextSpan(
                text: context.getString('imprint_content'),
                style: context.body2),
          ],
        ),
      );
}
