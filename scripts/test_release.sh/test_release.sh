#!/bin/bash
set -e

echo "Ejecutando pruebas del entorno de liberación..."

if [ ! -f "exports/index.html" ]; then
  echo "Error: no se encontró el archivo exportado index.html"
  exit 1
fi

echo "Prueba 1 aprobada: el archivo exportado existe."

if grep -q "<html" exports/index.html; then
  echo "Prueba 2 aprobada: el archivo HTML es válido."
else
  echo "Error: el archivo exportado no contiene estructura HTML válida."
  exit 1
fi

echo "Todas las pruebas fueron aprobadas."