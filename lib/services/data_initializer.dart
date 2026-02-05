import 'package:myapp/models/models.dart';
import 'package:myapp/services/isar_service.dart';

class DataInitializer {
  static Future<void> initializeData() async {
    final isar = IsarService.isar;

    final niveauxCount = await isar.niveaus.count();
    if (niveauxCount == 0) {
      await isar.writeTxn(() async {
        // Add default levels
        final niveauPetit = Niveau()
          ..nom = 'Petit'
          ..couleur = 'blue'
          ..ordre = 1;

        final niveauMoyen = Niveau()
          ..nom = 'Moyen'
          ..couleur = 'green'
          ..ordre = 2;

        final niveauGrand = Niveau()
          ..nom = 'Grand'
          ..couleur = 'red'
          ..ordre = 3;

        await isar.niveaus.putAll([niveauPetit, niveauMoyen, niveauGrand]);

        // Add default lists
        final liste1 = Liste()
          ..nom = 'Mots 1'
          ..image = 'assets/images/default.png'
          ..niveaux.add(niveauPetit);

        final liste2 = Liste()
          ..nom = 'Mots 2'
          ..image = 'assets/images/default.png'
          ..niveaux.add(niveauPetit);

        final liste3 = Liste()
          ..nom = 'Mots 3'
          ..image = 'assets/images/default.png'
          ..niveaux.add(niveauPetit);

        final liste4 = Liste()
          ..nom = 'Couleur des émotions'
          ..image = 'assets/images/default.png'
          ..niveaux.addAll([niveauMoyen, niveauGrand]);
        
        final liste5 = Liste()
          ..nom = 'Je me sens'
          ..image = 'assets/images/default.png'
          ..niveaux.addAll([niveauMoyen, niveauGrand]);

        final liste6 = Liste()
          ..nom = 'Les mots de l\'école'
          ..image = 'assets/images/default.png'
          ..niveaux.addAll([niveauMoyen, niveauGrand]);

        await isar.listes.putAll([liste1, liste2, liste3, liste4, liste5, liste6]);
        
        // Save links
        await liste1.niveaux.save();
        await liste2.niveaux.save();
        await liste3.niveaux.save();
        await liste4.niveaux.save();
        await liste5.niveaux.save();
        await liste6.niveaux.save();


        // Add default students
        final eleves = [
          Eleve()..prenom = 'Clément'..niveau.value = niveauPetit,
          Eleve()..prenom = 'Thibault'..niveau.value = niveauPetit,
          Eleve()..prenom = 'Valentin'..niveau.value = niveauPetit,
          Eleve()..prenom = 'Gaëlle'..niveau.value = niveauMoyen,
          Eleve()..prenom = 'Camille'..niveau.value = niveauMoyen,
          Eleve()..prenom = 'Coraline'..niveau.value = niveauMoyen,
          Eleve()..prenom = 'Michèle'..niveau.value = niveauGrand,
          Eleve()..prenom = 'Patrick'..niveau.value = niveauGrand,
          Eleve()..prenom = 'Marie-Lou'..niveau.value = niveauGrand,
        ];
        await isar.eleves.putAll(eleves);
        for (var eleve in eleves) {
          await eleve.niveau.save();
        }

        // Add default words
        final words = [
          Mot(idListe: liste1.idListe, word: 'mie', image: 'assets/images/la_mie.png'),
          Mot(idListe: liste1.idListe, word: 'mât', image: 'assets/images/le_mat.png'),
          Mot(idListe: liste1.idListe, word: 'mot', image: 'assets/images/le_mot.png'),
          Mot(idListe: liste1.idListe, word: 'ami', image: 'assets/images/un_ami.png'),
          Mot(idListe: liste1.idListe, word: 'mur', image: 'assets/images/le_mur.png'),
          Mot(idListe: liste1.idListe, word: 'mémé', image: 'assets/images/la_meme.png'),
          Mot(idListe: liste1.idListe, word: 'fumée', image: 'assets/images/la_fumee.png'),
          Mot(idListe: liste1.idListe, word: 'momie', image: 'assets/images/la_momie.png'),
          Mot(idListe: liste2.idListe, word: 'os', image: 'assets/images/un_os.png'),
          Mot(idListe: liste2.idListe, word: 'as', image: 'assets/images/un_as.png'),
          Mot(idListe: liste2.idListe, word: 'sofa', image: 'assets/images/le_sofa.png'),
          Mot(idListe: liste2.idListe, word: 'mât', image: 'assets/images/le_mat.png'),
          Mot(idListe: liste2.idListe, word: 'sumo', image: 'assets/images/le_sumo.png'),
          Mot(idListe: liste2.idListe, word: 'fumée', image: 'assets/images/la_fumee.png'),
          Mot(idListe: liste2.idListe, word: 'riz', image: 'assets/images/le_riz.png'),
          Mot(idListe: liste2.idListe, word: 'sofa', image: 'assets/images/le_sofa.png'),
          Mot(idListe: liste2.idListe, word: 'sumo', image: 'assets/images/le_sumo.png'),
          Mot(idListe: liste2.idListe, word: 'semé', image: 'assets/images/il_a_seme.png'),
          Mot(idListe: liste2.idListe, word: 'mamie', image: 'assets/images/la_meme.png'),
          Mot(idListe: liste2.idListe, word: 'fumée', image: 'assets/images/la_fumee.png'),
          Mot(idListe: liste3.idListe, word: 'rue', image: 'assets/images/la_rue.png'),
          Mot(idListe: liste3.idListe, word: 'roi', image: 'assets/images/le_roi.png'),
          Mot(idListe: liste3.idListe, word: 'rat', image: 'assets/images/le_rat.png'),
          Mot(idListe: liste3.idListe, word: 'riz', image: 'assets/images/le_riz.png'),
          Mot(idListe: liste3.idListe, word: 'rit', image: 'assets/images/il_rit.png'),
          Mot(idListe: liste3.idListe, word: 'mur', image: 'assets/images/le_mur.png'),
          Mot(idListe: liste3.idListe, word: 'roi', image: 'assets/images/le_roi.png'),
          Mot(idListe: liste3.idListe, word: 'rame', image: 'assets/images/la_rame.png'),
          Mot(idListe: liste3.idListe, word: 'rame', image: 'assets/images/il_rame.png'),
          Mot(idListe: liste3.idListe, word: 'Mari', image: 'assets/images/le_mari.png'),
          Mot(idListe: liste3.idListe, word: 'murmure', image: 'assets/images/il_murmure.png'),
          Mot(idListe: liste4.idListe, word: 'Amour', image: 'assets/images/amour.png'),
          Mot(idListe: liste4.idListe, word: 'Colère', image: 'assets/images/colere.png'),
          Mot(idListe: liste4.idListe, word: 'Joie', image: 'assets/images/joie.png'),
          Mot(idListe: liste4.idListe, word: 'Peur', image: 'assets/images/peur.png'),
          Mot(idListe: liste4.idListe, word: 'Sérénité', image: 'assets/images/serenite.png'),
          Mot(idListe: liste4.idListe, word: 'Tristesse', image: 'assets/images/tristesse.png'),
          Mot(idListe: liste5.idListe, word: 'joyeux', image: 'assets/images/joyeux.png'),
          Mot(idListe: liste5.idListe, word: 'triste', image: 'assets/images/triste.png'),
          Mot(idListe: liste5.idListe, word: 'effrayé', image: 'assets/images/effraye.png'),
          Mot(idListe: liste5.idListe, word: 'serein', image: 'assets/images/serein.png'),
          Mot(idListe: liste5.idListe, word: 'énervé', image: 'assets/images/enerve.png'),
          Mot(idListe: liste5.idListe, word: 'surpris', image: 'assets/images/surpris.png'),
          Mot(idListe: liste6.idListe, word: 'Crayon', image: 'assets/images/crayon.png'),
          Mot(idListe: liste6.idListe, word: 'Gomme', image: 'assets/images/gomme.png'),
          Mot(idListe: liste6.idListe, word: 'Feutres', image: 'assets/images/feutres.png'),
          Mot(idListe: liste6.idListe, word: 'Colorier', image: 'assets/images/colorier.png'),
          Mot(idListe: liste6.idListe, word: 'Ciseaux', image: 'assets/images/ciseaux.png'),
          Mot(idListe: liste6.idListe, word: 'Découper', image: 'assets/images/decouper.png'),
          Mot(idListe: liste6.idListe, word: 'Table', image: 'assets/images/table.png'),
          Mot(idListe: liste6.idListe, word: 'Cartable', image: 'assets/images/cartable.png'),
          Mot(idListe: liste6.idListe, word: 'Pinceau', image: 'assets/images/pinceau.png'),
          Mot(idListe: liste6.idListe, word: 'Tablier', image: 'assets/images/tablier.png'),
          Mot(idListe: liste6.idListe, word: 'Rouleau', image: 'assets/images/rouleau.png'),
          Mot(idListe: liste6.idListe, word: 'Banc', image: 'assets/images/banc.png'),
          Mot(idListe: liste4.idListe, word: 'Amour', image: 'assets/images/amour.png'),
          Mot(idListe: liste4.idListe, word: 'Colère', image: 'assets/images/colere.png'),
          Mot(idListe: liste4.idListe, word: 'Joie', image: 'assets/images/joie.png'),
          Mot(idListe: liste4.idListe, word: 'Peur', image: 'assets/images/peur.png'),
          Mot(idListe: liste4.idListe, word: 'Sérénité', image: 'assets/images/serenite.png'),
          Mot(idListe: liste4.idListe, word: 'Tristesse', image: 'assets/images/tristesse.png'),
          Mot(idListe: liste4.idListe, word: 'Rire', image: 'assets/images/rire.png'),
          Mot(idListe: liste4.idListe, word: 'Pleurer', image: 'assets/images/pleurer.png'),
          Mot(idListe: liste5.idListe, word: 'joyeux', image: 'assets/images/joyeux.png'),
          Mot(idListe: liste5.idListe, word: 'triste', image: 'assets/images/triste.png'),
          Mot(idListe: liste5.idListe, word: 'effrayé', image: 'assets/images/effraye.png'),
          Mot(idListe: liste5.idListe, word: 'serein', image: 'assets/images/serein.png'),
          Mot(idListe: liste5.idListe, word: 'énervé', image: 'assets/images/enerve.png'),
          Mot(idListe: liste5.idListe, word: 'surpris', image: 'assets/images/surpris.png'),
          Mot(idListe: liste6.idListe, word: 'Crayon', image: 'assets/images/crayon.png'),
          Mot(idListe: liste6.idListe, word: 'Gomme', image: 'assets/images/gomme.png'),
          Mot(idListe: liste6.idListe, word: 'Feutres', image: 'assets/images/feutres.png'),
          Mot(idListe: liste6.idListe, word: 'Colorier', image: 'assets/images/colorier.png'),
          Mot(idListe: liste6.idListe, word: 'Ciseaux', image: 'assets/images/ciseaux.png'),
          Mot(idListe: liste6.idListe, word: 'Découper', image: 'assets/images/decouper.png'),
          Mot(idListe: liste6.idListe, word: 'Table', image: 'assets/images/table.png'),
          Mot(idListe: liste6.idListe, word: 'Cartable', image: 'assets/images/cartable.png'),
          Mot(idListe: liste6.idListe, word: 'Pinceau', image: 'assets/images/pinceau.png'),
          Mot(idListe: liste6.idListe, word: 'Tablier', image: 'assets/images/tablier.png'),
          Mot(idListe: liste6.idListe, word: 'Rouleau', image: 'assets/images/rouleau.png'),
          Mot(idListe: liste6.idListe, word: 'Banc', image: 'assets/images/banc.png'),
          Mot(idListe: liste6.idListe, word: 'Cahiers', image: 'assets/images/cahiers.png'),
          Mot(idListe: liste6.idListe, word: 'Classeur', image: 'assets/images/classeur.png'),
          Mot(idListe: liste6.idListe, word: 'Gomme', image: 'assets/images/gomme.png'),
          Mot(idListe: liste6.idListe, word: 'Crayon_de_couleur', image: 'assets/images/crayons.png'),
          Mot(idListe: liste6.idListe, word: 'Crayons_a_papier', image: 'assets/images/crayon.png'),
          Mot(idListe: liste6.idListe, word: 'Taille-crayon', image: 'assets/images/taille-crayon.png')
        ];
        await isar.mots.putAll(words);
      });
    }
  }
}
