# Proyecto panaderia - Ingeniería Web Y Aplicaciones Móviles

Sistema de e-commerce desarrollado con Spring Boot 3.4.2, siguiendo principios DDD y Arquitectura Hexagonal.

## Requisitos

- Java 17
- Maven 3.6+
- MySQL 8.0 o PostgreSQL 13+

## Proceso de ejecución

### 1. Clonar el repositorio

Clonar este repositorio en la computadora.

Se recomienda utilizar **GitHub Desktop** por su facilidad de uso:

https://github.com/apps/desktop

### 2. Instalar Java 21

Verificar si Java está instalado ejecutando:

```bash
java -version
```

En caso de no tener Java instalado, instalar **OpenJDK 21** desde CMD o PowerShell con el siguiente comando:

```bash
winget install Microsoft.OpenJDK.21
```

Después de la instalación, cerrar y volver a abrir la terminal y verificar nuevamente:

```bash
java -version
```

### 3. Crear la base de datos y cargar los datos de prueba

Ejecutar el siguiente archivo:

```text
panaderia-hexagonal-architecture-java-spring-boot\AGREGAR BASE DE DATOS\cargar_BD_mas_datos.bat
```

Este archivo se encargará de crear la base de datos y cargar los datos necesarios para realizar pruebas.

### 4. Abrir el proyecto en Visual Studio Code

Abrir la carpeta del proyecto utilizando **Visual Studio Code**.

Puede descargarse desde:

https://code.visualstudio.com

### 5. Compilar el proyecto y descargar las dependencias

Abrir una terminal dentro de Visual Studio Code, ubicada en la carpeta raíz del proyecto, y ejecutar:

```bash
.\mvnw.cmd clean compile
```

Este comando utilizará **Maven Wrapper** para descargar las dependencias necesarias y compilar el proyecto.

> No es necesario instalar Maven manualmente, ya que el proyecto incluye Maven Wrapper.

### 6. Iniciar la aplicación

Ejecutar:

```bash
.\mvnw.cmd spring-boot:run
```

Una vez iniciado correctamente Spring Boot, la aplicación estará lista para utilizarse.

## Cuentas de usuario para pruebas

| Rol     | Correo                    | Contraseña    |
| ------- | ------------------------- | ------------- |
| ADMIN   | admin@panaderiabarrios.pe | `Admin123*`   |
| CLIENTE | ana.mamani@gmail.com      | `Cliente123*` |
| CLIENTE | luis.condori@gmail.com    | `Cliente123*` |
| CLIENTE | carla.flores@gmail.com    | `Cliente123*` |

## Pruebas

```bash
mvn test
```

Cobertura: `mvn jacoco:report`

## Arquitectura

- **Domain**: Entidades, Value Objects, Repositorios (interfaces)
- **Application**: Servicios de aplicación
- **Infrastructure**: Adaptadores (JPA, Web, Security)

## Tecnologías

- Spring Boot 3.4.2
- Spring Security
- Spring Data JPA
- Thymeleaf + Bootstrap 5
- JaCoCo para cobertura
- Cucumber para BDD

## Registro de Ítems de Configuración (IC) — Línea Base v1.1.0

Este registro incluye **19 ítems de configuración** distribuidos en todas las categorías críticas. Cada IC tiene asignado un **responsable nominal**, un **rol estandarizado** y una **criticidad** basada en impacto operativo.

**CAMBIO RECIENTE (2026-06-19)**: PostgreSQL eliminado por no ser utilizado en producción (reduce superficie de ataque).

### Tabla Resumida de ICs

