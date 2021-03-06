import { Request, Response } from "express";

import pool from "../database";

class ProjectsController {
    constructor() {

    }

    public async list(req: Request, res: Response) {
        const { idproyecto } = req.params;
        const publicaciones = await pool.query('SELECT * FROM publicaciones WHERE idpublicaciones = ?',[idproyecto]);
        const j = publicaciones;
        let detallers:JSON[]= new Array(j.length) ;
        for (let index = 0; index < j.length; index++) {
            const element = j[index];
            const de = await pool.query('SELECT * FROM detallepublicacion where iddetallepublicacion = ?', [element['detallepublicacion_iddetallepublicacion']]);
            detallers[index] = de[0];
        }
        res.json({"publicacion":publicaciones,"detalles":detallers});
    }

    /**
     * one 
    */
    public async onepublicacion(req: Request, res: Response): Promise<any> {
        const { id } = req.params;
        const project = await pool.query('SELECT * FROM detallepublicacion WHERE iddetallepublicacion = ?', [id]);
        if (project.length > 0) {
            return res.json(project[0]);
        }
        res.status(404).json({ text: "La publicacion  no existe" });
    }

    /**
     * create 
     */
    public async create(req: Request, res: Response): Promise<void> {
        console.log(req.body);
        const respuesta = await pool.query('INSERT INTO detallepublicacion set ?', [req.body]);
        res.send("detallepublicacion create");
        console.log(respuesta);

    }


    /**
     * update
     */
    public async update(req: Request, res: Response): Promise<any> {
        const { id } = req.params;
        await pool.query('UPDATE detallepublicacion SET ? WHERE iddetallepublicacion = ?'[req.body, id]);
        res.json({ message: "El detallepublicacion fue actualizado" });
    }

}

const projectscontroller = new ProjectsController();
export default projectscontroller;