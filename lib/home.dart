import 'package:flutter/material.dart';
import 'package:trash_out_overview_web/privacyPolicy%20.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    const contactUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfK3Atlu_Gljy2K4VuSRbNQNXN8oHR3AdywsQjqRYFs8rKOjg/viewform';
    final bool isLargeMonitor = (MediaQuery.of(context).size.width > 900);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildOverview(context, isLargeMonitor),
                  Visibility(
                    visible: (!isLargeMonitor),
                    child: spacer(),
                  ),
                  buildStoreBannerMobile(context, isLargeMonitor),
                  spacer(),
                  Text('プライバシーポリシー', style: Theme.of(context).textTheme.titleLarge),
                  spacer(),
                  buildFirstMessage(context),
                  buildPrivacyPolicy(),
                  spacer(),
                  buildContactForm(context, contactUrl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStoreBannerMobile(context, isLargeMonitor) {
    return Visibility(
      visible: (!isLargeMonitor),
      child: Center(
        // width: 800,
        child: Wrap(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/images/black.svg',
                  semanticsLabel: 'ios',
                  height: 55,
                ),
                onTap: () {
                  launchURL('https://apple.co/3zMRxsu');
                },
              ),
            ),
            // Expanded(child: Container()),
            SizedBox(width: (MediaQuery.of(context).size.width > 600) ? 40 : 20),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: Image.asset(
                  'assets/images/google-play-badge.png',
                  height: 55,
                ),
                onTap: () {
                  launchURL('https://play.google.com/store/apps/details?id=com.me.trash_out');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStoreBannerLargeMonitor(context, isLargeMonitor) {
    return SizedBox(
      height: 165,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Visibility(
          visible: (isLargeMonitor),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: SvgPicture.asset(
                      'assets/images/black.svg',
                      semanticsLabel: 'ios',
                      height: 45,
                    ),
                    onTap: () {
                      launchURL('https://apple.co/3zMRxsu');
                    },
                  ),
                ),
                // Expanded(child: Container()),
                const SizedBox(width: 10),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Image.asset(
                      'assets/images/google-play-badge.png',
                      height: 45,
                    ),
                    onTap: () {
                      print('tapped');
                      launchURL('https://play.google.com/store/apps/details?id=com.me.trash_out');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchURL(url) async {
    // if (await launchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  Widget buildOverview(context, isLargeMonitor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)), // 調節
          child: Image.asset(
            'assets/images/logo.png',
            width: (MediaQuery.of(context).size.width > 600) ? 140 : 120,
            height: (MediaQuery.of(context).size.width > 600) ? 140 : 120,
            // fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                '収集ゴミ通知アプリ',
                style: (MediaQuery.of(context).size.width > 600) ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.bodyMedium,
              ),
              SelectableText(
                'TrashOut',
                style: (MediaQuery.of(context).size.width > 600) ? Theme.of(context).textTheme.displayLarge : Theme.of(context).textTheme.displaySmall,
              ),
              const Divider(),
              const SelectableText('週や曜日、収集ゴミの種類を登録することで、その日の収集ゴミを通知することができます'),
            ],
          ),
        ),
        buildStoreBannerLargeMonitor(context, isLargeMonitor),
      ],
    );
  }

  Widget buildFirstMessage(context) {
    return Column(
      children: [
        SelectableText(
          firstMessage,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        spacer(),
      ],
    );
  }

  Widget spacer() {
    return const SizedBox(height: 20);
  }

  Widget buildPrivacyPolicy() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: headlineList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return policyHeadline(context, headlineList[index], contentList[index]);
      },
    );
  }

  Widget policyHeadline(context, title, content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(context, title),
        const Divider(),
        buildContent(context, content),
        spacer(),
      ],
    );
  }

  Widget buildContactForm(context, url) {
    return ElevatedButton(
      onPressed: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl((Uri.parse(url)));
        } else {
          throw 'Unable to launch url $url';
        }
      },
      child: const SizedBox(
        height: 50,
        width: double.infinity,
        child: Center(
          child: SelectableText('お問い合わせフォームに移動する'),
        ),
      ),
    );
  }

  Future buildLaunchUrl(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl((Uri.parse(url)));
    } else {
      throw 'Unable to launch url $url';
    }
  }

  Widget buildTitle(context, title) {
    return SelectableText(
      title,
      style: (MediaQuery.of(context).size.width > 600) ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget buildContent(context, content) {
    return SelectableText(
      content,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
