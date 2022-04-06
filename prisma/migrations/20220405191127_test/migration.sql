/*
  Warnings:

  - You are about to drop the `_UserToVotedSong` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `userId` to the `VotedSong` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "_UserToVotedSong_B_index";

-- DropIndex
DROP INDEX "_UserToVotedSong_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_UserToVotedSong";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_VotedSong" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "songId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL
);
INSERT INTO "new_VotedSong" ("id", "songId") SELECT "id", "songId" FROM "VotedSong";
DROP TABLE "VotedSong";
ALTER TABLE "new_VotedSong" RENAME TO "VotedSong";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
