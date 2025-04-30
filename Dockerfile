# Utilisation d'une image Node.js officielle (adapter si nécessaire)
FROM node:18 AS build

# Définition du répertoire de travail dans le conteneur
WORKDIR /app

# Copie des fichiers package.json et package-lock.json
COPY package*.json ./

# Installation des dépendances
RUN npm install

# Copie du reste du projet
COPY . .

RUN npm run build

FROM node:18

RUN npm install -g serve

WORKDIR /app

COPY --from=build /app/build .

# Exposition du port utilisé par l'application (ex: 3000)
EXPOSE 3000

# Commande de démarrage de l'application
CMD ["serve", "-s", ".", "-l", "3000"]