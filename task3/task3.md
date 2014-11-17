Tâche 3
-------

> Analyse de l'impact environnemental du procédé en termes de consommation énergétique et de rejet de CO2 et produits secondaires. Cette analyse fera ressortir les points sensibles du procédé et permettra d’établir une liste de recommandations argumentées pour réduire l’impact de l’activité de production sur l’environnement.

### 1. Analyse de la consommation énergétique

#### Zones de consommation d'énergie

- Four à méthane

#### Zones de pertes d'énergie

- Refroidissement et extraction du CO2, H2O (après le WGS)
- Refroidissement et extraction du NH3 (après le réacteur)


### 2. Analyse des rejets de CO2

#### Sources de CO2

Les différentes sources de CO2 de l'installation, telles qu'indiquées sur la flowsheet, sont :

- le four à méthane ;
- les réactions des réformeurs primaires et secondaires, et du water-gas shift.

L'analyse du procédé pour la production de 1500 t de NH3 et une température de sortie du RP de 1000 K nous donne les valeurs suivantes de CO2 rejeté :

- dans le four : 207 t ;
- dans le RP + WGS : 1718 t.

La source de CO2 la plus importante n'est donc pas le four, mais bien les réacteurs.

#### Réduire l'impact

Pour en réduire l'impact en CO2, considérons les différentes alternatives :

- utiliser une autre source d'hydrogène :
  - hydrolyse de l'eau,
  - gazéification à la vapeur de la biomasse ;
- remplacer le gaz naturel par du biogaz ;
- capturer et stocker le CO2.

##### Hydrolyse de l'eau

Si la réaction d'hydrolyse ne produit pas de CO2, l'électricité qui permet d'effectuer cette réaction n'est pas nécessairement propre. Nous allons réaliser une rapide estimation de la quantité de CO2 rejeté par masse d'hydrogène produite.

En supposant que l'usine se trouve en Belgique, le CO2 rejeté par kWh d'électricité est de 0.29 kgCO2/kWh(él.). (source : http://www.econologie.com/europe-emissions-de-co2-par-pays-et-par-kwh-electrique-articles-3722.html)

La réaction d'hydrolyse H2O -> H2 + 1/2O2 est endothermique et sa variation d'enthalpie est de 285 kJ/molH2. En outre, le rendement industriel d'une telle réaction varie généralement entre 70% et 85%, en fonction de l'installation et du procédé utilisé. (source: http://www.afhypac.org/images/documents/fiche_3.2.1_electrolyse_de_l_eau_rev._mai_2013_th.a.pdf)

Nous pouvons résoudre pour (masse de CO2)/(masse de H2) :

(0.29 kgCO2/kWh) / (eta) * (285 kJ/molH2) / (2.0158 10^-3 kg/molH2)
 = (0.29 kgCO2/kWh) * (141.38307 MJ/kgH2) / (eta)
 = (11.4 kgCO2/kgH2) / (eta),

ce qui nous donne un rapport de 16.3 à 13.4 kgCO2/kgH2 selon que le rendement est faible ou élevé. La production d'hydrogène à base de méthane, telle qu'elle est envisagée pour l'instant, produit elle 7.24 kg de CO2 par kg de H2*.

*Cette valeur prend en compte le four à méthane, car son utilité est couplée à celle des réformeurs.

Il apparait donc qu'à moins d'utiliser une source d'électricité propre, l'hydrolyse n'est pas préférable au système actuel en terme de rejet de CO2.

##### Gazéification à la vapeur de la biomasse

Ce procédé permet la production d'hydrogène à base de biomasse (composition équivalente à C6H9O4) et d'eau. La réaction est faiblement endothermique (70 kJ/molH2 contre 285 kJ/molH2 pour l'hydrolyse), mais l'intérêt réel en terme de CO2, par rapport au réformage du méthane, vient du fait que le dioxyde de carbone rejeté par le processus est, pour ainsi dire, nul. En effet, si une certaine quantité de CO2 est produite lors de la réaction, il s'agit de la même quantité qui a été absorbée par photosynthèse, en amont du processus.

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

- H2O(l) à haute température
- H2O(g)

#### Purge

- N2(g)
- H2(g)
- Ar(g)
