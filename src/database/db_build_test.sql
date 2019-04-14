BEGIN;

DROP TABLE IF EXISTS posts, post_categories, comments, main_images, users CASCADE;

CREATE TABLE posts (
  post_id SERIAL PRIMARY KEY,
  pub_timestamp INTEGER NOT NULL,
  pub_date VARCHAR(100) NOT NULL,
  category_id INTEGER NOT NULL,
  title VARCHAR(100) NOT NULL,
  subtitle VARCHAR(500) NOT NULL,
  reading_mins INT NOT NULL,
  main_image_id INTEGER NOT NULL,
  main_image_caption VARCHAR(100) NOT NULL,
  main_image_alt_text VARCHAR(500) NOT NULL,
  filename VARCHAR(500) NOT NULL,
  user_id INTEGER NOT NULL,
  CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES post_categories (category_id),
  CONSTRAINT main_image_id FOREIGN KEY (main_image_id) REFERENCES main_images (main_image_id),
  CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE post_categories (
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  post_id INTEGER NOT NULL,
  CONSTRAINT post_id FOREIGN KEY (post_id) REFERENCES posts (post_id)
);

CREATE TABLE comments (
  comment_id SERIAL PRIMARY KEY,
  body VARCHAR(10000) NOT NULL,
  post_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  CONSTRAINT post_id FOREIGN KEY (post_id) REFERENCES posts (post_id),
  CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE main_images (
  image_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  size INTEGER NOT NULL,
  width_px INTEGER NOT NULL,
  height_px INTEGER NOT NULL,
  filepath VARCHAR(200) NOT NULL,
  type VARCHAR(100) NOT NULL
);

CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(200) NOT NULL,
  role VARCHAR(100) NOT NULL
);

INSERT INTO posts (pub_timestamp, pub_date, category_id, title, subtitle, reading_mins, main_image_id, main_image_caption, main_image_alt_text, filename, user_id)
VALUES (12345, '12 March 2019', 'Interview', 'The first database test blog post', 'Will it work?', 4, 1, 'The main image', 'Main image alt text', 'image.jpeg', 1);

COMMIT;
