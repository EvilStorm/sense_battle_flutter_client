import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_make_sentence.dart';
import 'package:sense_battle/providers/provider_signin.dart';

class MakeSentenceScreen extends StatefulWidget {
  const MakeSentenceScreen({Key? key}) : super(key: key);

  @override
  _MakeSentenceScreenState createState() => _MakeSentenceScreenState();
}

class _MakeSentenceScreenState extends State<MakeSentenceScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MakeSentenceProvider(),
      builder: (context, widget) {
        return Column(
          children: [
            Text('Data: ${Provider.of<MakeSentenceProvider>(context).currentSubject}'),
            Text('userInfo : ${Provider.of<SignInProvider>(context).userInfo}'),
          ],
        );
      },
    );
    // return MultiProvider(
    //   providers: [
    //     Provider<MakeSentenceProvider>(create: (_) => MakeSentenceProvider())
    //   ],
    //   builder: (context, widget) {
    //     return Column(
    //       children: [
    //         Text('Data: ${Provider.of<MakeSentenceProvider>(context).currentSubject}'),
    //         // Text('userInfo : ${Provider.of<SignInProvider>(context).userInfo}'),
    //       ],
    //   );
    //   });

    // return MultiProvider(
    //   providers: [
    //     Provider<MakeSentenceProvider>(create: (_) => MakeSentenceProvider())
    //   ],
    //   child: Consumer<MakeSentenceProvider>(
    //     builder: (context, provider, widget) {
    //       return Text('Data: ${Provider.of<MakeSentenceProvider>(context).currentSubject}');
    //     }
    //   ),
    // );
  }
}
