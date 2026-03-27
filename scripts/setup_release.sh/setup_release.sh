#!/bin/bash
set -e

echo "Creando entorno de liberación..."

mkdir -p exports

echo "Simulando exportación del videojuego..."
cp index.html exports/index.html

echo "Entorno de liberación generado correctamente."