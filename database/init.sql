CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE ROLE app_user WITH LOGIN ENCRYPTED hpass 'app_user';

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id UUID default uuid_generate_v4() primary key,
  username text not null unique,
  password text not null,
  salt text not null
);

DROP TABLE IF EXISTS posts;
CREATE TABLE posts(
  id UUID default uuid_generate_v4() primary key,
  users_id UUID not null references users(id),
  content text,
  title text
);



INSERT INTO users(username,hpass)
VALUES 
  ('u1',crypt('1', gen_salt('bf'))),
  ('u2',crypt('2', gen_salt('bf'))),
  ('u3',crypt('3', gen_salt('bf'))),
  ('u4',crypt('1', gen_salt('bf')));


INSERT INTO posts(user_id,content,title)
VALUES 
  ((SELECT id FROM users WHERE username = 'u1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'u2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'u3'), 'content3', 'title3'),
  ((SELECT id FROM users WHERE username = 'u1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'u2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'u3'), 'content3', 'title3'),
  ((SELECT id FROM users WHERE username = 'u1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'u2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'u3'), 'content3', 'title3'),
  ((SELECT id FROM users WHERE username = 'u1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'u2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'u3'), 'content3', 'title3'),
  ((SELECT id FROM users WHERE username = 'u1'), 'content1', 'title1'),
  ((SELECT id FROM users WHERE username = 'u2'), 'content2', 'title2'),
  ((SELECT id FROM users WHERE username = 'u3'), 'content3', 'title3'),  
  ((SELECT id FROM users WHERE username = 'u3'), 'content', 'title3');


GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user;