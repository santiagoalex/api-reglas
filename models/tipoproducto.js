'use strict';
module.exports = (sequelize, DataTypes) => {
  const TipoProducto = sequelize.define('TipoProducto', {
    id: { 
      type:DataTypes.SMALLINT,
      allowNull: false,
      autoIncrement: true,
      primaryKey: true
    },
    nombre: DataTypes.STRING(50),
    codigo: DataTypes.STRING(50)
  }, {
    timestamps: false,
    underscored: true,
    freezeTableName: true,
    tableName: 'tbl_ace_tipos_producto'
  });
  TipoProducto.associate = function(models) {
    // associations can be defined here
  };
  return TipoProducto;
};