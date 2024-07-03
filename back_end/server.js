const express = require('express')
const app = express()
const cors = require('cors')
const mariadb = require('./bdd.js')

app.use(cors())
app.use(express.json())

const port = 8000

// Helper function to convert BigInt to string in the result set
function stringifyBigInt(obj) {
    if (obj === null || obj === undefined) return obj;
    if (typeof obj === 'bigint') return obj.toString();
    if (typeof obj === 'object') {
        for (const key in obj) {
            if (typeof obj[key] === 'bigint') {
                obj[key] = obj[key].toString();
            } else if (typeof obj[key] === 'object') {
                obj[key] = stringifyBigInt(obj[key]);
            }
        }
    }
    return obj;
}

// Catégories

// Voir les catégories
app.get('/categories', async (req, res) => {
    console.log("Request for categories")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for categories")
        const sql = await conn.query("SELECT * FROM catégories")
        res.status(200).json(sql)
        console.log("Categories sent")
    }
    catch(err){
        console.log(err)
        res.status(500).json(err)
    }
})

// Voir les articles par catégorie
app.get('/categories/artciles/:id_cat', async (req, res) => {
    console.log("Request for articles by category")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for articles by category")
        const sql = await conn.query("SELECT * FROM articles WHERE id_cat = ?", [req.params.id_cat])
        res.status(200).json(sql)
        console.log("Articles by category sent")
    }
    catch(err){
        console.log(err)
        res.status(500).json(err)
    }
})

// Articles

// Voir tous les articles
app.get('/articles', async (req, res) => {
    console.log("Request for articles")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for articles")
        const sql = await conn.query("SELECT * FROM articles")
        res.status(200).json(sql)
        console.log("Articles sent")
    }
    catch(err){
        console.log(err)
        res.status(500).json(err)
    }
})

// Voir un article
app.get('/articles/:id_art', async (req, res) => {
    console.log("Request for article by id")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for article by id")
        const sql = await conn.query("SELECT * FROM articles WHERE id_art = ?", [req.params.id_art])
        res.status(200).json(sql)
        console.log("Article by id sent")
    }
    catch(err){
        console.log(err)
        res.status(500).json(err)
    }
})

// Ajouter un article
app.post('/articles', async (req, res) => {
    console.log("Request for articles")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for post articles")
        const sql = await conn.query("INSERT INTO articles(nom_art, createur_art, duree, date_crea, id_cat) VALUES (?, ?, ?, ?, ?)", [req.body.nom_art, req.body.createur_art, req.body.duree, req.body.date_crea, req.body.id_cat])
        res.status(200).json(stringifyBigInt(sql));
        console.log("Articles posted")
    } catch(err){
        console.log(err)
        res.status(500).json(err)
    }
  });

// Notation

// Voir les notes
app.get('/notes', async (req, res) => {
    console.log("Request for notes")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for notes")
        const sql = await conn.query("SELECT * FROM notes")
        res.status(200).json(sql)
        console.log("Notes sent")
    }
    catch(err){
        console.log(err)
        res.status(500).json(err)
    }
})

// Ajouter une note
app.post('/notes', async (req, res) => {
    console.log("Request for notes")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for post notes")
        const sql = await conn.query("INSERT INTO notes(note, id_art) VALUES (?, ?)", [req.body.note, req.body.id_art])
        res.status(200).json(stringifyBigInt(sql));
        console.log("Notes posted")
    }
    catch(err){
        console.log(err)        
        res.status(500).json(err)
    }
})

// Voir le top 5 des notes
app.get('/notes/top', async (req, res) => {
    console.log("Request for top notes")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for top notes")
        const sql = await conn.query("SELECT * FROM notes ORDER BY note DESC LIMIT 5")
        res.status(200).json(sql)
        console.log("Top notes sent")
    }
    catch(err){
        console.log(err)
        res.status(500).json(err)
    }
})

// Voir le top 5 des notes par catégorie
app.get('/notes/top/:id_cat', async (req, res) => {
    console.log("Request for top notes by category")
    let conn;
    try{
        let id_cat = parseInt(req.params.id_cat);
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for top notes by category")
        const sql = await conn.query("SELECT a.id_art, a.nom_art, a.createur_art, a.duree, a.date_crea, a.id_cat, AVG(n.note) AS moyenne_notes FROM articles AS a JOIN notes AS n ON a.id_art = n.id_art WHERE a.id_cat = ? GROUP BY a.id_art ORDER BY moyenne_notes DESC LIMIT 5;", [id_cat])
        res.status(200).json(sql)
        console.log("Top notes by category sent")
        conn.release()
    }
    catch(err){
        console.log(err)
        res.status(500).json(err)
    }
})

// Voir les notes par article
app.get('/notes/artciles/:id_art', async (req, res) => {
    console.log("Request for notes by article")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for notes by article")
        const sql = await conn.query("SELECT * FROM notes WHERE id_art = ?", [req.params.id_art])
        res.status(200).json(sql)
        console.log("Notes by article sent")
    }
    catch(err){
        console.log(err)
        res.status(500).json(err)
    }
})

// Moyenne des notes par article
app.get('/notes/moyenne/:id_art', async (req, res) => {
    console.log("Request for mean notes by article")
    let conn;
    try{
        conn = await mariadb.pool.getConnection()
        console.log("Connection established for mean notes by article")
        const sql = await conn.query("SELECT AVG(note) FROM notes WHERE id_art = ?", [req.params.id_art])
        res.status(200).json(sql)
        console.log("Mean notes by article sent")
    }
    catch(err){
        console.log(err)
        res.status(500).json(err)
    }
})

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`)
})
