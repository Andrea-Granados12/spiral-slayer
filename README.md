# Spiral Slayer - DevOps

Este repositorio contiene la automatización del flujo DevOps del videojuego Spiral Slayer.

## Incluye
- Pipeline de integración y despliegue continuo con GitHub Actions
- Script para la generación del entorno de liberación
- Script de pruebas del entorno de liberación
- Script para la generación del despliegue

## Flujo
1. Se realiza un push al repositorio
2. GitHub Actions ejecuta el pipeline
3. Se genera el entorno de liberación
4. Se realizan pruebas automáticas
5. Se genera el despliegue
6. Se guardan los artefactos resultantes