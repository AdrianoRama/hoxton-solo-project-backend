/*
  Warnings:

  - Added the required column `userId` to the `Song` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Song" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "clientName" TEXT NOT NULL,
    "songTitle" TEXT NOT NULL,
    "artist" TEXT NOT NULL,
    "songUrl" TEXT NOT NULL,
    "votes" INTEGER NOT NULL
);
INSERT INTO "new_Song" ("artist", "clientName", "id", "songTitle", "songUrl", "votes") SELECT "artist", "clientName", "id", "songTitle", "songUrl", "votes" FROM "Song";
DROP TABLE "Song";
ALTER TABLE "new_Song" RENAME TO "Song";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
