import 'package:flutter/material.dart';
import 'package:sense_battle/constants/constants.dart';
import 'package:sense_battle/screens/sign_in/sign_in_with_email.dart';

class SenseBattleSignInButton extends StatelessWidget {
  
  const SenseBattleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){
          showModalBottomSheet(
            context: context, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.sapceGap),
            ),
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            builder: (context) => SizedBox(
              height: 320.0,
              child: Padding(
                padding: const EdgeInsets.all(Constants.sapceGap),
                child: SignInWithEmail(),
              )
            )
          );
        },
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(40))
          ),
          child: Center(
            child: Text(
              'SenseBattle 로그인',
              style: Theme.of(context).textTheme.subtitle2!.apply(color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
        ),
      ),
    );
  }
}