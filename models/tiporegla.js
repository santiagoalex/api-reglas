'use strict';
module.exports = (sequelize, DataTypes) => {
  const TipoRegla = sequelize.define('TipoRegla', {
    id: { 
      type:DataTypes.SMALLINT,
      allowNull: false,
      autoIncrement: true,
      primaryKey: true
    },
    descripcion: DataTypes.STRING(100),
    es_multi_producto: DataTypes.CHAR(1)
  }, {
    timestamps: false,
    underscored: true,
    freezeTableName: true,
    tableName: 'tbl_ace_tipos_regla'
  });
  TipoRegla.associate = function(models) {
    // associations can be defined here
    TipoRegla.belongsTo(models.Regla);
  };TipoRegla.associate = function(models) {
    // associations can be defined here
    TipoRegla.belongsTo(models.Regla);
  };
  return TipoRegla;
};