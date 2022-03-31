#!/bin/bash

## Script for aa klone repo, installere dependencies, starte services i docker,
## kjoere tester og hente ut coverage report til egna mappe

## TODO: 
# sjekk av repo, eksisterer = ok
# sjekk av destinasjon, if exist toem det

# opprett parametre for enklare utskifting
REPO='https://github.com/hedasp/event-driven-microservices-docker-kksetup.git'
DESTINATION='event-driven'

git clone $REPO $DESTINATION
cd $DESTINATION

# Installer node.js og npm for version 11 (versionen nytta i repoet)
nvm install 11
# opprett tom package.json 
npm init -y
# installer dependencies fra dei ulike servicene
npm install services/articles-management/
npm install services/events-management/
npm install services/user-management/
npm install services/notification/
# installer jest(globalt for mitt herpa miljoe)
sudo npm install -g jest
# Bygge containarane, obs - har/kan gjoere endringar paa docker-compose file
docker-compose build --no-cache
# fyr opp containarane
docker-compose up -d
# sjekk at dei har det bra
docker ps -a
# kjoer testane
./run_all_tests

#package.json for kvar service inneheld directory for coverage rapportane. 
# i eit tenkt miljoe f.eks i /local/docker/reports
