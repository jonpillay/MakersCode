# Two Table Design Recipe Template (blog)

_Copy this recipe template to design and create a database table from a specification._

## 1. Extract nouns from the user stories or specification

```
As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```

```
Nouns:

blog_post, blog_title, blog_content, comment, comment_content, comment_creator 
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| blog_post                 | blog_title, blog_content

| Record                | Properties          |
| --------------------- | ------------------  |
| comment                 | comment_content, comment_creator

Name of the tables (always plural): `blog_posts`

Column names: `blog_title', 'blog_content`

Name of the tables (always plural): `comments`

Column names: `comment_content, 'comment_creator`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

id: SERIAL
title: text
release_year: int
```

## 4. Write the SQL.

```sql

CREATE TABLE blogs (
  id SERIAL PRIMARY KEY,
  blog_title text,
  blog_content text
);

CREATE TABLE comments (
	primary_id SERIAL PRIMARY KEY,
	content text,
    comment_creator text,
	blog_parent int,
	CONSTRAINT fk_blog_id FOREIGN KEY (blog_parent) REFERENCES blogs (blog_id)
);
```

## 5. Create the table.

```zsh
psql -h 127.0.0.1 database_name < albums_table.sql
```