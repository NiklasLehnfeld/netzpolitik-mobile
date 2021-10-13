import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:netzpolitik_mobile/logic/rating_manager.dart';
import 'package:netzpolitik_mobile/widgets/custom_views/wp_card.dart';
import 'package:netzpolitik_mobile/extensions/context_ext.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportWidget extends StatelessWidget {
  const SupportWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        children: [
          _buildCard(11,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeadline(
                  context,
                  context.getString('support_title_developer_start'),
                  context.getString('support_title_developer'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
                  child: _buildQuote(context, 'support_developer_quote'),
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () => openDeveloperSupportPage(context),
                    child: Text(context.getString('support_developer_cta')),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: OutlinedButton(
                    onPressed: () => openStore(context),
                    child: Text(context.getString('rate_the_app')),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: OutlinedButton(
                    onPressed: () => contactMe(context),
                    child: Text(context.getString('contact_developer')),
                  ),
                ),
              ],
            ),
          ),
          _buildCard(9,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeadline(
                  context,
                  context.getString('support_title_authors_start'),
                  context.getString('support_title_authors'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildQuote(context, 'support_netzpolitik_quote'),
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () => openAuthorsSupportPage(context),
                    child: Text(context.getString('support_netzpolitik_cta')),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void openStore(BuildContext context) => context.read<RatingManager>().openStore();

  void openDeveloperSupportPage(BuildContext context) =>
    launch(context.getString('patreon_url'));


  void openAuthorsSupportPage(BuildContext context) =>
    launch(context.getString('authors_support_url'));


  void contactMe(BuildContext context) async {
    var email = Email(
      recipients: ['niklas@lehnfeld.net'],
    );

    await FlutterEmailSender.send(email);
  }

  Widget _buildCard(int flex, Widget child) => Expanded(
        flex: flex,
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: WPCard(child: SingleChildScrollView(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ))),
          ),
        ),
      );

  Widget _buildHeadline(BuildContext context, String start, String who) =>
      RichText(
        text: TextSpan(
          text: start,
          style: context.headline6
              .copyWith(color: Colors.black87, fontWeight: FontWeight.normal),
          children: <TextSpan>[
            TextSpan(text: who, style: context.headline1),
          ],
        ),
      );

  Widget _buildQuote(BuildContext context, String key) {
    var text = context.getString(key);
    var texts = text.split(RegExp('(\{|\})'));
    return RichText(
      text: TextSpan(
        style: context.quote,
        children: List.of(
          texts.asMap().entries.map(
                (entry) => TextSpan(
                    text: entry.value,
                    style: entry.key % 2 == 0
                        ? context.quote
                        : context.body1.copyWith(
                            color: context.primaryColor,
                            fontStyle: FontStyle.italic)),
              ),
        ),
      ),
    );
  }
}