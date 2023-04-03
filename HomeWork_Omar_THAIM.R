

#   Homework du 03/04/2023


## IMPORTATION DE DONNEES 

# install.packages("foreign")
# library("foreign")
# search()
# Chemin="E:\ISEP2\Semestre_2\R\Cours_R_2023\\mm.dta"
# Base=read.dta(chemin)
# View(Base)
##AVEC LA FONCTION read.csv ou .xls ou .txt

# au format xls
chemin="E:/ISEP2/Semestre_2/R/Cours_R_2023/Cours_04_Base.xls"  # on peut aussi / alieu de \\
Base=read.xls(chemin)
View(Base)

# au format txt
chemin="E:/ISEP2/Semestre_2/R/Cours_R_2023/Cours_04_Base.txt"  # on peut aussi / alieu de \\
Base=read.txt(chemin)
View(Base)

# au format csv
chemin="E:/ISEP2/Semestre_2/R/Cours_R_2023/Cours_04_Base.csv"  # on peut aussi / alieu de \\
Base=read_csv2(chemin)
View(Base)

# au format data
library(haven)
mm <- read_dta("mm.dta")
View(mm)

# au format dta
library(haven)
mm <- read_dta("mm.dta")
View(mm)

# au format sav
library(haven)
DR <- read_sav("E:/ISEP1/Logiciels Statatistiques ( SPSS,STATA)/SPSS/DONNEES_DEVOIR.sav")
View(DR)

## AVEC LA FONCTION read.table
# pour le format texte
donnees <- read.table("E:/ISEP2/Semestre_2/R/Cours_R_2023/Cours_04_Base.txt", header = TRUE)
View(donnees)
# SELECTION DE VARIABLES

Base$ Salaire  # exemple de la var "salaire" dans la base "Base"
Base$ Nom    # exemple de la var "Nom" dans la base "Base"

# FILTRAGE DE DONNEES
Base[Base$age < 25, ] # toutes les colonnes sont inclues
donnees[donnees$Work !=1, 3] # affichage de la colonne 3
donnees[donnees$Work !=1, c(1,2,3,5)] # affichage unique des colonnes du vecteur c

# AGGREGATIODE DONNEES
# aggreger la var "Work" par "Region"
aggregate(Base$Work, by = list(Base$Region), FUN = sum)
aggregate(mm$PERSONS) , by=list(mm$REGNSN), FUN = sum )

# FUSION DE DONNEES
# Création des ensembles de données
data1 <- data.frame(id = c(1, 2, 3), var1 = c("a", "b", "c"))
data2 <- data.frame(id = c(1, 3, 4), var2 = c(10, 20, 30))
data1
data2
# Fusion des ensembles de données
merged_data <- merge(data1, data2, by = "id")
merged_data
## example of using 'incomparables'
x <- data.frame(k1 = c(NA,NA,3,4,5), k2 = c(1,NA,NA,4,5), data = 1:5)
y <- data.frame(k1 = c(NA,2,NA,4,5), k2 = c(NA,NA,3,4,5), data = 1:5)
merge(x, y, by = c("k1","k2")) 
merge(x, y, by = "k1")
merge(x, y, by = "k2", incomparables = NA) # 2 rows

merge(x, y, by = NULL, by.x = NULL, by.y = NULL, all = FALSE, all.x = all, all.y = all,
      sort = TRUE, suffixes = c(".x", ".y"), no.dups = TRUE, incomparables = NULL,
      ...)
où :
  
  # x et y sont les data frames à fusionner.
  # by est une chaîne ou un vecteur de noms de colonnes qui doivent être utilisées
  # pour la fusion. Si NULL, la fusion est effectuée en utilisant toutes les colonnes 
  # en commun.
  # by.x et by.y sont les noms des colonnes à utiliser comme clé de fusion dans 
  # les data frames x et y, respectivement. Si les noms des colonnes sont différents
  # dans les deux data frames, ces arguments doivent être utilisés.
  # all est un booléen qui indique si les valeurs qui n'ont pas de correspondance
  # dans l'autre data frame doivent être incluses dans la fusion. Par défaut, all
  # est FALSE.
# all.x et all.y sont des booléens qui indiquent si toutes les observations
# de x ou y doivent être incluses dans la fusion, respectivement.
# sort est un booléen qui indique si les résultats doivent être triés selon 
# les clés de fusion.
# suffixes est un vecteur de chaînes de caractères à utiliser comme suffixes
# pour différencier les noms de colonnes qui ont des noms identiques dans les
# data frames à fusionner.
# no.dups est un booléen qui indique si les doublons doivent être supprimés ou
# conservés.
# incomparables est un vecteur de valeurs qui ne peuvent pas être comparées.
# Les observations correspondantes seront exclues de la fusion.
# ... est utilisé pour passer des arguments supplémentaires à d'autres fonctions.


## STATISTIQUES DESCRIPTIVES
summary(Base)     # resume statistique de la base Base
summary(Base$Note)
median(Base$Note)
sd(Base$Note)

###  MANIPULATION DE DONNEES dplyr et tidyr

library("dplyr") 