| ID-IC | Categoría       | Nombre                              | Responsable         | Rol                | Criticidad |
| ----- | --------------- | ----------------------------------- | ------------------- | ------------------ | ---------- |
| IC-01 | Código          | pom.xml                             | Guillermo Mogrovejo | Backend Lead       | Alta       |
| IC-02 | Código          | EcommerceApplication                | Kevin Calle         | Backend Developer  | Alta       |
| IC-03 | Código          | SecurityConfig                      | Noemi Chura         | Security Engineer  | Alta       |
| IC-04 | Código          | LoginController                     | Alberto Barrios     | Backend Developer  | Media      |
| IC-05 | Código          | ProductoAdminController             | Alberto Barrios     | Backend Developer  | Media      |
| IC-06 | Infraestructura | mvnw                                | Guillermo Mogrovejo | DevOps             | Alta       |
| IC-07 | Infraestructura | mvnw.cmd                            | Kevin Calle         | DevOps             | Alta       |
| IC-08 | Infraestructura | maven-wrapper.properties            | Guillermo Mogrovejo | DevOps             | Alta       |
| IC-09 | Infraestructura | panaderiaDB.sql                     | Alberto Barrios     | Data Engineer      | Media      |
| IC-10 | Configuración   | application.properties              | Katherin Quispe     | DevOps             | Alta       |
| IC-11 | Configuración   | application-dev-mysql.properties    | Guillermo Mogrovejo | DevOps             | Alta       |
| IC-12 | Configuración   | schema.sql                          | Alberto Barrios     | Data Engineer      | Media      |
| IC-13 | Documentación   | README.md                           | Lizeth Hancco       | Architect          | Baja       |
| IC-14 | Documentación   | TABLA_VINCULACION_ARQUITECTONICA.md | Leticia Calderón    | Architect          | Baja       |
| IC-15 | Configuración   | data.sql                            | Katherin Quispe     | Data Engineer      | Media      |
| IC-16 | Código          | ProductoService                     | Kevin Calle         | Backend Developer  | Media      |
| IC-17 | Código          | ClienteService                      | Noemi Chura         | Backend Developer  | Media      |
| IC-18 | Código          | AdminController                     | Leticia Calderón    | Backend Developer  | Media      |
| IC-19 | Infraestructura | carrito.js                          | Katherin Quispe     | Frontend Developer | Baja       |

### Criterios de Criticidad Aplicados

- **Alta**: Bloquea compilación o despliegue en < 30 minutos
- **Media**: Afecta flujos entre 30 minutos y 4 horas
- **Baja**: Impacto > 4 horas o documental

### Notas

- Cada IC tiene un **responsable nominal** único (no "el grupo"), facilitando trazabilidad operativa
- Se asignaron **roles estandarizados**: Backend Lead, Backend Developer, DevOps, Data Engineer, Security Engineer, Architect, Frontend Developer
- Para el informe formal completo, consultar [Registro_ICs_Baseline_v0.md](Registro_ICs_Baseline_v0.md)
- Deudas técnicas del SCM registradas en [SCM-DEUDA.md](SCM-DEUDA.md)
- Recomendaciones de seguridad en [SECURITY.md](SECURITY.md)

---

## 📚 Documentación de Apoyo

| Documento                                                  | Propósito                                                |
| ---------------------------------------------------------- | -------------------------------------------------------- |
| [**SECURITY.md**](SECURITY.md)                             | Recomendaciones de seguridad y checklist pre-producción  |
| [**SECURITY-SUMMARY.md**](SECURITY-SUMMARY.md)             | Resumen ejecutivo de cambios de seguridad                |
| [**STRUCTURE-OPTIMIZATION.md**](STRUCTURE-OPTIMIZATION.md) | Guía de estructura optimizada y limpieza del repositorio |
| [**SCM-DEUDA.md**](SCM-DEUDA.md)                           | Deudas técnicas con fechas objetivo                      |
| [**CHANGELOG-SECURITY.md**](CHANGELOG-SECURITY.md)         | Histórico detallado de cambios de seguridad              |

---

## 🔧 Configuración Inicial para Desarrolladores

**Después de clonar el repositorio**:

```bash
# 1. Instalar dependencias y compilar
mvn clean compile

# 2. Configurar variables de entorno (ver .env.example)
export DB_USER=root
export DB_PASSWORD=tu_contraseña_segura

# 3. Ejecutar tests
mvn test

# 4. Iniciar la aplicación
mvn spring-boot:run
```

Para más detalles sobre estructura y limpieza, ver [STRUCTURE-OPTIMIZATION.md](STRUCTURE-OPTIMIZATION.md)
