"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const database_1 = __importDefault(require("../database"));
class CategoriaController {
    constructor() {
    }
    list(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const Categoria = yield database_1.default.query('SELECT * FROM categoria');
            res.json(Categoria);
        });
    }
    /**
     * one
    */
    one(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const project = yield database_1.default.query('SELECT * FROM categoria WHERE idcategoria = ?', [id]);
            if (project.length > 0) {
                return res.json(project[0]);
            }
            res.status(404).json({ text: "la categoria no existe" });
        });
    }
    /**
     * create
     * este metodo espara crear una nueva categoria
     * resive el nombre de la nueva categoria atrabes de un json
     */
    create(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            yield database_1.default.query('INSERT INTO categoria set ?', [req.body]);
            res.send("categoria create");
        });
    }
    /**
     * update
     * este metodo espara corregir alguna categoria
     * resive el identificador atrabes de la ruta y el json con el nombre de la categoria corregido
     */
    update(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            yield database_1.default.query('UPDATE categoria SET ? WHERE idcategoria = ?'[req.body, id]);
            res.json({ message: "El categoria fue actualizado" });
        });
    }
    /**
     * Delete
     * este metodo esta para eliminar una categoria en caso de que esta no sea de utilidad
     * resive el identificador de la categoria atrabes de la ruta y elimina la categoria
     * de la base de datos
     */
    Delete(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            yield database_1.default.query('delete from worktogether.categoria where idcategoria =?', [id]);
            res.json({ message: "categoria eliminada" });
        });
    }
}
const categoriaController = new CategoriaController();
exports.default = categoriaController;
