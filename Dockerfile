# Usa un ARG para la versión de Python
ARG PYTHON_VERSION=3.9
FROM python:${PYTHON_VERSION}-slim

# Añade etiquetas de metadatos a la imagen
LABEL maintainer="luis.sanmartin.wlf@gmail.com" \
      version="1.0" \
      description="API de demo en Flask para la actividad de contenedores."

# Establece variables de entorno para optimización y logs
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Establece el directorio de trabajo
WORKDIR /app

# Copia e instala las dependenciass
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Crea un usuario no-root (solo privilegios necesarios) para correr la aplicación
#RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN groupadd --system appgroup && useradd --system --gid appgroup appuser

# Copia el código de la aplicación y cambia el propietario
COPY app.py .
RUN chown -R appuser:appgroup /app

# Cambia al usuario no-root para mayor seguridad
USER appuser

# Expone el puerto 5000
EXPOSE 5000

# Usa Gunicorn como ENTRYPOINT para correr la aplicación Flask
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]