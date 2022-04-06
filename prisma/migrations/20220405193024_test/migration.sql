/*
  Warnings:

  - You are about to drop the column `userId` on the `VotedSong` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_VotedSong" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "songId" INTEGER NOT NULL
);
INSERT INTO "new_VotedSong" ("id", "songId") SELECT "id", "songId" FROM "VotedSong";
DROP TABLE "VotedSong";
ALTER TABLE "new_VotedSong" RENAME TO "VotedSong";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
