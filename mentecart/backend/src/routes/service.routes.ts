import express from "express";

import {
    getServiceById,
    getServices
} from "../controllers/service.controller";

const router = express.Router();

router.get("/", getServices);

router.get("/:id", getServiceById);

export default router;