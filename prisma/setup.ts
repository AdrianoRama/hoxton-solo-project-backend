import { Prisma, PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";
const prisma = new PrismaClient({ log: ["query", "info", "warn", "error"] });

const users: Prisma.UserCreateInput[] = [
    {
        uniqueCode: 'adriano123'
    },
    {
        uniqueCode: 'alban123'
    }
];


async function createStuffs() {
    for (const user of users) {
        await prisma.user.create({ data: user });
    }
}
createStuffs();