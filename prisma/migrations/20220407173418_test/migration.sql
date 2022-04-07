/*
  Warnings:

  - You are about to drop the column `songId` on the `User` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "uniqueCode" TEXT NOT NULL
);
INSERT INTO "new_User" ("id", "uniqueCode") SELECT "id", "uniqueCode" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_uniqueCode_key" ON "User"("uniqueCode");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
