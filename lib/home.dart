import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:trash_out_overview_web/privacyPolicy%20.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: Column(
              children: [
                buildFirstMessage(context),
                buildPrivacyPolicy(),
              ],
            ),
          ),
        ),
      ),
    );
  }
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

Widget buildTitle(context, title) {
  return Text(title, style: Theme.of(context).textTheme.headlineMedium);
}

Widget buildContent(context, content) {
  return Text(content, style: Theme.of(context).textTheme.bodyLarge);
}
