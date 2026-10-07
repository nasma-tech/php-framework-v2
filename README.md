<div align="center">

# ⚡ Nasma PHP Framework V2

### A modular PHP application foundation built for real-world business systems.

[![PHP](https://img.shields.io/badge/PHP-8.4-777BB4?logo=php&logoColor=white)](https://www.php.net/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![MySQL](https://img.shields.io/badge/MySQL-8.4-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![MongoDB](https://img.shields.io/badge/MongoDB-8-47A248?logo=mongodb&logoColor=white)](https://www.mongodb.com/)
[![Composer](https://img.shields.io/badge/Composer-2-885630?logo=composer&logoColor=white)](https://getcomposer.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**Nasma PHP Framework V2** is a custom PHP application framework designed around a practical MVC-style architecture, reusable internal packages, Eloquent ORM, Smarty templates, Dockerized development and support for both relational and document databases.

Built by **Nasma Tech** for developing maintainable business applications without the overhead of a full-stack framework.

[Features](#-features) •
[Architecture](#-architecture) •
[Installation](#-installation) •
[Project Structure](#-project-structure) •
[Development](#-development)

</div>

---

## ✨ Features

The framework provides a collection of components commonly required by internal systems, ERP applications, dashboards and administration platforms.

### Core

- MVC-style application architecture
- PSR-4 autoloading through Composer
- Modular internal package structure
- Environment configuration with `phpdotenv`
- Routing powered by `bramus/router`
- Central application bootstrap
- Session-based authentication flow
- Dynamic controller routing
- AJAX-aware error handling
- Custom 404 and access-denied handling
- Developer-friendly error pages using Whoops

### Database

- MySQL support
- MongoDB support
- Eloquent ORM outside Laravel
- Illuminate pagination
- PDO support
- Database initialization through Docker

### UI & Rendering

- Smarty template engine
- Reusable application layouts
- Dashboard-oriented view structure
- TinyMCE integration
- Dropzone file uploads
- PDF generation using mPDF
- Spreadsheet handling with PhpSpreadsheet
- Image processing with Imagick

### Application Services

- Validation layer
- CSRF protection
- Permission helpers
- File helpers
- User helpers
- Mail services
- Queue-oriented email processing
- HTTP utilities
- Reusable enums and support classes
- Cartable/workflow components

### Integrations

The project already includes dependencies for several integration scenarios:

- PHPMailer
- WebSocket clients
- Ratchet
- Workerman / Socket.IO
- PAMI for Asterisk AMI
- Kavenegar
- Melipayamak
- HTTP clients
- ZIP streaming
- Persian date utilities

---

## 🧠 Philosophy

Nasma PHP Framework is intentionally different from large general-purpose frameworks.

The goal is to keep application behavior explicit while still providing reusable infrastructure for common enterprise requirements.

```text
Simple enough to understand.
Structured enough to scale.
Flexible enough to integrate.
```

Instead of hiding application behavior behind a large framework lifecycle, the project keeps routing, controllers, services, models and internal packages accessible and easy to customize.

---

## 🏗 Architecture

The application roughly follows this request lifecycle:

```text
                  ┌─────────────────┐
                  │     Browser     │
                  └────────┬────────┘
                           │
                           ▼
                  ┌─────────────────┐
                  │      Nginx      │
                  └────────┬────────┘
                           │
                           ▼
                    ┌────────────┐
                    │ index.php  │
                    └─────┬──────┘
                          │
                          ▼
                ┌───────────────────┐
                │ application/app.php│
                └─────────┬─────────┘
                          │
          ┌───────────────┼────────────────┐
          │               │                │
          ▼               ▼                ▼
     Environment       Database         Bootstrap
      (.env)           Eloquent         Packages
          │               │                │
          └───────────────┼────────────────┘
                          │
                          ▼
                     ┌─────────┐
                     │ Router  │
                     └────┬────┘
                          │
                          ▼
                    ┌────────────┐
                    │ Controller │
                    └──────┬─────┘
                           │
                   ┌───────┴────────┐
                   │                │
                   ▼                ▼
                Models           Services
                   │                │
                   └───────┬────────┘
                           │
                           ▼
                    ┌────────────┐
                    │   Smarty   │
                    │   Views    │
                    └────────────┘
```

---

## 📁 Project Structure

```text
php-framework-v2/
│
├── application/
│   ├── Controllers/        # HTTP/application controllers
│   ├── Models/             # Application models
│   ├── Services/           # Application-level services
│   ├── core/
│   │   ├── route.php       # Web routes
│   │   └── API.php         # API routes
│   └── app.php             # Application bootstrap
│
├── packages/
│   ├── Cartable/           # Workflow/cartable components
│   ├── Database/           # Database abstraction and Eloquent
│   ├── Enums/              # Application enums
│   ├── Functions/          # Shared functions
│   ├── Helpers/            # Shared helpers
│   ├── Http/               # HTTP utilities
│   ├── MailService/        # Mail infrastructure
│   ├── Security/           # Security / CSRF components
│   ├── Services/           # Reusable services
│   ├── Support/            # Supporting utilities
│   ├── Validation/         # Validation layer
│   ├── View/               # View abstraction
│   ├── bootstrap/          # Shared bootstrap definitions
│   └── Starter.php         # Package bootstrap
│
├── view/                   # Smarty templates
├── public/                 # Public frontend assets
├── Storage/                # Runtime/application storage
├── worker/                 # Background workers
├── cron/                   # Scheduled jobs
├── database/               # Database initialization
│
├── docker/
│   ├── nginx/
│   ├── php/
│   └── mongodb/
│
├── compiled/               # Compiled template/runtime files
│
├── docker-compose.yml
├── composer.json
├── index.php
└── LICENSE
```

---

## 🚀 Installation

### Requirements

For the recommended Docker setup:

- Docker
- Docker Compose
- Git

For a manual installation:

- PHP **8.4**
- Composer 2
- MySQL
- MongoDB
- PDO
- cURL
- OpenSSL
- Imagick
- MongoDB PHP extension

Additional extensions may be required depending on the features being used.

---

## 🐳 Docker Installation

Clone the repository:

```bash
git clone https://github.com/nasma-tech/php-framework-v2.git
cd php-framework-v2
```

The main development branch is currently:

```text
develop
```

Install Composer dependencies if necessary:

```bash
composer install
```

Create your environment configuration:

```bash
touch .env
```

Example database configuration:

```env
DB_CONNECTION=mysql
DB_HOST=mysql
DB_DATABASE=erp
DB_USERNAME=root
DB_PASSWORD=root

DB_CHARSET=utf8mb4
DB_COLLATION=utf8mb4_unicode_ci
DB_PREFIX=
```

Then start the environment:

```bash
docker compose up -d --build
```

The Docker environment contains:

| Service | Container | Default Port |
|---|---|---:|
| Nginx | `php-framework-v2-nginx` | `80` |
| PHP-FPM | `php-framework-v2-php` | Internal |
| MySQL 8.4 | `php-framework-v2-mysql` | `3306` |
| MongoDB 8 | `php-framework-v2-mongodb` | `27017` |

Once the containers are running, open:

```text
http://localhost
```

---

## 🐘 PHP Container

To enter the PHP container:

```bash
docker exec -it php-framework-v2-php bash
```

Composer commands can then be executed normally:

```bash
composer install
```

or:

```bash
composer dump-autoload
```

---

## 🗄 Database Layer

Nasma PHP Framework uses selected Illuminate components to provide **Eloquent ORM without requiring Laravel**.

Example model:

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    protected $table = 'users';

    protected $fillable = [
        'name',
        'email',
    ];
}
```

Then:

```php
$user = User::find(1);
```

Or:

```php
$users = User::query()
    ->where('status', 'active')
    ->paginate(20);
```

Database configuration is loaded from environment variables.

```env
DB_CONNECTION=mysql
DB_HOST=mysql
DB_DATABASE=erp
DB_USERNAME=root
DB_PASSWORD=root
```

---

## 🧭 Routing

Routing is powered by `bramus/router`.

Routes are defined primarily inside:

```text
application/core/route.php
```

and API routes can be organized inside:

```text
application/core/API.php
```

Basic example:

```php
$router->get('/hello', function () {
    echo 'Hello from Nasma Framework';
});
```

Controller-based route:

```php
$router->get('/users', function () {
    $controller = new UsersController();
    $controller->index();
});
```

The framework also contains a dynamic routing mechanism that can map controller actions automatically.

Example structure:

```php
$router->mount('/users', function () use ($router) {
    dynamicRoute($router, Users::class);
});
```

Additional custom actions can also be registered:

```php
$router->mount('/users', function () use ($router) {
    dynamicRoute($router, Users::class, [
        [
            'method' => 'GET',
            'path' => '/getUsersForm',
            'action' => 'getUsersForm',
        ],
    ]);
});
```

---

## 🎨 Views

Views are rendered using **Smarty 4**.

Templates are stored inside:

```text
view/
```

Example:

```text
view/
├── dashboard/
├── users/
├── roles/
├── countries/
├── states/
├── cities/
└── sections/
```

A view can be rendered through the framework's shared view abstraction:

```php
view
    ->ui()
    ->display('dashboard/dashboard.tpl');
```

Data can also be passed to templates through the view layer.

---

## 📦 Internal Packages

One of the core ideas behind the project is keeping reusable application infrastructure outside individual controllers.

Reusable components live under:

```text
packages/
```

Composer maps this directory to:

```php
Packages\
```

while application code uses:

```php
App\
```

The corresponding Composer configuration is conceptually:

```json
{
    "autoload": {
        "psr-4": {
            "App\\": "application/",
            "Packages\\": "packages/"
        }
    }
}
```

This allows components to remain independent from specific application modules.

For example:

```php
use Packages\Validation\Validator;
use Packages\Security\Csrf;
use Packages\Helpers\FileHelper;
```

---

## 🔐 Security

The framework contains infrastructure for:

- CSRF protection
- Session authentication
- Permission checking
- Protected routes
- AJAX-aware unauthorized responses
- Environment variable protection inside Whoops
- Access-denied views

Protected routes are checked before the request reaches application controllers.

Unauthenticated browser requests are redirected to:

```text
/login
```

while AJAX requests can receive a JSON unauthorized response.

---

## 📧 Background Workers

Background processes are separated from normal HTTP requests.

Worker scripts live inside:

```text
worker/
```

For example:

```text
worker/SendEmails.php
```

This design allows time-consuming processes such as queue-based mail delivery to run separately from user requests.

A worker can be executed from the PHP container:

```bash
php worker/SendEmails.php
```

For production deployments, workers should generally be managed by a process supervisor such as:

- Supervisor
- systemd
- Docker services

---

## ⏱ Cron Jobs

Scheduled jobs can be organized under:

```text
cron/
```

This keeps scheduled application behavior separate from HTTP endpoints and background queue workers.

---

## 📨 Mail Infrastructure

Mail functionality is built around PHPMailer and the framework's own mail service layer.

Relevant components are located under:

```text
packages/MailService/
```

The project also contains infrastructure for queue-based mail processing and supports separating mail creation from actual message delivery.

---

## 🔌 Real-Time & External Integrations

The dependency stack provides building blocks for real-time communication and external systems.

### WebSocket / Real-Time

Available packages include:

```text
cboden/ratchet
workerman/phpsocket.io
textalk/websocket
```

These can be used for features such as:

- notifications
- chat
- real-time dashboard updates
- worker communication

### Telephony

```text
marcelog/pami
```

provides support for integration with **Asterisk Manager Interface (AMI)**.

### SMS

The project includes clients for:

```text
Kavenegar
Melipayamak
```

allowing SMS providers to be integrated through application services.

---

## 📄 Documents & Files

The framework already includes libraries for common business-document requirements.

### PDF

```text
mpdf/mpdf
```

### Excel / Spreadsheet

```text
phpoffice/phpspreadsheet
```

### Image Processing

```text
ext-imagick
```

### ZIP Streaming

```text
maennchen/zipstream-php
```

This makes the framework suitable for reporting-heavy business applications.

---

## 🧰 Development Commands

Start containers:

```bash
docker compose up -d
```

Rebuild containers:

```bash
docker compose up -d --build
```

Stop containers:

```bash
docker compose down
```

View running services:

```bash
docker compose ps
```

View PHP logs:

```bash
docker logs -f php-framework-v2-php
```

View Nginx logs:

```bash
docker logs -f php-framework-v2-nginx
```

Enter PHP container:

```bash
docker exec -it php-framework-v2-php bash
```

Regenerate Composer autoload files:

```bash
composer dump-autoload
```

---

## 🌿 Git Workflow

The repository currently uses:

```text
develop
```

as its default development branch.

A typical workflow could be:

```bash
git checkout develop
git pull

git checkout -b feature/my-feature
```

After development:

```bash
git add .
git commit -m "feat: add my feature"
git push origin feature/my-feature
```

Then open a pull request against `develop`.

---

## 🧩 Technology Stack

| Category | Technology |
|---|---|
| Language | PHP 8.4 |
| Web Server | Nginx |
| Runtime | PHP-FPM |
| Package Manager | Composer |
| Routing | Bramus Router |
| ORM | Illuminate Database / Eloquent |
| Pagination | Illuminate Pagination |
| Template Engine | Smarty |
| Relational Database | MySQL 8.4 |
| Document Database | MongoDB 8 |
| Environment | PHP dotenv |
| Error Handling | Whoops |
| Email | PHPMailer |
| PDF | mPDF |
| Spreadsheet | PhpSpreadsheet |
| Real-Time | Ratchet / Workerman / WebSocket |
| Image Processing | Imagick |
| Containers | Docker / Docker Compose |

---

## 🗺 Roadmap

The project is actively evolving.

Potential areas for future development include:

- [ ] Improved API architecture
- [ ] CLI tooling
- [ ] Database migration system
- [ ] Automated testing infrastructure
- [ ] Dependency injection container
- [ ] Improved middleware architecture
- [ ] Standardized service contracts
- [ ] Queue worker management
- [ ] First-class WebSocket service
- [ ] Framework documentation
- [ ] Example application / starter project
- [ ] CI/CD automation

---

## 🤝 Contributing

Contributions, improvements and architectural discussions are welcome.

Recommended workflow:

1. Fork or create a feature branch
2. Branch from `develop`
3. Keep changes focused
4. Follow the existing project structure
5. Test your changes
6. Open a pull request

Example:

```bash
git checkout develop
git checkout -b feature/new-feature
```

---

## ⚠️ Project Status

This project is under active development.

APIs, internal packages and architectural conventions may change while the framework continues to evolve.

For production usage, review the implementation and configuration according to your application's requirements.

---

## 📜 License

This project is released under the **MIT License**.

See [LICENSE](LICENSE) for details.

```text
Copyright © 2026 Nasma Tech
```

---

<div align="center">

### Built with PHP ☕ by Nasma Tech

**Lightweight architecture. Practical components. Built for real applications.**

[Back to top](#-nasma-php-framework-v2)

</div>