import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trash_out_overview_web/privacyPolicyPage.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    double minMonitorWidth = 900;
    // double minMobileWidth = 600;
    bool isMonitor = (screenSize.width > minMonitorWidth);
    // bool isMobile() => (screenSize.width > minMobileWidth);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            topSection(context, screenSize, isMonitor),
            SizedBox(height: 50),
            featureSection(context, isMonitor, minMonitorWidth),
            SizedBox(height: 50),
            TextButton(
              onPressed: () => (Navigator.push(
                  context,
                  MaterialPageRoute(
                      // （2） 実際に表示するページ(ウィジェット)を指定する
                      builder: (context) => PrivacyPolicyPage()))),
              child: Text('プライバシーポリシー'),
            ),
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

  void launchURL(url) async {
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
            SizedBox(height: 20),
            Text('TrashOutなら、週や曜日、ゴミの種類を登録することで \n日々の収集ゴミを通知してくれます'),
            SizedBox(height: 40),
            installBadge(),
          ],
        ),
        SizedBox(width: (isMonitor) ? 100 : 0),
        Image.asset(
          'assets/images/design-1.png',
          // fit: BoxFit.cover,
          height: (isMonitor) ? screenSize.height * 0.65 : screenSize.height * 0.9,
          // width: screenSize.width,
        ),
      ],
    );
  }

  Widget mobileTopContent(context, screenSize, isMonitor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('収集ゴミ通知アプリ', style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20)),
              Text('TrashOut', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 75)),
              SizedBox(height: 20),
              // Text(' \naaaaaaaaaaaaaaaaaaaaaaaa'),
              SizedBox(height: 30),
              installBadge(),
            ],
          ),
        ),
        SizedBox(height: 60),
        Image.asset(
          'assets/images/design-1.png',
          // fit: BoxFit.cover,
          height: (isMonitor) ? screenSize.height * 0.7 : screenSize.height * 0.9,
          // width: screenSize.width,
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
            child: Image.asset('assets/images/google-play-badge.png', height: 45),
            onTap: () {
              launchURL('https://play.google.com/store/apps/details?id=com.me.trash_out');
            },
          ),
        ),
      ],
    );
  }

  featureSection(context, isMonitor, minMonitorWidth) {
    return Column(
      children: [
        SizedBox(height: 50),
        Text('主な機能', style: Theme.of(context).textTheme.displaySmall),
        SizedBox(height: 50),
        Container(
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
      padding: EdgeInsets.all(5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 5),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}
