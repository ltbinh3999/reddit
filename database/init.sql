CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE ROLE app_user WITH LOGIN ENCRYPTED PASSWORD 'app_user';

DROP TABLE IF EXISTS account;
CREATE TABLE account (
  id UUID default uuid_generate_v4() primary key,
  name text not null
);

INSERT INTO account(name)
VALUES 
  ('a1'),
  ('a2'),
  ('a3');

DROP TABLE IF EXISTS post;
CREATE TABLE post(
  id UUID default uuid_generate_v4() primary key,
  account_id UUID references account(id),
  content text,
  title text
);

INSERT INTO post(account_id,content,title)
VALUES 
  ((SELECT id FROM account WHERE name = 'a1'), 'content1', 'title1'),
  ((SELECT id FROM account WHERE name = 'a2'), 'content2', 'title2'),
  ((SELECT id FROM account WHERE name = 'a3'), 'content3', 'title3'),
  ((SELECT id FROM account WHERE name = 'a1'), 'content1', 'title1'),
  ((SELECT id FROM account WHERE name = 'a2'), 'content2', 'title2'),
  ((SELECT id FROM account WHERE name = 'a3'), 'content3', 'title3'),
  ((SELECT id FROM account WHERE name = 'a1'), 'content1', 'title1'),
  ((SELECT id FROM account WHERE name = 'a2'), 'content2', 'title2'),
  ((SELECT id FROM account WHERE name = 'a3'), 'content3', 'title3'),
  ((SELECT id FROM account WHERE name = 'a1'), 'content1', 'title1'),
  ((SELECT id FROM account WHERE name = 'a2'), 'content2', 'title2'),
  ((SELECT id FROM account WHERE name = 'a3'), 'content3', 'title3'),
  ((SELECT id FROM account WHERE name = 'a1'), 'content1', 'title1'),
  ((SELECT id FROM account WHERE name = 'a2'), 'content2', 'title2'),
  ((SELECT id FROM account WHERE name = 'a3'), 'content3', 'title3'),  
  ((SELECT id FROM account WHERE name = 'a3'), 'content', 'title3');


GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user;