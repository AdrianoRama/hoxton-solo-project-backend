-- CreateTable
CREATE TABLE "_UserToVotedSong" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "VotedSong" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "_UserToVotedSong_AB_unique" ON "_UserToVotedSong"("A", "B");

-- CreateIndex
CREATE INDEX "_UserToVotedSong_B_index" ON "_UserToVotedSong"("B");
