# Terraform AWS Infrastructure

## Description
Ce projet Terraform permet de déployer une infrastructure AWS complète comprenant :
- Un VPC personnalisé
- Des sous-réseaux publics et privés
- Une passerelle Internet et un NAT Gateway
- Une table de routage pour la connectivité réseau
- Une instance EC2 Amazon Linux

## Architecture
L'infrastructure créée comprend :
- **VPC** : Un réseau virtuel avec un CIDR configurable
- **Subnets** :
  - 3 sous-réseaux publics
  - 3 sous-réseaux privés
- **Internet Gateway** : Permet l'accès à Internet aux sous-réseaux publics
- **Route Tables** : Gère le routage entre les sous-réseaux et l'Internet Gateway/NAT Gateway
- **NAT Gateway** : Permet aux sous-réseaux privés d'accéder à Internet de manière sécurisée
- **Instance EC2** : Une machine virtuelle exécutant Amazon Linux

## Fichiers Terraform
- **`main.tf`** : Définit le provider AWS et la région
- **`vpc.tf`** : Crée le VPC
- **`variables.tf`** : Définit les variables pour la configuration de l'infrastructure
- **`subnet_public.tf`** : Configure les sous-réseaux publics et leur connectivité
- **`subnet_private.tf`** : Configure les sous-réseaux privés et leur connectivité
- **`instances.tf`** : Crée une instance EC2 dans le sous-réseau public
- **`datasource.tf`** : Récupère l'AMI Amazon Linux la plus récente et les zones de disponibilité

## Prérequis
Avant d'exécuter ce projet, assurez-vous d'avoir :
- Terraform installé sur votre machine
- Un compte AWS configuré avec les bonnes permissions
- Un fichier `~/.aws/credentials` configuré avec vos accès AWS

## Déploiement
1. **Initialiser Terraform** :
   ```sh
   terraform init
   ```
2. **Vérifier le plan de déploiement** :
   ```sh
   terraform plan
   ```
3. **Appliquer la configuration** :
   ```sh
   terraform apply -auto-approve
   ```

## Destruction de l'Infrastructure
Pour supprimer toutes les ressources créées :
```sh
terraform destroy -auto-approve
```

## Améliorations Futures
- Ajout d'un Load Balancer pour gérer le trafic
- Intégration avec un service de base de données RDS
- Sécurisation des accès via un Security Group plus restrictif

