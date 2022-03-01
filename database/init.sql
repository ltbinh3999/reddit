CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE ROLE app_user WITH LOGIN ENCRYPTED PASSWORD 'app_user';

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id UUID default uuid_generate_v4() primary key,
  username text not null unique,
  password text not null
);

INSERT INTO users(username,password)
VALUES 
  ('user1',crypt('password1', gen_salt('bf'))),
  ('user2',crypt('password2', gen_salt('bf'))),
  ('user3',crypt('password3', gen_salt('bf'))),
  ('user4',crypt('password1', gen_salt('bf')));

DROP TABLE IF EXISTS posts;
CREATE TABLE posts(
  id UUID default uuid_generate_v4() primary key,
  user_id UUID not null references users(id),
  content text,
  title text
);

INSERT INTO posts(user_id,content,title)
VALUES 
  ((SELECT id FROM users WHERE username = 'user1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'user2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'user3'), 'content3', 'title3'),
  ((SELECT id FROM users WHERE username = 'user1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'user2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'user3'), 'content3', 'title3'),
  ((SELECT id FROM users WHERE username = 'user1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'user2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'user3'), 'content3', 'title3'),
  ((SELECT id FROM users WHERE username = 'user1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'user2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'user3'), 'content3', 'title3'),
  ((SELECT id FROM users WHERE username = 'user1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'user2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'user3'), 'content3', 'title3'),  
  ((SELECT id FROM users WHERE username = 'user3'), 'content', 'title3');


GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user;