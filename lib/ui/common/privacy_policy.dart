import 'package:flutter/material.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

import '../../models/PageModals/success_error_args.dart';
import '../../utils/routes/routes.dart';


class Privacy_Policy extends StatefulWidget {
  const Privacy_Policy({Key? key}) : super(key: key);

  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('It is a long established fact that a reader will be distracted by the readable content of a '
                    'page when looking at its layout. The point of using Lorem Ipsum is that it '
                    'has a more-or-less normal distribution of letters, as opposed to using', style: TextStyle(color: Colors.grey),
                    ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Text('1.Privacy',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ],
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
                    Text('2.Policy',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                    Text('3.Information collection',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                    Icon( Icons.arrow_circle_right_outlined, color: Colors.orangeAccent),
                  SizedBox(width: 5),

                  Text('Plusieurs variations de Lorem Ipsum', style: TextStyle(color: Colors.grey))

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon( Icons.arrow_circle_right_outlined, color: Colors.orangeAccent),
                    SizedBox(width: 5),

                    Text('ots aléatoires qui ne ressemblent pas',style: TextStyle(color: Colors.grey))

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon( Icons.arrow_circle_right_outlined, color: Colors.orangeAccent),
                    SizedBox(width: 5),

                    Text('ul vrai générateur de Lorem Ipsum. Iil ut',style: TextStyle(color: Colors.grey))

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon( Icons.arrow_circle_right_outlined, color: Colors.orangeAccent),
                    SizedBox(width: 5),

                    Text('ncontestable du Lorem Ipsum. Il provient',style: TextStyle(color: Colors.grey))

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
                      Routes.navigateToScreen(context, Routes.terms_conditions);
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

