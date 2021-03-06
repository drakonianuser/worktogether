"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const publicacionControllers_1 = __importDefault(require("../controllers/publicacionControllers"));
class PublicacionRoutes {
    constructor() {
        this.router = express_1.Router();
        this.config();
    }
    config() {
        this.router.get('/api/:idproyecto', publicacionControllers_1.default.list);
        this.router.get('/api/:idproyecto/:detalle', publicacionControllers_1.default.onepublicacion);
        this.router.post('/api/', publicacionControllers_1.default.create);
        this.router.put('/api/:id', publicacionControllers_1.default.update);
        this.router.delete('/api/:idpublicaciones', publicacionControllers_1.default.Delete);
    }
}
const publicacionRoutes = new PublicacionRoutes();
exports.default = publicacionRoutes.router;
