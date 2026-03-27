#!/bin/bash
set -e

echo "Creando entorno de liberación..."

mkdir -p exports

if [ -f "index.html" ]; then
  cp index.html exports/index.html
else
  echo "<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Spiral Slayer</title></head><body><h1>Spiral Slayer</h1><p>Build de liberación</p></body></html>" > exports/index.html
fi

echo "Entorno de liberación generado correctamente."