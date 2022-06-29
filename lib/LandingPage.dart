import 'dart:html';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trash_out_overview_web/customWidgets.dart';
import 'package:trash_out_overview_web/privacyPolicyPage.dart';
import 'package:trash_out_overview_web/util.dart';
import 'package:url_launcher/url_launcher.dart';

void navigationPrivacyPolicy(context) => Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));

class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    bool isMonitor = (screenSize.width > minMonitorWidth);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            topSection(context, screenSize, isMonitor),
            const SizedBox(height: 90),
            featureSection(context, isMonitor, minMonitorWidth),
            const SizedBox(height: 90),
            installSection(context, isMonitor),
            const SizedBox(height: 90),
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
          height: screenSize.height * 0.9,
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
            SelectableText('収集ゴミ通知アプリ', style: Theme.of(context).textTheme.displaySmall),
            SelectableText('TrashOut', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 90)),
            const SizedBox(height: 20),
            const SelectableText('週や曜日、ゴミの種類を登録することで \n日々の収集ゴミを通知してくれます'),
            const SizedBox(height: 40),
            installBadge(),
          ],
        ),
        SizedBox(width: 100),
        Image.asset(
          'assets/images/mock-image.png',
          height: screenSize.height * 0.7,
        ),
      ],
    );
  }

  // Widget TrashOutwithIcon() {}

  Widget mobileTopContent(context, screenSize, isMonitor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText('収集ゴミ通知アプリ', style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20)),
            SelectableText('TrashOut', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 75)),
            const SizedBox(height: 20),
            const SelectableText('週や曜日、ゴミの種類を登録することで\n日々の収集ゴミを通知してくれます'),
            const SizedBox(height: 30),
            installBadge(),
          ],
        ),
        const SizedBox(height: 60),
        Image.asset(
          'assets/images/mock-image.png',
          height: screenSize.height * 0.7,
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
              'assets/images/apple-store-badge.svg',
              semanticsLabel: 'ios',
              height: 45,
            ),
            onTap: () => launchURL(iOSInstallURL),
          ),
        ),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: totalPadding),
      width: minMonitorWidth,
      child: Column(
        crossAxisAlignment: (isMonitor) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customHeadline(context, 'Features', '主な機能'),
              SizedBox(height: 30),
              const SelectableText('TrashOutは収集ゴミの管理と通知に特化しているため、機能はできるだけシンプルにしています。'),
            ],
          ),
          SizedBox(height: 30),
          (isMonitor)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    featureContent(context, isMonitor, ' 自動で通知', 'TrashOutなら、収集ゴミの詳細を登録すれば自動で通知してくれます'),
                    featureContent(context, isMonitor, ' 複雑な日程もOK', '第1・第3水曜日, 空き缶、と言った複雑なスケジュール設定も可能です'),
                    featureContent(context, isMonitor, ' ログインの手間なし', 'TrashOutは誰でも使えることを目標にしたので、煩わしい認証手続きの手間はなく、すぐに使えます'),
                  ],
                )
              : Column(
                  children: [
                    featureContent(context, isMonitor, ' 自動で通知', 'TrashOutなら、収集ゴミの詳細を登録すれば自動で通知してくれます'),
                    SizedBox(height: 30),
                    featureContent(context, isMonitor, ' 複雑な日程もOK', '第1・第3水曜日, 空き缶、と言った複雑なスケジュール設定も可能です'),
                    SizedBox(height: 30),
                    featureContent(context, isMonitor, ' ログインの手間なし', 'TrashOutは誰でも使えることを目標にしたので、煩わしい認証手続きの手間はなく、すぐに使えます'),
                  ],
                )
        ],
      ),
    );
  }

  Widget featureContent(context, isMonitor, title, description) {
    return SizedBox(
      height: (isMonitor) ? 200 : null,
      child: Card(
        elevation: commonElevation,
        child: Container(
          decoration: BoxDecoration(
            // gradient: commonGradient,
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: (isMonitor) ? 280 : double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: commonGradient,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: SelectableText(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: cardTextColor)),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                child: SelectableText(
                  description,
                  style: TextStyle(color: Colors.blueGrey),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget installSection(context, isMonitor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: totalPadding),
      width: minMonitorWidth,
      child: (isMonitor)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customHeadline(context, 'Install', 'インストール'),
                    const SizedBox(height: 20),
                    Text('インストールはこちらから。'),
                  ],
                ),
                SizedBox(width: 60),
                Expanded(
                  child: Column(
                    // : Column(
                    children: [
                      SizedBox(height: 80),
                      installButton(context, 'iOS', isMonitor),
                      const SizedBox(height: 20),
                      installButton(context, 'Android', isMonitor),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customHeadline(context, 'Install', 'インストール'),
                SizedBox(height: 20),
                Text('iOS、Andoroidどちらも対応しています。こちらからインストールください。'),
                SizedBox(height: 30),
                SizedBox(width: 60),
                Column(
                  // : Column(
                  children: [
                    installButton(context, 'iOS', isMonitor),
                    const SizedBox(height: 20),
                    installButton(context, 'Android', isMonitor),
                  ],
                ),
              ],
            ),
    );
  }

  Widget installButton(context, platform, isMonitor) {
    return MaterialButton(
      elevation: commonElevation,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () => launchURL((platform == 'iOS') ? iOSInstallURL : androidInstallURL),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: commonElevation,
        child: Ink(
          decoration: BoxDecoration(
            gradient: commonGradient,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        (platform == 'iOS') ? Icons.apple : Icons.android,
                        color: Colors.blueGrey[50],
                      ),
                    ),
                    TextSpan(
                      text: (platform == 'iOS') ? ' Apple Store' : '  Google Play Store',
                      style: Theme.of(context).textTheme.button!.copyWith(fontSize: 20, color: Colors.blueGrey[50]),
                    )
                  ],
                ),
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
      padding: EdgeInsets.symmetric(horizontal: totalPadding),
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
    return SelectableText(text, style: TextStyle(fontSize: 10, color: Colors.blueGrey[50]));
  }

  Widget customHeadline(context, titleEn, titleJp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SelectableText(titleEn, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 40, fontWeight: FontWeight.w600)),
            SizedBox(width: 8),
            SelectableText(titleJp, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(
          width: 60,
          child: CoolDivider(
            gradient: commonGradient,
            thickness: 4,
          ),
        ),
      ],
    );
  }
}
