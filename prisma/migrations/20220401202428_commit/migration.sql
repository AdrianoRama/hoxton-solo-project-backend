-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "uniqueCode" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Song" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "clientName" TEXT NOT NULL,
    "songTitle" TEXT NOT NULL,
    "artist" TEXT NOT NULL,
    "songUrl" TEXT NOT NULL,
    "votes" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_uniqueCode_key" ON "User"("uniqueCode");
