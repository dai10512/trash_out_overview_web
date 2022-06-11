import 'package:flutter/material.dart';

import 'package:trash_out_overview_web/privacyPolicy%20.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const contactUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfK3Atlu_Gljy2K4VuSRbNQNXN8oHR3AdywsQjqRYFs8rKOjg/viewform';

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
                  buildOverview(context),
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

  Widget buildOverview(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('images/logo.png'),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)), // 調節
          child: Image.asset(
            'images/logo.png',
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
              Text(
                'ごみ収集日管理アプリ',
                style: (MediaQuery.of(context).size.width > 600) ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'TrashOut',
                style: (MediaQuery.of(context).size.width > 600) ? Theme.of(context).textTheme.displayLarge : Theme.of(context).textTheme.displaySmall,
              ),
              const Divider(),
              const Text('「第2・第4水曜日」といった複雑なスケジューリングで、当日及び前日に該当するゴミの種類を通知で案内することができます'),
            ],
          ),
        )
      ],
    );
  }

  Widget buildFirstMessage(context) {
    return Column(
      children: [
        Text(
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
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text('問い合わせフォームに移動する'),
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
    return Text(
      title,
      style: (MediaQuery.of(context).size.width > 600) ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget buildContent(context, content) {
    return Text(
      content,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
