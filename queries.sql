DELETE FROM users;
DELETE FROM tasks;
DELETE FROM news_articles;
DELETE FROM events;
DELETE FROM messages;
DELETE FROM friends;

-- Make sure the CASCADE works
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS news_articles;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS friends;

CREATE TABLE 'users'(
    'UserId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Email' TEXT NOT NULL,
    'Password' TEXT NOT NULL,
    'DisplayName' TEXT NOT NULL
);

INSERT INTO users VALUES (null, 'kmorin06@gmail.com', '1234', 'KMorin');
INSERT INTO users VALUES (null, 'scivarolo@gmail.com', '1234', 'Sebastian');
INSERT INTO users VALUES (null, 'austin@gmail.com', '1234', 'Austin');
INSERT INTO users VALUES (null, 'braddavistech@gmail.com', '1234', 'BDTech');

CREATE TABLE 'tasks'(
    'TaskId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'DueBy' TEXT NOT NULL,
    'Name' TEXT NOT NULL,
    'Status' TEXT NOT NULL,
    'UserId' INTEGER NOT NULL,
    FOREIGN KEY('UserId')
    REFERENCES 'users'('UserId')
    ON DELETE CASCADE
);

INSERT INTO tasks
SELECT null, 'Today', 'Break all of the things', 'In Process', UserId
FROM users
WHERE users.DisplayName = 'KMorin';

INSERT INTO tasks
SELECT null, 'Today', 'Take lots of notes', 'In Process', UserId
FROM users
WHERE users.DisplayName = 'Austin';

INSERT INTO tasks
SELECT null, 'Today', 'Do something really complicated', 'In Process', UserId
FROM users
WHERE users.DisplayName = 'BDTech';

INSERT INTO tasks
SELECT null, 'Today', 'Make Friends', 'In Process', UserId
FROM users
WHERE users.DisplayName = 'BDTech';

CREATE TABLE 'news_articles'(
    'NewsId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Title' TEXT NOT NULL,
    'Summary' TEXT NOT NULL,
    'Timestamp' TEXT NOT NULL,
    'URL' TEXT NOT NULL,
    'UserId' INTEGER NOT NULL,
    FOREIGN KEY('UserId')
    REFERENCES 'users'('UserId')
    ON DELETE CASCADE
);

INSERT INTO news_articles
SELECT null, 'Title', 'Summary', 'SomeTime', 'www.something.com', UserId
FROM users
WHERE users.DisplayName = 'BDTech';

INSERT INTO news_articles
SELECT null, 'Title', 'Summary', 'SomeTime', 'www.something.com', UserId
FROM users
WHERE users.DisplayName = 'Sebastian';

INSERT INTO news_articles
SELECT null, 'Title', 'Summary', 'SomeTime', 'www.something.com', UserId
FROM users
WHERE users.DisplayName = 'KMorin';

CREATE TABLE 'events'(
    'EventId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Name' TEXT NOT NULL,
    'Location' TEXT NOT NULL,
    'Date' TEXT NOT NULL,
    'UserId' INTEGER NOT NULL,
    FOREIGN KEY('UserId')
    REFERENCES 'users'('UserId')
    ON DELETE CASCADE
);

INSERT INTO events
SELECT null, 'Name', 'Location', 'SomeDay', UserId
FROM users
WHERE users.DisplayName = 'KMorin';

INSERT INTO events
SELECT null, 'Name', 'Location', 'SomeDay', UserId
FROM users
WHERE users.DisplayName = 'Austin';

INSERT INTO events
SELECT null, 'Name', 'Location', 'SomeDay', UserId
FROM users
WHERE users.DisplayName = 'Sebastian';

CREATE TABLE 'messages'(
    'MessageId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'Text' TEXT NOT NULL,
    'IsEdited' BOOLEAN NOT NULL,
    'UserId' INTEGER NOT NULL,
    FOREIGN KEY('UserId')
    REFERENCES 'users'('UserId')
    ON DELETE CASCADE
);

INSERT INTO messages
SELECT null, 'Text', 0, UserId
FROM users
WHERE users.DisplayName = 'KMorin';

INSERT INTO messages
SELECT null, 'Text', 1, UserId
FROM users
WHERE users.DisplayName = 'Sebastian';

INSERT INTO messages
SELECT null, 'Text', 0, UserId
FROM users
WHERE users.DisplayName = 'BDTech';

CREATE TABLE 'friends'(
    'RelationshipId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'UserId' INTEGER NOT NULL,
    'FriendId' INTEGER NOT NULL,
    FOREIGN KEY('UserId') REFERENCES 'users'('UserId') ON DELETE CASCADE,
    FOREIGN KEY('FriendId') REFERENCES 'users'('UserId') ON DELETE CASCADE
);

INSERT INTO friends
VALUES(
    null,
    (
        SELECT UserId
        FROM users
        WHERE users.DisplayName = 'BDTech'
    ),
    (
        SELECT UserId as FriendId
        FROM users
        WHERE users.DisplayName = 'Sebastian'
    )
);
INSERT INTO friends
VALUES(
    null,
    (
        SELECT UserId
        FROM users
        WHERE users.DisplayName = 'KMorin'
    ),
    (
        SELECT UserId as FriendId
        FROM users
        WHERE users.DisplayName = 'Sebastian'
    )
);