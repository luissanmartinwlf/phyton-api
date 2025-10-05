# Proyecto: API en Python Containerizada con Docker

Este proyecto es parte de una actividad académica para la asignatura de Contenedores. El objetivo es crear una API web simple con Python y Flask, y containerizarla utilizando Docker, siguiendo las mejores prácticas de seguridad y producción.

---

## Tecnologías Utilizadas

* **Python 3.9**: Lenguaje de programación base.
* **Flask**: Micro-framework para crear la API web.
* **Gunicorn**: Servidor WSGI de nivel de producción para ejecutar la aplicación.
* **Docker**: Plataforma para la containerización de la aplicación.

---

## Estructura del Proyecto

```
/
├── app.py           # Código fuente de la API
├── requirements.txt # Dependencias de Python (Flask, Gunicorn, Werkzeug)
├── Dockerfile       # Instrucciones para construir la imagen Docker
└── README.md        # Este archivo
```

---

## Cómo Ejecutar el Proyecto Localmente

Para ejecutar este proyecto, necesitas tener **Docker Desktop** instalado y en ejecución.

### 1. Clonar el Repositorio

```bash
git clone [https://github.com/luissanmartinwlf/phyton-api.git](https://github.com/luissanmartinwlf/phyton-api.git)
cd NOMBRE_DEL_REPO
```

### 2. Construir la Imagen de Docker

Desde la raíz del proyecto, ejecuta el siguiente comando. Reemplaza `tu-usuario-dockerhub` por tu nombre de usuario.

```bash
docker build -t tu-usuario-dockerhub/python-api:1.0 .
```

### 3. Ejecutar el Contenedor

Una vez construida la imagen, iníciala con el siguiente comando:

```bash
docker run --rm -p 5000:5000 tu-usuario-dockerhub/python-api:1.0
```

### 4. Acceder a la API

Con el contenedor en ejecución, abre tu navegador web o una herramienta como Postman y accede a:

`http://localhost:5000`

Deberías recibir una respuesta JSON como esta:

```json
{
  "message": "API de Python en Gunicorn funcionando desde un contenedor seguro!"
}
```

---

## 🐳 Imagen en Docker Hub

Una imagen pre-construida de este proyecto está disponible públicamente en Docker Hub. Puedes ejecutarla directamente sin necesidad de construirla:

```bash
docker run --rm -p 5000:5000 lonewolff1/python-api:1.0
```

---

## 📄 Explicación del `Dockerfile`

El `Dockerfile` está diseñado para ser seguro y eficiente. A continuación se detallan los comandos más importantes:

| Comando | Propósito |
| :--- | :--- |
| `ARG PYTHON_VERSION=3.9` | Hace que la versión de Python sea un argumento flexible durante la construcción. |
| `LABEL maintainer="..."` | Añade metadatos a la imagen para su documentación y organización. |
| `ENV PYTHONDONT...` | Variables de entorno para optimizar el funcionamiento de Python en Docker. |
| `WORKDIR /app` | Establece el directorio de trabajo principal dentro del contenedor. |
| `RUN groupadd ... && useradd ...` | **(Seguridad)** Crea un grupo y un usuario sin privilegios para ejecutar la aplicación. |
| `RUN chown -R appuser:appgroup /app` | **(Seguridad)** Asigna la propiedad de los archivos al nuevo usuario. |
| `USER appuser` | **(Seguridad)** Cambia al usuario sin privilegios. El contenedor ya no corre como `root`. |
| `ENTRYPOINT ["gunicorn", ...]` | **(Producción)** Inicia la aplicación usando el servidor Gunicorn, que es robusto y eficiente. |