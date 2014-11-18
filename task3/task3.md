Tâche 3
-------

> Analyse de l'impact environnemental du procédé en termes de consommation énergétique et de rejet de CO2 et produits secondaires. Cette analyse fera ressortir les points sensibles du procédé et permettra d’établir une liste de recommandations argumentées pour réduire l’impact de l’activité de production sur l’environnement.

### 1. Analyse de la consommation énergétique

Nous allons considérer ici les entrées et sorties d'énergie de notre procédé de production d'ammoniac, afin de déterminer des possibles améliorations qui réduiraient notre consommation totale. Les points critiques analysés ici sont :

- le four à méthane ;
- la condensation du CO2, H2O (après le WGS) ;
- le refroidissement du réacteur à ammoniac ;
- la condensation du NH3 (après le réacteur).

#### Four à méthane

Le coût en énergie du four est une valeur relativement fixe pour une certaine quantité d'ammoniac à produire. Elle dépend fortement de la méthode utilisée pour produire l'hydrogène (voir "Analyse des rejets de CO2" > "Réduire l'impact") et peut donc être réduite de cette façon-là. Cela n'est cependant pas toujours rentable (voir détails dans la section en question).

Peu de détails sont donnés sur le fonctionnement et la structure du four. La valeur de son rendement --- 75% --- nous est fournie sans explication. Il est donc difficile de chercher à optimiser le processus ; néanmoins, nous avons considéré l'aspect suivant : le four rejette des vapeurs --- CO2, H2O et N2 --- à haute température, qui sont directement libérés dans l'atmosphère. Une façon courante de réutiliser ces produits est de s'en servir pour préchauffer l'air d'entrée. L'oxygène et l'azote injectés dans le four sont généralement responsables d'une certaine perte de rendement car, étant à basse température lors de leur entrée dans le four, une partie de la chaleur produite sert à les réchauffer. Utiliser les vapeurs de sortie pour préchauffer l'air d'entrée permet donc d'augmenter le rendement du four.

#### Condenseurs et circuits de refroidissements

On considère que ces procédés sont effectués à l'aide d'échangeurs de chaleur fonctionnant avec de l'eau. Deux cas différents sont à examiner :

##### Haute température

Si l'eau de sortie de l'échangeur de chaleur est disponible à haute température --- typiquement, plusieurs centaines de kelvins ---, elle possède une valeur économique relativement importante. Plusieurs possibilités sont envisageables :

- envoyer l'eau dans des turbines afin de produire du courant ;
- injecter l'eau dans le réformeur primaire, afin de profiter de sa haute température pour soulager l'usage du four ;
- utiliser l'eau pour chauffer les installations "humaines", c'est-à-dire les bureaux, réfectoires, etc.

Une analyse en détail sera nécessaire afin de déterminer lesquelles de ces solutions sont réalistes et rentables.

##### Basse température

Prenons l'exemple de l'eau de sortie du condenseur d'ammoniac. Sa température, donnée, de 95°C (voir rapport 1 de la tâche 1), est trop faible pour un usage industriel*. Cependant, une température de 95°C est, à l'échelle humaine, suffisante pour beaucoup d'usages. Une utilité envisageable pour cette eau de refroidissement est donc le chauffage des installations pour le personnel.

*Comme expliqué au cours de thermodynamique, la chaleur à basse température n'a pas une valeur économique très élevée, car c'est la différence de température entre une source chaude et une source froide qui importe réellement.


### 2. Analyse des rejets de CO2

#### Sources de CO2

Les différentes sources de CO2 de l'installation, telles qu'indiquées sur la flowsheet, sont :

- le four à méthane ;
- les réactions des réformeurs primaires et secondaires, et du water-gas shift.

L'analyse du procédé pour la production de 1500 t de NH3 et une température de sortie du RP de 1000 K nous donne les valeurs suivantes de CO2 rejeté :

- dans le four : 207 t ;
- dans le RP + WGS : 1718 t.

La source de CO2 la plus importante n'est donc pas le four, mais bien les réacteurs. C'est donc sur ceux-ci que nous allons concentrer nos recherches.

