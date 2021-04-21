CREATE TABLE "Expenses" (
	"id"	    INTEGER NOT NULL,
	"cost"	    REAL NOT NULL,
	"dateTime"	TEXT NOT NULL,
	"desc"	    TEXT,
	"name"	    TEXT,
	"owner"	    INTEGER DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("owner") REFERENCES "owners"("id") ON UPDATE SET DEFAULT ON DELETE SET DEFAULT
);

CREATE TABLE "Owners" (
	"id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

INSERT INTO "Owners" ("id", "name")
VALUES (0, 'no_name');

CREATE TABLE "Tags" (
	"id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE "ExpenseToTag" (
	"expenseID"	INTEGER NOT NULL,
	"tagID"	INTEGER NOT NULL,
	PRIMARY KEY("expenseID", "tagID"),
	UNIQUE("expenseID", "tagID")
);

INSERT INTO "Tags" ("id", "name")
VALUES (0, '');