# library("tidyverse") 
# search()
# Les principales fonctions à connaître pour réaliser des manipulations 
# de données sont :
#   
#   filter() : pour sélectionner des lignes,
# select() : pour sélectionner des colonnes,
# mutate() : pour créer des variables,
# summarise() : pour résumer des données, en calculant des paramètres 
# descriptifs,
# group_by() : pour regrouper les données (avant de calculer un paramètre
# descriptif par exemple).
# Ces cinq fonctions peuvent s’utiliser les unes après les autres,
# en utilisant le symbole “%>%” (pipe en anglais), que l’on pourrait 
# traduire par “et puis”.
head(Base)
tail(Base)

# FILTRAGE DE LIGNES

library(dplyr)
filter(data, condition) # synthaxe
df<-filter(donnees,age>50)
df
# oubien
filter(donnees,Sexe=="F")

filter(donnees,age<30)
# FILTRAGE MULTIPLE
filter(donnees,Sexe=="F")
filter(donnees,age<30)

# SELECTION DE COLONNES

library(dplyr)
select(Base,Nom)
select(Base,Nom,Mention)

# CREATION DE VARIABLES
mutate(data, new_variable = expression) # Synthaxe
mutate(Base,Nom_Region=paste(Base$Nom,Base$Mention))

# summarize

#La fonction group_by
library(dplyr)
nouveau_df <- df %>% group_by(Mention) %>% summarise(Total_Population = sum(Salaire))
nouveau_df

# renommer une var
rename(data, new_name1 = old_name1,new_name2 = old_name2,....) # Synthaxe
rename(Base,age,New_name)



















###3.1 (solution) À l'aide des fonctions rep, seq et c seulement, générer
#les séquences suivantes.
# a.	0 6 0 6 0 6
# b.	1 4 7 10
# c.	1 2 3 1 2 3 1 2 3 1 2 3
# d.	1 2 2 3 3 3
# e.	1 1 1 2 2 3
# f.	1 5.5 10
# g.	1 1 1 1 2 2 2 2 3 3 3 3


#Reponse
#a
rep(c(0, 6), 3)     
#b
seq(1, 10, by = 3)
#c
rep(1:3, 4)
#d
rep(1:3, 1:3)
#e
rep(1:3, 3:1)
#f
seq(1, 10, length = 3)
#g
rep(1:3, rep(4,3))


#Générer les suites de nombres suivantes à l'aide des fonctions :
#et rep seulement, donc sans utiliser la fonction seq.
# a.	1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2
# b.	1 3 5 7 9 11 13 15 17 19
# c.	-2 -1 0 1 2 -2 -1 0 1 2
# d.	-2 -2 -1 -1 0 0 1 1 2 2
#e.	10 20 30 40 50 60 70 80 90 100

#Reponse
11:20 / 10
2 * 0:9 + 1
rep(-2:2, 2)
rep(-2:2, each = 2)
10 * 1:10

## 3.3 (solution) À l'aide de la commande apply, écrire des expressions R 
#qui remplaceraient les fonctions suivantes.

# a.	rowSums
# b.	colSums
# c.	rowMeans
# d.	colMeans

#Reponse
apply(x, 1, sum)  # 1-> ligne
apply(x, 2, sum) # 2_> colonne
apply(x, 1, mean) #1-> ligne
apply(x, 2, mean) #1-> colonne
x<-c(1,4,8,9,5,45,32,12,56,76,6,9)
length(x)
mat<-matrix(x,nrow=3,ncol=4)
mat


# Solution de l'exercice 3.4> 
cumprod(1:10)

#Solution de l'exercice 3.5
x == (x %% y) + y * (x %/% y)


#Solution de l'exercice 3.6
# Écrire une expression R permettant d'obtenir ou de calculer chacun des résultats 
#demandés ci-dessous.
x<-c(1,3,2,4,5,6,7,9,0,8,7,6,5,4,3,2,5,12,21,41)
length(x)
# Les cinq premiers éléments de l'échantillon.
head(x,5)
# La valeur maximale de l'échantillon.
max(x)
# La moyenne des cinq premiers éléments de l'échantillon.
mean(head(x,5))
# La moyenne des cinq derniers éléments de l'échantillon.
mean(tail(x,5))

#Solution de l'exercice 3.7
a.	(j - 1)*I + i
b.	((k - 1)*J + j - 1)*I + i

#Solution de l'exercice 3.8
a.	> rowSums(mat)
b.	> colMeans(mat)
c.	> max(mat[1:3, 1:3])
d.	> mat[rowMeans(mat) > 7,]

#Solution de l'exercice 3.9> 
temps[match(unique(cummin(tps)), temps)]







### EXPOSE SUR PASTEO ET PASTE


# Methode de concatenation sans aucun separateur 

# Concaténation de deux chaînes de caractères
prenom <- "Hafia"
nom <- "Diallo"
paste0(prenom, nom)  # output  "HafiaDiallo"

# Concaténation de deux vecteurs de chaînes de caractères
v1 <- c("a", "b", "c")
v2 <- c("x", "y", "z")
paste0(v1, v2)

# La fonction paste est une fonction de R qui permet de concaténer des chaînes de
# caractères en insérant un séparateur entre chaque chaîne. Le séparateur par défaut 
# est un espace (" "), mais il peut être spécifié grâce à l'argument sep

# Concaténation de deux chaînes de caractères avec space apr defaut
prenom <- "Omar"
nom <- "THIAM"
paste(prenom, nom,sep="$")  # output "Omar THIAM"


# Concaténation de deux vecteurs de chaînes de caractères
v1 <- c("a", "b", "c")
v2 <- c("x", "y", "z")
paste(v1, v2, sep = "*")




