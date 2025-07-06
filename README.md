# Cash Register App 🛍️

A modern point-of-sale system built with Rails 7 API and React+TypeScript frontend. This application handles product management and cart operations with real-time pricing calculations.

## Features

- Product management (CRUD operations)
- Shopping cart functionality
- Real-time price calculations
- Modern React frontend with TypeScript
- RESTful Rails API
- Automated testing suite

## Tech Stack

**Backend:**
- Ruby on Rails 7 (API mode)
- PostgreSQL
- RSpec for testing

**Frontend:**
- React with TypeScript
- Vite
- TailwindCSS
- ESLint

## Getting Started

### Prerequisites

- Ruby (check `.ruby-version` for exact version)
- Node.js & npm
- PostgreSQL
- Docker (optional)

### Local Development Setup

1. Clone the repository:
   ```bash
   git clone [your-repo-url]
   cd cashreg
   ```

2. Install backend dependencies:
   ```bash
   bundle install
   ```

3. Setup database:
   ```bash
   bin/rails db:create db:migrate db:seed
   ```

4. Install frontend dependencies:
   ```bash
   cd client
   npm install
   ```

5. Start the development servers:

   Backend (in project root):
   ```bash
   bin/rails server
   ```

   Frontend (in client directory):
   ```bash
   npm run dev
   ```

### Docker Setup

The application can also be run using Docker:

```bash
docker compose up
```

## Testing

Run backend tests:
```bash
bundle exec rspec
```

Run frontend tests:
```bash
cd client
npm test
```

## API Documentation

The API endpoints are versioned (v1) and include:

- Products API (`/api/v1/products`)
- Carts API (`/api/v1/carts`)

For detailed API documentation, check the request specs in `spec/requests/api/v1/`.

## Deployment

This project uses Kamal for deployment. Deployment configuration can be found in `config/deploy.yml`.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.
