/*
  Warnings:

  - Added the required column `songId` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "uniqueCode" TEXT NOT NULL,
    "songId" INTEGER NOT NULL,
    CONSTRAINT "User_songId_fkey" FOREIGN KEY ("songId") REFERENCES "Song" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_User" ("id", "uniqueCode") SELECT "id", "uniqueCode" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_uniqueCode_key" ON "User"("uniqueCode");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
