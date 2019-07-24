'use strict';
module.exports = (sequelize, DataTypes) => {
  const Regla = sequelize.define('Regla', {
    descripcion: { 
      type:DataTypes.STRING,
      allowNull: false
    },
    estado: DataTypes.DECIMAL(2, 0),
    permite_aprobacion: { 
      type: DataTypes.CHAR(1),
      defaultValue: false
    },
    usuario_modificacion: DataTypes.STRING(50),
    fecha_modificacion: DataTypes.DATE
  }, {
    timestamps: false,
    underscored: true,
    freezeTableName: true,
    tableName: 'tbl_ace_reglas'
  });
  Regla.associate = function(models) {
    // associations can be defined here
    Regla.belongsTo(models.TipoRegla);
    // Regla.hasOne(models.TipoRegla, {
    //   foreingKey: 'id_tipo_regla',
    //   as: 'tipoRegla'
    // });
  };
  return Regla;
};