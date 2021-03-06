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

  Widget monitorTopContent(context, screenSize, isMonitor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText('???????????????????????????', style: Theme.of(context).textTheme.displaySmall),
            SelectableText('TrashOut', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 90)),
            const SizedBox(height: 20),
            const SelectableText('?????????????????????????????????????????????????????? \n????????????????????????????????????????????????'),
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
            SelectableText('???????????????????????????', style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20)),
            SelectableText('TrashOut', style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 75)),
            const SizedBox(height: 20),
            const SelectableText('??????????????????????????????????????????????????????\n????????????????????????????????????????????????'),
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
              customHeadline(context, 'Features', '????????????'),
              SizedBox(height: 30),
              const SelectableText('TrashOut????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'),
            ],
          ),
          SizedBox(height: 30),
          (isMonitor)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    featureContent(context, isMonitor, ' ???????????????', 'TrashOut?????????????????????????????????????????????????????????????????????????????????'),
                    featureContent(context, isMonitor, ' ??????????????????OK', '???1??????3?????????, ????????????????????????????????????????????????????????????????????????'),
                    featureContent(context, isMonitor, ' ???????????????????????????', 'TrashOut???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'),
                  ],
                )
              : Column(
                  children: [
                    featureContent(context, isMonitor, ' ???????????????', 'TrashOut?????????????????????????????????????????????????????????????????????????????????'),
                    SizedBox(height: 30),
                    featureContent(context, isMonitor, ' ??????????????????OK', '???1??????3?????????, ????????????????????????????????????????????????????????????????????????'),
                    SizedBox(height: 30),
                    featureContent(context, isMonitor, ' ???????????????????????????', 'TrashOut???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????'),
                  ],
                )
        ],
      ),
    );
  }

  Widget featureContent(context, isMonitor, title, description) {
    return SizedBox(
      height: (isMonitor) ? 145 : null,
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: commonGradient,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: SelectableText(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: cardTextColor)),
              ),
              const SizedBox(height: 10),
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
                    customHeadline(context, 'Install', '??????????????????'),
                    const SizedBox(height: 20),
                    Text('???????????????????????????????????????'),
                  ],
                ),
                SizedBox(width: 80),
                Expanded(
                  child: Column(
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
                customHeadline(context, 'Install', '??????????????????'),
                SizedBox(height: 20),
                Text('iOS???Andoroid????????????????????????????????????????????????????????????????????????????????????'),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: bottomText('??????????????????????????????'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                ),
              ),
              SizedBox(width: 7),
              InkWell(
                child: bottomText('??????????????????'),
                onTap: () => launchURL(contactUrl),
              ),
              SizedBox(width: 7),
              InkWell(
                child: bottomText('Github'),
                onTap: () => launchURL('https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
              ),
            ],
          ),
          SizedBox(height: 5),
          bottomText('Copyright @ 2022 Daisuke Osanai'),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget bottomText(text) {
    return Text(text, style: TextStyle(fontSize: 10, color: Colors.blueGrey[50]));
  }
}
