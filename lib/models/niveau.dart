
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'niveau.g.dart';

@HiveType(typeId: 0)
class Niveau extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String nom;

  @HiveField(2)
  late int couleur;

  @HiveField(3)
  late int ordre;

  Niveau({
    required this.id,
    required this.nom,
    this.couleur = 0xFFFFFFFF, // Default to white
    this.ordre = 0,
  });

  Color get color => Color(couleur);
}
