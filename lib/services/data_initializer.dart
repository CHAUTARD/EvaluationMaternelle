import 'package:flutter/material.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/services/hive_service.dart';
import 'package:uuid/uuid.dart';

class DataInitializer {
  static Future<void> initializeData() async {
    final niveauxBox = HiveService.niveaux;
    if (niveauxBox.isEmpty) {
      final uuid = Uuid();

      // Add default levels
      final niveauPetit = Niveau(
        id: uuid.v4(),
        nom: 'Petit',
        couleur: const Color.fromARGB(255, 138, 197, 245).toARGB32(),
        ordre: 1,
      );

      final niveauMoyen = Niveau(
        id: uuid.v4(),
        nom: 'Moyen',
        couleur: const Color.fromARGB(255, 174, 250, 176).toARGB32(),
        ordre: 2,
      );

      final niveauGrand = Niveau(
        id: uuid.v4(),
        nom: 'Grand',
        couleur: const Color.fromARGB(255, 241, 197, 193).toARGB32(),
        ordre: 3,
      );

      await niveauxBox.putAll({
        niveauPetit.id: niveauPetit,
        niveauMoyen.id: niveauMoyen,
        niveauGrand.id: niveauGrand,
      });

      // Add default lists
      final listesBox = HiveService.listes;
      final motsBox = HiveService.mots;

      final liste1 = Liste()
        ..nom = 'Mots 1'
        ..image = 'assets/images/default.png'
        ..niveauId = niveauPetit.id
        ..motsIds = [];

      final liste2 = Liste()
        ..nom = 'Mots 2'
        ..image = 'assets/images/default.png'
        ..niveauId = niveauPetit.id
        ..motsIds = [];

      final liste3 = Liste()
        ..nom = 'Mots 3'
        ..image = 'assets/images/default.png'
        ..niveauId = niveauPetit.id
        ..motsIds = [];

      final liste4 = Liste()
        ..nom = 'Couleur des émotions'
        ..image = 'assets/images/default.png'
        ..niveauId = niveauMoyen.id
        ..motsIds = [];

      final liste5 = Liste()
        ..nom = 'Je me sens'
        ..image = 'assets/images/default.png'
        ..niveauId = niveauMoyen.id
        ..motsIds = [];

      final liste6 = Liste()
        ..nom = 'Les mots de l\'école'
        ..image = 'assets/images/default.png'
        ..niveauId = niveauGrand.id
        ..motsIds = [];

      await listesBox.addAll([liste1, liste2, liste3, liste4, liste5, liste6]);

      // Add default words
      final words = [
        Mot()
          ..idListe = liste1.key
          ..word = 'mie'
          ..image = 'assets/images/la_mie.png',
        Mot()
          ..idListe = liste1.key
          ..word = 'mât'
          ..image = 'assets/images/le_mat.png',
        Mot()
          ..idListe = liste1.key
          ..word = 'mot'
          ..image = 'assets/images/le_mot.png',
        Mot()
          ..idListe = liste1.key
          ..word = 'ami'
          ..image = 'assets/images/un_ami.png',
        Mot()
          ..idListe = liste1.key
          ..word = 'mur'
          ..image = 'assets/images/le_mur.png',
        Mot()
          ..idListe = liste1.key
          ..word = 'mémé'
          ..image = 'assets/images/la_meme.png',
        Mot()
          ..idListe = liste1.key
          ..word = 'fumée'
          ..image = 'assets/images/la_fumee.png',
        Mot()
          ..idListe = liste1.key
          ..word = 'momie'
          ..image = 'assets/images/la_momie.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'os'
          ..image = 'assets/images/un_os.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'as'
          ..image = 'assets/images/un_as.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'sofa'
          ..image = 'assets/images/le_sofa.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'mât'
          ..image = 'assets/images/le_mat.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'sumo'
          ..image = 'assets/images/le_sumo.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'fumée'
          ..image = 'assets/images/la_fumee.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'riz'
          ..image = 'assets/images/le_riz.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'sofa'
          ..image = 'assets/images/le_sofa.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'sumo'
          ..image = 'assets/images/le_sumo.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'semé'
          ..image = 'assets/images/il_a_seme.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'mamie'
          ..image = 'assets/images/la_meme.png',
        Mot()
          ..idListe = liste2.key
          ..word = 'fumée'
          ..image = 'assets/images/la_fumee.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'rue'
          ..image = 'assets/images/la_rue.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'roi'
          ..image = 'assets/images/le_roi.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'rat'
          ..image = 'assets/images/le_rat.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'riz'
          ..image = 'assets/images/le_riz.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'rit'
          ..image = 'assets/images/il_rit.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'mur'
          ..image = 'assets/images/le_mur.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'roi'
          ..image = 'assets/images/le_roi.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'rame'
          ..image = 'assets/images/la_rame.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'rame'
          ..image = 'assets/images/il_rame.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'Mari'
          ..image = 'assets/images/le_mari.png',
        Mot()
          ..idListe = liste3.key
          ..word = 'murmure'
          ..image = 'assets/images/il_murmure.png',
        Mot()
          ..idListe = liste4.key
          ..word = 'Amour'
          ..image = 'assets/images/amour.png',
        Mot()
          ..idListe = liste4.key
          ..word = 'Colère'
          ..image = 'assets/images/colere.png',
        Mot()
          ..idListe = liste4.key
          ..word = 'Joie'
          ..image = 'assets/images/joie.png',
        Mot()
          ..idListe = liste4.key
          ..word = 'Peur'
          ..image = 'assets/images/peur.png',
        Mot()
          ..idListe = liste4.key
          ..word = 'Sérénité'
          ..image = 'assets/images/serenite.png',
        Mot()
          ..idListe = liste4.key
          ..word = 'Tristesse'
          ..image = 'assets/images/tristesse.png',
        Mot()
          ..idListe = liste5.key
          ..word = 'joyeux'
          ..image = 'assets/images/joyeux.png',
        Mot()
          ..idListe = liste5.key
          ..word = 'triste'
          ..image = 'assets/images/triste.png',
        Mot()
          ..idListe = liste5.key
          ..word = 'effrayé'
          ..image = 'assets/images/effraye.png',
        Mot()
          ..idListe = liste5.key
          ..word = 'serein'
          ..image = 'assets/images/serein.png',
        Mot()
          ..idListe = liste5.key
          ..word = 'énervé'
          ..image = 'assets/images/enerve.png',
        Mot()
          ..idListe = liste5.key
          ..word = 'surpris'
          ..image = 'assets/images/surpris.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Crayon'
          ..image = 'assets/images/crayon.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Gomme'
          ..image = 'assets/images/gomme.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Feutres'
          ..image = 'assets/images/feutres.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Colorier'
          ..image = 'assets/images/colorier.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Ciseaux'
          ..image = 'assets/images/ciseaux.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Découper'
          ..image = 'assets/images/decouper.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Table'
          ..image = 'assets/images/table.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Cartable'
          ..image = 'assets/images/cartable.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Pinceau'
          ..image = 'assets/images/pinceau.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Tablier'
          ..image = 'assets/images/tablier.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Rouleau'
          ..image = 'assets/images/rouleau.png',
        Mot()
          ..idListe = liste6.key
          ..word = 'Banc'
          ..image = 'assets/images/banc.png',
      ];
      await motsBox.addAll(words);

      for (var mot in words) {
        final liste = listesBox.get(mot.idListe);
        liste?.motsIds.add(mot.key);
        await liste?.save();
      }

      // Add default students
      final elevesBox = HiveService.eleves;
      final eleves = [
        Eleve(id: uuid.v4(), nom: 'Clément', niveauId: niveauPetit.id),
        Eleve(id: uuid.v4(), nom: 'Thibault', niveauId: niveauPetit.id),
        Eleve(id: uuid.v4(), nom: 'Valentin', niveauId: niveauPetit.id),
        Eleve(id: uuid.v4(), nom: 'Gaëlle', niveauId: niveauMoyen.id),
        Eleve(id: uuid.v4(), nom: 'Camille', niveauId: niveauMoyen.id),
        Eleve(id: uuid.v4(), nom: 'Coraline', niveauId: niveauMoyen.id),
        Eleve(id: uuid.v4(), nom: 'Michèle', niveauId: niveauGrand.id),
        Eleve(id: uuid.v4(), nom: 'Patrick', niveauId: niveauGrand.id),
        Eleve(id: uuid.v4(), nom: 'Marie-Lou', niveauId: niveauGrand.id),
      ];
      await elevesBox.addAll(eleves);
    }
  }
}
