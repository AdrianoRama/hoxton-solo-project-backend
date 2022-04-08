import express, { json, response } from "express";
import { PrismaClient } from "@prisma/client";
import cors from "cors";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import "dotenv/config";

const app = express();
app.use(cors());
app.use(express.json());
const prisma = new PrismaClient({ log: ["error", "warn", "query", "warn"] });
const PORT = 4000;

app.get("/users", async (req, res) => {
    const users = await prisma.user.findMany({ include: { votedSongs: true } });

    res.send(users);
});

app.get("/users/:id", async (req, res) => {
    let id = Number(req.params.id)
    const user = await prisma.user.findUnique({ where: { id: id }, include: { votedSongs: true } });

    res.send(user);
});

app.get("/songs", async (req, res) => {
    const songs = await prisma.song.findMany();

    res.send(songs);
});

app.get("/songs/:id", async (req, res) => {
    const id = Number(req.params.id)
    const song = await prisma.song.findUnique({ where: { id: id } });

    res.send(song);
});

app.get("/votedsongs", async (req, res) => {
    const votedSongs = await prisma.votedSong.findMany()

    res.send(votedSongs)
})

function createToken(id: number) {
    //@ts-ignore
    return jwt.sign({ id: id }, process.env.MY_SECRET);
}

async function getUserFromToken(token: string) {
    //@ts-ignore
    const decodedData = jwt.verify(token, process.env.MY_SECRET);
    const user = await prisma.user.findUnique({
        //@ts-ignore
        where: { id: decodedData.id }
    });
    return user;
}

app.post("/login", async (req, res) => {
    const uniqueCode = req.body.uniqueCode;

    try {
        const user = await prisma.user.findUnique({
            where: { uniqueCode: uniqueCode }
        });

        if (user) {
            res.send({ user, token: createToken(user.id) });
        } else {
            throw Error("Something went wrong!");
        }
    } catch (err) {
        // @ts-ignore
        res.status(400).send({ error: 'Name or Unique Code Invalid' });
    }
});

app.post("/songs", async (req, res) => {
    const { userId, clientName, songTitle, artist, songUrl } = req.body;

    try {
        const song = await prisma.song.create({
            data: {
                userId: userId,
                clientName: clientName,
                songTitle: songTitle,
                artist: artist,
                songUrl: songUrl,
                votes: 0
            }
        });
        res.send(song);
    } catch (err) {
        // @ts-ignore
        res.status(400).send({ error: err.message });
    }
});

app.delete(`/songs/:id`, async (req, res) => {
    const id = Number(req.params.id)

    try {
        const song = await prisma.song.delete({ where: { id: id } })
        res.send(song)
    }
    catch (error) {
        res.status(400).send({ error: error })
    }
})

app.post("/votedsongs", async (req, res) => {
    const { id, songId, votes } = req.body;
    try {
        const user = await prisma.user.update({
            where: { id: id },
            data: {
                votedSongs: {
                    create: {
                        songId: songId
                    }
                }
            }, include: { votedSongs: true }
        });

        const song = await prisma.song.update({
            where: { id: songId },
            data: {
                votes: votes + 1
            }
        })
        const songs = await prisma.song.findMany()

        res.send({ songs, user })
    } catch (err) {
        // @ts-ignore
        res.status(400).send({ error: err.message });
    }
});

app.get("/validate", async (req, res) => {
    const token = req.headers.authorization || "";
    try {
        const user = await getUserFromToken(token);
        res.send(user);
    } catch (err) {
        // @ts-ignore
        console.log(err.message)
        // @ts-ignore
        res.status(400).send({ error: "Invalid Token" });
    }
});


app.listen(PORT, () => {
    console.log(`Server up: http://localhost:${PORT}`);
});
