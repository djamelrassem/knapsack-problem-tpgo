import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int poids = 0;
  int valeur = 0;
  int poidsSac = 0;
  List<Objet> objets = [];
  List<Widget> objetsAffichage = [];
  List<Widget> choisiAffichage = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff0f2027),
              Color(0xff203a43),
              Color(0xff2c5364),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "TP1 : Probléme du Sac à dos",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Poids du sac à dos",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CupertinoTextField(
                    onChanged: (p) {
                      try {
                        poidsSac = int.parse(p);
                      } catch (e) {}
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Poids",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CupertinoTextField(
                    onChanged: (p) {
                      try {
                        poids = int.parse(p);
                      } catch (e) {}
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Valeur",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CupertinoTextField(
                    onChanged: (value) {
                      try {
                        valeur = int.parse(value);
                      } catch (e) {}
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        try {
                          Objet objet = Objet(value: valeur, poids: poids);
                          objets.add(objet);
                          int maxPoids = Objet.getMax(objets).poids;
                          setState(
                            () {
                              objetsAffichage = List.generate(
                                objets.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius:
                                            (objets[index].poids / maxPoids) *
                                                36,
                                        backgroundColor: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        "v = " + objets[index].value.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "p = " + objets[index].poids.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } catch (e) {}
                      },
                      child: Text(
                        "Ajouter",
                        style: TextStyle(
                          color: Color(0xff2c5364),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        List<Objet> list = knapsackSolver(objets, poidsSac);
                        int maxPoids = Objet.getMax(objets).poids;
                        setState(
                          () {
                            choisiAffichage = List.generate(
                              list.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius:
                                          (list[index].poids / maxPoids) * 36,
                                      backgroundColor: Colors.red,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "v = " + list[index].value.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "p = " + list[index].poids.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )..add(
                                Center(
                                  child: Text(
                                    " = ${res.toString()}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                ),
                              );
                          },
                        );
                      },
                      child: Text(
                        "Calculer",
                        style: TextStyle(
                          color: Color(0xff2c5364),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, bottom: 12),
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: objetsAffichage,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, bottom: 12),
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: choisiAffichage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int res = 0;

class Objet {
  int value;
  int poids;
  Objet({
    required this.value,
    required this.poids,
  });

  static Objet getMax(List<Objet> objets) {
    Objet maxObjet = Objet(value: 0, poids: 0);
    objets.forEach((element) {
      if (element.poids > maxObjet.poids) {
        maxObjet = element;
      }
    });
    return maxObjet;
  }

  Objet copyWith({
    int? value,
    int? poids,
  }) {
    return Objet(
      value: value ?? this.value,
      poids: poids ?? this.poids,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'poids': poids,
    };
  }

  factory Objet.fromMap(Map<String, dynamic> map) {
    return Objet(
      value: map['value'],
      poids: map['poids'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Objet.fromJson(String source) => Objet.fromMap(json.decode(source));

  @override
  String toString() => 'Objet(value: $value, poids: $poids)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Objet && other.value == value && other.poids == poids;
  }

  @override
  int get hashCode => value.hashCode ^ poids.hashCode;
}

List<Objet> knapsackSolver(List<Objet> objets, int poidsSac) {
  List<List<int>> t = List.generate(
      objets.length + 1, (index) => List.generate(poidsSac + 1, (index) => 0));
  List<Objet> choisi = [];
  for (int i = 1; i <= objets.length; i++) {
    for (int c = 0; c <= poidsSac; c++) {
      if (c >= objets[i - 1].poids) {
        t[i][c] = max(t[i - 1][c],
            t[i - 1][c - objets[i - 1].poids] + objets[i - 1].value);
      } else {
        t[i][c] = t[i - 1][c];
      }
    }
  }
  int result = t[objets.length][poidsSac];
  res = result;
  int w = poidsSac;
  for (int i = objets.length; i > 0 && result > 0; i--) {
    if (result != t[i - 1][w]) {
      result = result - objets[i - 1].value;
      w = w - objets[i - 1].poids;
      choisi.add(objets[i - 1]);
    }
  }
  return choisi;
}
