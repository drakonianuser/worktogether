import { Router } from "express";

import detallePublicacionController from "../controllers/detallePublicacionController";

class DetallePublicacionRoutes {

    public router: Router = Router();
    constructor() {
        this.config();
    }

    config(): void {
        this.router.get('/api/:idproyecto', detallePublicacionController.list);
        this.router.get('/api/:id/:detalle', detallePublicacionController.onepublicacion);
        this.router.post('/api/', detallePublicacionController.create);
        this.router.put('/api/:id', detallePublicacionController.update);
    }
}

const detallePublicacionRoutes = new DetallePublicacionRoutes();
export default detallePublicacionRoutes.router;