#!/bin/bash
set -e

echo "Generando despliegue..."

mkdir -p deploy
cp -r exports/* deploy/

echo "Despliegue preparado correctamente en la carpeta deploy."