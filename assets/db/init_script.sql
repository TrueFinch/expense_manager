CREATE TABLE "Expenses" (
	"id"	INTEGER NOT NULL,
	"cost"	INTEGER NOT NULL,
	"dateTime"	TEXT NOT NULL,
	"desc"	TEXT,
	"name"	TEXT,
	"tag"	INTEGER DEFAULT 0,
	"owner"	INTEGER DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("owner") REFERENCES "owners"("id") ON UPDATE SET DEFAULT ON DELETE SET DEFAULT,
	FOREIGN KEY("tag") REFERENCES "tags"("id") ON UPDATE SET DEFAULT ON DELETE SET DEFAULT
);

CREATE TABLE "Owners" (
	"id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

INSERT INTO "Owners" ("id", "name")
VALUES (0, "no_name");

CREATE TABLE "Tags" (
	"id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

INSERT INTO "Tags" ("id", "name")
VALUES (0, "");