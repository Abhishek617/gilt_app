import 'package:flutter/material.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

import '../../utils/routes/routes.dart';

class Terms_Condition extends StatefulWidget {
  const Terms_Condition({Key? key}) : super(key: key);

  @override
  State<Terms_Condition> createState() => _Terms_ConditionState();
}

class _Terms_ConditionState extends State<Terms_Condition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms Condition'),
      ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Please Read the Terms and Conditions carefully!', style: TextStyle(color: Colors.black,fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height:10 ,
                  ),
                  Text('On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en '
                      'page elle-même. Lavantage du Lorem Ipsum sur un texte générique comme Du texte. Du texte. Du texte.est quil possède une distribution de lettres plus ou '
                      'moins normale, et en tout cas comparable avec celle du français standard. De nombreuses suites logicielles de mise en page ou éditeurs de sites Web ont'
                      ' faitencore quà leur phase deconstruction. Plusieurs versions sont apparueavec le temps, parfois par accident, souvent', style: TextStyle(color: Colors.grey)),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('2.Accepting this terms',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Plusieurs variations de Lorem Ipsum peuvent être trouvées ici ou là, mais la majeure partieentre elles a été altérée par laddition dhumour ou de mots aléatoires qui ne '
                      'ressemblent pas unseconde à du texte standard. Si vous voulez utiliser un passage du Lorem Ipsum, vous devez être sûr quil ny a rien'
                      'dembarrassant caché dans le texte. Tous les générateurs de Lorem Ipsum sur Internet tendent à reproduire le même extrait sans fince qui fait '
                    , style: TextStyle(color: Colors.grey),),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('3.Strictly follow these',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('On sait depuis longtemps que travailler avec du texte lisible et contenant du sens est source de distractions, et empêche de se concentrer sur la mise en '
                      'page elle-même. Lavantage du Lorem Ipsum sur un texte générique comme Du texte. Du texte. Du texte.est quil possède une distribution de lettres plus ou '
                      'moins normale, et en tout cas comparable avec celle du français standard. De nombreuses suites logicielles de mise en page ou éditeurs de sites Web ont'
                      ' faitencore quà leur phase deconstruction. Plusieurs versions sont apparueavec '
                      'le temps, parfois par accident, souvent', style: TextStyle(color: Colors.grey),),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text('3.Strictly follow these',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('age elle-même. Lavantage du Lorem Ipsum sur un texte générique comme Du texte. Du texte.'
                      ' Du texte.est quil possède une distribution de lettres plus ou '
                      'moins normale, et en tout cas comparable avec celle du français standard',style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('4.Strictly follow these',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('age elle-même. Lavantage du Lorem Ipsum sur un texte générique comme Du texte. Du texte.'
                      ' Du texte.est quil possède une distribution de lettres plus ou '
                      'moins normale, et en tout cas comparable avec celle du français standard',style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text('5.Strictly follow these',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('age elle-même. Lavantage du Lorem Ipsum sur un texte générique comme Du texte. Du texte.'
                      ' Du texte.est quil possède une distribution de lettres plus ou '
                      'moins normale, et en tout cas comparable avec celle du français standard',style: TextStyle(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: ElevatedButtonWidget(
                      buttonText: 'Accept',
                      buttonColor: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Routes.navigateToScreen(context, Routes.faqs);
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
