import { Request, Response } from "express";

import pool from "../database";

class ComentariosController {
    constructor() {

    }

    public async list(req: Request, res: Response) {
        const { iddocumento } = req.params;
        //const comentarios = await pool.query('SELECT * FROM comentarios where iddocumento = ? ',[iddocumento]);
        const comentarios = await pool.query('SELECT * FROM comentarios ');
        res.json(comentarios);
    }


    /**
     * create 
     * este metodo espara crear una nueva categoria
     * resive el nombre de la nueva categoria atrabes de un json 
     */
    public async create(req: Request, res: Response): Promise<void> {
        await pool.query('INSERT INTO comentarios SET ?', [req.body]);
        res.send("comentario create");
    }


    /**
     * update
     * este metodo espara corregir alguna comentarios
     * resive el identificador atrabes de la ruta y el json con el nombre de la categoria corregido 
     */
    public async update(req: Request, res: Response): Promise<any> {
        const { id } = req.params;
        await pool.query('UPDATE comentarios SET ? WHERE idcomentarios = ?',[req.body, id]);
        res.json({ message: "El comentarios fue actualizado" });
    }

    /**
     * Delete  
     * este metodo esta para eliminar una categoria en caso de que esta no sea de utilidad 
     * resive el identificador de la categoria atrabes de la ruta y elimina la categoria 
     * de la base de datos 
     */
    public async Delete(req: Request, res: Response): Promise<void> {
        const { id } = req.params;
        await pool.query('delete from worktogether.comentario where idcomentarios =?', [id]);
    }

}

const comentariosController = new ComentariosController();
export default comentariosController;