FROM ubuntu:latest

# Installation de bash (si nécessaire)
RUN apt-get update && apt-get install -y bash

# Création du répertoire de travail
WORKDIR /app

# Copie des scripts et du fichier .env dans l'image
COPY .env ./
COPY placeholder.sh ./
COPY replace_placeholders.sh ./

# Exécution du script pour créer le .env.placeholder lors de la construction de l'image
RUN chmod +x placeholder.sh replace_placeholders.sh && \
    ./placeholder.sh .env

# Commande pour exécuter au démarrage du conteneur
CMD ["bash", "-c", "./replace_placeholders.sh .env.placeholder && cat .env && /bin/bash"]
