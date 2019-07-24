var axios = require('axios');
var express = require('express');
var router = express.Router();
const models = require('../models');

/* GET reglas listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/validarOrden', async (req, res, next) => {
  try {
    
    let prodRegla = await models.ProductoRegla.findAll({
      include: [
        { 
          model: models.Regla,
          required: true
        },
        {
          model: models.TipoProducto,
          required: true,
          where: { codigo: req.body.producto }
        }
      ],
      where: { estado: 1 }
    });

    if (esAutogestion(req.body, prodRegla)) {
      res.statusMessage = 'Regla violada';
      res.status(210)
        .send({ mensaje: 'La autogestión no está permitida' });
      return;
    }
    if (tipoReglaHabilitada(prodRegla, 2))
      axios.all([
        axios.get(`http://api-realacionados:3001/relaciones/${ req.body.idAsesor }/${ req.body.idCliente }`),
        axios.get(`http://api-realacionados:3001/relaciones/${ req.body.idAsesor }/${ req.body.idAcudiente }`)])
        .then(axios.spread((result1, result2) => {
          if(result1.data.relacion === 'NO_RELACIONADO' && result2.data.relacion === 'NO_RELACIONADO'){
            res.send({ status: "OK" });
            return;
          } else {
            res.statusMessage = 'Regla violada';
            res.status(210)
              .send({ mensaje: 'Existe un parentezco entre el asesor y el cliente' });
            return;
          }
        })).catch((err) => {
          console.log(err);
          res.send({ status: "OK" });
          return;
        });
    else res.send({ status: "OK" });
  } catch (error) {
    res.status(500).send({ error });
  }
});

function esAutogestion(orden, prodRegla) {
  return tipoReglaHabilitada(prodRegla, 1) && (orden.idAsesor === orden.idCliente ||
    orden.idAsesor === orden.idAcudiente);
}

function tipoReglaHabilitada(prodRegla, tipoReglaId) {
  if (!prodRegla) return false;

  const regla = prodRegla.find(pr => pr.Regla.TipoReglaId === tipoReglaId);
  if (regla) return true;
  return false;
}

module.exports = router;