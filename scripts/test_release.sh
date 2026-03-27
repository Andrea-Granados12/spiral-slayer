#!/bin/bash
set -e

echo "Ejecutando pruebas del entorno de liberación..."

if [ ! -f "exports/index.html" ]; then
  echo "Error: no se encontró exports/index.html"
  exit 1
fi

echo "Prueba aprobada: exports/index.html existe."