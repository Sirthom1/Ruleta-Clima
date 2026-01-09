# Ruleta-Clima

Esta aplicación es una **simulación de ruleta con clima**, desplegada en Render.  

El proyecto permite:

- Agregar jugadores.
- Cada ronda se ejecuta cada 3 minutos.
- Cada jugador parte con 10.000 unidades.
- La dinámica combina resultados de ruleta con efectos del clima, consumidos desde la API de Meteosource.
- **Nuevo:** Las probabilidades de ganar varían según la hora del día:
  - **Noche (21:00 - 5:59)**: Mayor probabilidad de ganar (multiplicador 1.3x)
  - **Tarde (14:00 - 20:59)**: Probabilidad normal (multiplicador 1.0x)
  - **Mañana (6:00 - 13:59)**: Menor probabilidad de ganar (multiplicador 0.8x)

El proyecto tiene dos modos de uso:

1. **Producción en Render:** solo visitar el link y ver la app funcionando.  
2. **Desarrollo local:** correr Rails con SQLite para pruebas o desarrollo (en este modo, para que funcionen los intervalos de 3 minutos y el saldo inicial, hay que mantener corriendo las tareas de rake en background).

---

## Link en vivo

[Visitar la app en Render](https://ruleta-clima.onrender.com/game_rounds)

---

## Requisitos para desarrollo local

- Ruby 3.4
- Rails 8
- SQLite3 (solo para desarrollo local)
- Bundler (`gem install bundler`)
- Node.js y Yarn (para assets JS)
- Variables de entorno necesarias:
  - `METEOSOURCE_API_KEY`: clave para consumir el API de clima

Esta app utiliza la API de Meteosource para obtener datos climáticos. Para que funcione correctamente en local, debes registrarte y obtener tu propia METEOSOURCE_API_KEY.

---

## Configuración para desarrollo local

1. Clonar el repositorio:

```bash
git clone https://github.com/Sirthom1/Ruleta-Clima.git
cd Ruleta-Clima

```
2. Instalar dependencias Ruby:
```bash
bundle install
```

3. Instalar dependencias JS:
```bash
yarn install
```

4. Crear y preparar la base de datos:
```bash
rails db:setup
```

5. Configurar variables de entorno:
Puedes usar un export.
```bash
# En tu terminal
export METEOSOURCE_API_KEY="tu_api_key"

# O en un archivo .env en la raíz del proyecto
METEOSOURCE_API_KEY="tu_api_key"

```


6. Correr el servidor local:
```bash
rails server
```

Por último, se deben ejecutar las 2 tareas de rake (/lib/tasks/)para que se manejen las rondas y el saldo. Además, de mantenerlas corriendo en segundo plano para que funcione todo. 
```bash
bin/rake roulette:spin
bin/rake daily:bonus
```

---
## Tests

Para ejecutar todos los tests del proyecto:
```bash
bin/rails test
```

Esto incluye tests de modelos, servicios y simulación.

---
## Notas

En producción la app usa PostgreSQL en Render.

En desarrollo usamos SQLite para simplicidad.

No se necesita ejecutar ningún Active Job o tarea extra para usar la app.

---
## Detalles Técnicos

### Sistema de Probabilidades por Hora del Día

La aplicación implementa un sistema dinámico de probabilidades que varía según el momento del día:

- **TimeOfDayService**: Servicio que determina el período del día (mañana/tarde/noche) y calcula el multiplicador de probabilidad correspondiente.
- **RouletteService**: Ajusta las probabilidades de los colores de la ruleta según el multiplicador del período del día. Durante la noche, aumenta ligeramente la probabilidad del color verde (mejor pago), mientras que en la mañana la reduce.
