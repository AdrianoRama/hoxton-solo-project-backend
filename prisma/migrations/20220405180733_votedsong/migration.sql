/*
  Warnings:

  - Added the required column `songId` to the `VotedSong` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_VotedSong" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "songId" INTEGER NOT NULL
);
INSERT INTO "new_VotedSong" ("id") SELECT "id" FROM "VotedSong";
DROP TABLE "VotedSong";
ALTER TABLE "new_VotedSong" RENAME TO "VotedSong";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
