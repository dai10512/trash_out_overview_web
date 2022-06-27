import 'dart:html';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trash_out_overview_web/privacyPolicyPage.dart';
import 'package:trash_out_overview_web/util.dart';
import 'package:url_launcher/url_launcher.dart';

void navigationPrivacyPolicy(context) => Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));

class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    double minMonitorWidth = 900;
    bool isMonitor = (screenSize.width > minMonitorWidth);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            topSection(context, screenSize, isMonitor),
            const SizedBox(height: 50),
            featureSection(context, isMonitor, minMonitorWidth),
            const SizedBox(height: 50),
            // othersSection(context, isMonitor),
            installSection(context, isMonitor),
            const SizedBox(height: 50),
            bottomSection(context, isMonitor),
          ],
        ),
      ),
    );
  }

  Widget topSection(context, screenSize, isMonitor) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/sky-top-image.png',
          fit: BoxFit.cover,
          height: (isMonitor) ? screenSize.height * 0.9 : screenSize.height * 0.9,
          width: screenSize.width,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: SizedBox(
            width: screenSize.width,
            child: (isMonitor) ? monitorTopContent(context, screenSize, isMonitor) : mobileTopContent(context, screenSize, isMonitor),
          ),
        ),
      ],
    );
  }

  Future<void> launchURL(url) async {
    // if (await launchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  Widget monitorTopContent(context, screenSize, isMonitor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('収集ゴミ通知アプリ', style: Theme.of(context).textTheme.displaySmall),
            Text('TrashOut', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 90)),
            const SizedBox(height: 20),
            const Text('週や曜日、ゴミの種類を登録することで \n日々の収集ゴミを通知してくれます'),
            const SizedBox(height: 40),
            installBadge(),
          ],
        ),
        SizedBox(width: (isMonitor) ? 100 : 0),
        Image.asset(
          'assets/images/design-1.png',
          height: (isMonitor) ? screenSize.height * 0.65 : screenSize.height * 0.9,
        ),
      ],
    );
  }

  Widget mobileTopContent(context, screenSize, isMonitor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('収集ゴミ通知アプリ', style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20)),
            Text('TrashOut', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 75)),
            const SizedBox(height: 20),
            const Text('週や曜日、ゴミの種類を登録することで\n日々の収集ゴミを通知してくれます'),
            const SizedBox(height: 30),
            installBadge(),
          ],
        ),
        const SizedBox(height: 60),
        Image.asset(
          'assets/images/design-1.png',
          height: (isMonitor) ? screenSize.height * 0.7 : screenSize.height * 0.9,
        ),
      ],
    );
  }

  Widget installBadge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: SvgPicture.asset(
              'assets/images/black.svg',
              semanticsLabel: 'ios',
              height: 45,
            ),
            onTap: () => launchURL(iOSInstallURL),
          ),
        ),
        // Expanded(child: Container()),
        const SizedBox(width: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Image.asset('assets/images/google-play-badge.png', height: 45),
            onTap: () => launchURL(androidInstallURL),
          ),
        ),
      ],
    );
  }

  featureSection(context, isMonitor, minMonitorWidth) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Container(
          child: Column(
            children: [
              Text('主な機能', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(width: 40, child: Divider()),
            ],
          ),
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: (isMonitor) ? minMonitorWidth : null,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              featureContent(context, isMonitor, ' 自動で通知', 'TrashOutなら、収集ゴミの詳細を登録すれば自動で通知してくれます'),
              // (isMonitor) ? SizedBox(width: 10) : SizedBox(height: 40),
              featureContent(context, isMonitor, ' 複雑な日程もOK', '第1・第3水曜日, 空き缶、と言った複雑なスケジュール設定も可能です'),
              // (isMonitor) ? SizedBox(width: 10) : SizedBox(height: 40),
              featureContent(context, isMonitor, ' ログインの手間なし', 'TrashOutは誰でも使えることを目標にしたので、煩わしい認証手続きの手間はなく、すぐに使えます'),
            ],
          ),
        )
      ],
    );
  }

  Widget featureContent(context, isMonitor, title, description) {
    return Container(
      width: (isMonitor) ? 290 : 300,
      height: 175,
      padding: const EdgeInsets.all(0.0),
      child: Card(
        elevation: commonElevation,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }

  Widget installSection(context, isMonitor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: totalPadding),
      child: (isMonitor)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                installButton(context, 'iOS', isMonitor),
                const SizedBox(width: 20),
                installButton(context, 'Android', isMonitor),
              ],
            )
          : Column(
              children: [
                installButton(context, 'iOS', isMonitor),
                const SizedBox(height: 20),
                installButton(context, 'Android', isMonitor),
              ],
            ),
    );
  }

  Widget installButton(context, platform, isMonitor) {
    return MaterialButton(
      onPressed: () => launchURL((platform == 'iOS') ? iOSInstallURL : androidInstallURL),
      child: Ink(
        width: (isMonitor) ? 400 : double.infinity,
        decoration: BoxDecoration(
          gradient: commonGradient,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                      child: Icon(
                    (platform == 'iOS') ? Icons.apple : Icons.android,
                    color: Colors.white,
                  )),
                  TextSpan(
                      text: (platform == 'iOS') ? ' Apple Store' : '  Google Play Store',
                      style: Theme.of(context).textTheme.button!.copyWith(fontSize: 20, color: Colors.white))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSection(context, isMonitor) {
    return Container(
      decoration: BoxDecoration(gradient: commonGradient),
      padding: const EdgeInsets.symmetric(horizontal: totalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          bottomText('Copyright @ 2022 Daisuke Osanai'),
          TextButton(
            child: bottomText('プライバシーポリシー'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
            ),
          ),
          TextButton(
            child: bottomText('お問い合わせ'),
            onPressed: () => launchURL(contactUrl),
          ),
        ],
      ),
    );
  }

  Widget bottomText(text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 10, color: Colors.white),
    );
  }
}
