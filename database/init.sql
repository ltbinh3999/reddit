CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE ROLE app WITH LOGIN ENCRYPTED PASSWORD 'app';

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id UUID default uuid_generate_v4() primary key,
  username text not null unique,
  password text not null,
  salt text not null unique
);


GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app;