#### Réduire l'impact

Pour en réduire l'impact en CO2, considérons les différentes alternatives :

- utiliser une autre source d'hydrogène :
  - électrolyse de l'eau,
  - gazéification à la vapeur de la biomasse ;
- remplacer le gaz naturel par du biogaz ;
- capturer et stocker le CO2.

##### Électrolyse de l'eau

Si la réaction d'électrolyse ne produit pas de CO2, l'électricité qui permet d'effectuer cette réaction n'est pas nécessairement propre. Nous allons réaliser une rapide estimation de la quantité de CO2 rejeté par masse d'hydrogène produite.

En supposant que l'usine se trouve en Belgique, le CO2 rejeté par kWh d'électricité est de 0.29 kgCO2/kWh(él.). (source : http://www.econologie.com/europe-emissions-de-co2-par-pays-et-par-kwh-electrique-articles-3722.html)

La réaction d'électrolyse H2O -> H2 + 1/2O2 est endothermique et sa variation d'enthalpie est de 285 kJ/molH2. En outre, le rendement industriel d'une telle réaction varie généralement entre 70% et 85%, en fonction de l'installation et du procédé utilisé. (source: http://www.afhypac.org/images/documents/fiche_3.2.1_electrolyse_de_l_eau_rev._mai_2013_th.a.pdf)

Nous pouvons résoudre pour (masse de CO2)/(masse de H2) :

(0.29 kgCO2/kWh) / (eta) * (285 kJ/molH2) / (2.0158 10^-3 kg/molH2)
 = (0.29 kgCO2/kWh) * (141.38307 MJ/kgH2) / (eta)
 = (11.4 kgCO2/kgH2) / (eta),

ce qui nous donne un rapport de 16.3 à 13.4 kgCO2/kgH2 selon que le rendement est faible ou élevé. La production d'hydrogène à base de méthane, telle qu'elle est envisagée pour l'instant, produit elle 7.24 kg de CO2 par kg de H2*.

*Cette valeur prend en compte le four à méthane, car son utilité est couplée à celle des réformeurs.

Il apparait donc qu'à moins d'utiliser une source d'électricité propre, l'électrolyse n'est pas préférable au système actuel en terme de rejet de CO2.

##### Gazéification à la vapeur de la biomasse

Ce procédé permet la production d'hydrogène à base de biomasse (composition équivalente à C6H9O4) et d'eau. La réaction est faiblement endothermique (70 kJ/molH2 contre 285 kJ/molH2 pour l'électrolyse), mais l'intérêt réel en terme de CO2, par rapport au réformage du méthane, vient du fait que le dioxyde de carbone rejeté par le processus est, pour ainsi dire, nul. En effet, si une certaine quantité de CO2 est produite lors de la réaction, il s'agit de la même quantité qui a été absorbée par photosynthèse, en amont du processus.

(source : http://www.afh2.org/uploads/memento/biohydrogene.pdf)

Au total, la production de dioxyde de carbone provient uniquement du chauffage de la biomasse, à raison de 70 kJ/molH2 ou 34.72 MJ/kgH2. Si l'on utilise le même four que celui utilisé pour chauffer le réformeur primaire, on obtient un impact CO2 de 2.2890 kgCO2/kgH2. Pour 1500 t d'ammoniac, cela revient à 609 t de CO2.

En conclusion, la gazéification à la vapeur de la biomasse pourrait constituer une alternative intéressante, en terme de rejet de CO2, au procédé actuel de réformage.

*Détail des calculs*

DeltaH methane = -890 kJ/molCH4 = -890 kJ/molCO2

(890 kJ/molCO2) / (0.044 kgCO/molCO2) = (20.227 MJ/kgCO2)

(70 kJ/molH2) / (2.01588 10^-3 kgH2/molH2) / ((75%) * (20.227 MJ/kgCO2))
 = (34.724 MJ/kgH2) / ((75%) * (20.227 MJ/kgCO2))
 = 2.2890 kgCO2/kgH2

##### Biogaz

L'utilisation de biogaz à la place du gaz naturel permet une diminution du rejet de CO2 pour les mêmes raisons que la biomasse : le dioxyde de carbone rejeté n'est autre que celui ayant été absorbé par la végétation pour la production du biogaz. Il s'agit d'un circuit fermé, qui ne diminue ni n'augmente la quantité de CO2 présente dans l'atmosphère.

Généralement, le biogaz utilisé industriellement est différent du biogaz initial : le premier est beaucoup plus pure (environ 96% de méthane) que le second (qui contient notamment, en plus du CH4, du CO2, N2, H2, H2S et O2). La raison est que, dans la plupart des procédés, une concentration élevée en méthane est un facteur clé. Dans notre cas, la situation est différente : les composés CO2, N2, H2 et O2 sont déjà réactifs ou produits de certaines étapes du procédé Haber-Bosch. On peut donc se permettre d'utiliser du biogaz de faible qualité --- c'est-à-dire moins cher --- dont on aurait enlevé les composés corrosifs tels que le sulfure d'hydrogène.

##### Capture du CO2

*Toutes les recherches doc. effectuées jusqu'ici semblent indiquer qu'aucune solution d'envergure industrielle accessible en Belgique n'existe.*


### 3. Analyse des rejets de produits secondaires (autres que CO2)

#### Fonctionnement continu

Le seul déchet rejeté par le fonctionnement normal du plant, en dehors du CO2, est l'eau à haute température des circuits de refroidissement et des réacteurs. Bien que l'eau en soi n'est pas polluante, la chaleur qu'elle transporte, lorsqu'elle est rejeté dans un cours d'eau, peut avoir un impact sur l'écosystème local. Cela porte le nom de *pollution thermique*.

Une manière d'éviter cette pollution est de recycler cette eau par une autre utilisation qui profiterait de sa température, avant de finalement la rejeter dans une rivière. Ceci est discuté plus en détail dans la section "Analyse de la consommation énergétique" > "Condenseurs et circuits de refroidissements" ci-dessus.

#### Purge

Bien que le but de la purge est d'éliminer l'argon qui encrasse le réacteur, le rejet d'autre composés est inévitable. La flowsheet nous indique quels sont les composés présents à cette étape de la production : il s'agit de N2(g), H2(g), Ar(g) et NH3(g). Ceux-ci seront, lors de la purge, rejetés dans l'atmosphère.

Le diazote, naturellement présent dans l'air, ne constitue pas une pollution. Il en va de même pour l'argon et le dihydrogène, bien que ce dernier soit présent en très faible concentration. L'impact de ces rejets, comparé au volume de l'atmosphère, est plus que négligeable.

L'ammoniac, au contraire, est bel et bien un polluant. Il s'agit même, chez nous, du principal responsable de l'acidification des eaux et des pluies acides (source: http://www.statistiques.developpement-durable.gouv.fr/lessentiel/ar/215/1101/emissions-polluants-acides.html), bien que la grande majorité de cette pollution provienne non pas des industries, mais bien du secteur agricole (source: http://www.citepa.org/fr/pollution-et-climat/polluants/aep-item/ammoniac).

Une manière d'éviter le rejet d'ammoniac dans l'atmosphère serait de faire passer le contenu d'une purge dans un condenseur, afin de séparer le NH3 des autres composés. Une étude plus détaillée devra être entreprise pour déterminer si la pollution engendré par les purges est suffisante pour légitimer le processus.

Pour conclure sur un petit aparté, il est à considérer que le  dihydrogène et l'ammoniac rejetés lors des purges constituent tout deux des substances dangereuses et explosives. Le contact avec l'ammoniac peut provoquer des brûlures et son inhalation à forte dose peut provoquer la mort. (Source: http://www.citepa.org/fr/pollution-et-climat/polluants/aep-item/ammoniac).  Il est donc important de prendre en compte les risques qui viennent avec la manipulation de ces substances, mais cela n'est pas l'objet de cette discussion et devrait plutôt être traité lors d'une HAZOP.
